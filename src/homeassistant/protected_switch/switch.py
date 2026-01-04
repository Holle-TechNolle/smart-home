"""Protected Switch platform - wraps switches with power-based turn-off protection."""
import logging
import voluptuous as vol

from homeassistant.helpers import discovery

from homeassistant.components.switch import (
    PLATFORM_SCHEMA,
    SwitchEntity,
)
from homeassistant.const import (
    CONF_NAME,
    STATE_ON,
    STATE_OFF,
    STATE_UNAVAILABLE,
    STATE_UNKNOWN,
)
import homeassistant.helpers.config_validation as cv
from homeassistant.core import HomeAssistant, callback
from homeassistant.helpers.entity_platform import AddEntitiesCallback
from homeassistant.helpers.typing import ConfigType, DiscoveryInfoType
from homeassistant.helpers.event import async_track_state_change_event

_LOGGER = logging.getLogger(__name__)

DOMAIN = "protected_switch"

CONF_SWITCH_ENTITY = "switch_entity"
CONF_POWER_SENSOR = "power_sensor"
CONF_THRESHOLD = "threshold"
CONF_NOTIFY = "notify"

DEFAULT_THRESHOLD = 100
DEFAULT_NOTIFY = True

PLATFORM_SCHEMA = PLATFORM_SCHEMA.extend(
    {
        vol.Required(CONF_NAME): cv.string,
        vol.Required(CONF_SWITCH_ENTITY): cv.entity_id,
        vol.Required(CONF_POWER_SENSOR): cv.entity_id,
        vol.Optional(CONF_THRESHOLD, default=DEFAULT_THRESHOLD): vol.Coerce(float),
        vol.Optional(CONF_NOTIFY, default=DEFAULT_NOTIFY): cv.boolean,
    }
)


async def async_setup_platform(
    hass: HomeAssistant,
    config: ConfigType,
    async_add_entities: AddEntitiesCallback,
    discovery_info: DiscoveryInfoType | None = None,
) -> None:
    """Set up Protected Switch platform."""
    
    _LOGGER.info("Protected Switch platform setup starting")
    
    # Get config from hass.data (set in __init__.py)
    if DOMAIN not in hass.data:
        _LOGGER.error("Protected Switch data not found in hass.data")
        return
    
    _LOGGER.info(f"Found {len(hass.data[DOMAIN])} protected switch(es) in config")
    
    switches = []
    sensor_discovery = []
    
    for switch_config in hass.data[DOMAIN]:
        name = switch_config.get('name')
        _LOGGER.info(f"Creating protected switch: {name}")
        
        # Create the switch entity
        switches.append(
            ProtectedSwitch(
                hass,
                switch_config[CONF_NAME],
                switch_config[CONF_SWITCH_ENTITY],
                switch_config[CONF_POWER_SENSOR],
                switch_config[CONF_THRESHOLD],
                switch_config[CONF_NOTIFY],
            )
        )
        
        # Prepare sensor discovery
        sensor_discovery.append({
            'name': f"{name} Power",
            'power_sensor': switch_config[CONF_POWER_SENSOR],
        })
    
    # I async_setup_platform:
    async_add_entities(switches, True)
    _LOGGER.info(f"Added {len(switches)} protected switch(es)")
    
    # Discover sensors on sensor platform
    if sensor_discovery:
        await discovery.async_load_platform(
            hass,
            'sensor',
            DOMAIN,
            sensor_discovery,
            config,
        )


class ProtectedSwitch(SwitchEntity):
    """Representation of a Protected Switch."""

    def __init__(
        self,
        hass: HomeAssistant,
        name: str,
        switch_entity: str,
        power_sensor: str,
        threshold: float,
        notify: bool,
    ) -> None:
        """Initialize the Protected Switch."""
        self.hass = hass
        self._attr_name = name
        self._switch_entity = switch_entity
        self._power_sensor = power_sensor
        self._threshold = threshold
        self._notify = notify
        self._attr_unique_id = f"protected_{switch_entity}"
        self._attr_is_on = None
        self._attr_available = True

    async def async_added_to_hass(self) -> None:
        """Run when entity about to be added to hass."""
        # Track state changes of underlying switch
        @callback
        def _async_state_changed_listener(event):
            """Handle underlying switch state changes."""
            self.async_schedule_update_ha_state(True)
        
        async_track_state_change_event(
            self.hass, [self._switch_entity], _async_state_changed_listener
        )

    async def async_update(self) -> None:
        """Update the state from the underlying switch."""
        switch_state = self.hass.states.get(self._switch_entity)
        
        if switch_state is None:
            _LOGGER.debug(f"Switch entity {self._switch_entity} not found (might be loading)")
            self._attr_available = False
            self._attr_is_on = None
            return
        
        if switch_state.state in (STATE_UNAVAILABLE, STATE_UNKNOWN):
            _LOGGER.debug(f"Switch {self._switch_entity} is {switch_state.state}")
            self._attr_available = False
            self._attr_is_on = None
            return
        
        _LOGGER.debug(f"Switch {self._switch_entity} state: {switch_state.state}")
        self._attr_available = True
        self._attr_is_on = switch_state.state == STATE_ON

    @property
    def is_on(self) -> bool | None:
        """Return true if switch is on."""
        return self._attr_is_on

    @property
    def available(self) -> bool:
        """Return True if entity is available."""
        return self._attr_available

    @property
    def extra_state_attributes(self) -> dict:
        """Return extra state attributes."""
        attributes = {
            "power_threshold": self._threshold,
            "underlying_switch": self._switch_entity,
            "power_sensor": self._power_sensor,
        }
        
        # Add current power consumption
        power_state = self.hass.states.get(self._power_sensor)
        if power_state and power_state.state not in (STATE_UNAVAILABLE, STATE_UNKNOWN):
            try:
                attributes["current_power"] = float(power_state.state)
            except (ValueError, TypeError):
                _LOGGER.debug(f"Could not convert power value to float: {power_state.state}")
                attributes["current_power"] = None
        else:
            attributes["current_power"] = None
        
        return attributes

    async def async_turn_on(self, **kwargs) -> None:
        """Turn the switch on - always allowed."""
        await self.hass.services.async_call(
            "switch",
            "turn_on",
            {"entity_id": self._switch_entity},
            blocking=True,
        )
        _LOGGER.debug(f"Turned on {self._switch_entity}")

    async def async_turn_off(self, **kwargs) -> None:
        """Turn the switch off - only if power is below threshold."""
        # Get current power
        power_state = self.hass.states.get(self._power_sensor)
        
        if power_state is None or power_state.state in (STATE_UNAVAILABLE, STATE_UNKNOWN):
            _LOGGER.warning(
                f"Cannot check power sensor {self._power_sensor} - blocking turn_off for safety"
            )
            if self._notify:
                await self._send_notification(
                    "Turn Off Blocked",
                    "Power sensor unavailable - cannot verify safety"
                )
            return
        
        try:
            current_power = float(power_state.state)
        except (ValueError, TypeError):
            _LOGGER.error(
                f"Invalid power value from {self._power_sensor}: {power_state.state}"
            )
            if self._notify:
                await self._send_notification(
                    "Turn Off Blocked",
                    "Invalid power reading - cannot verify safety"
                )
            return
        
        # Check if power is above threshold
        if current_power > self._threshold:
            _LOGGER.warning(
                f"BLOCKED turn_off on {self._switch_entity} - "
                f"power {current_power}W > threshold {self._threshold}W"
            )
            if self._notify:
                await self._send_notification(
                    "Turn Off Blocked",
                    f"Current power: {current_power}W (threshold: {self._threshold}W). "
                    f"Device appears to be in use."
                )
            # Force state update to reflect actual underlying switch state
            await self.async_update()
            self.async_write_ha_state()
            return
        
        # Safe to turn off
        _LOGGER.info(
            f"Turning off {self._switch_entity} - "
            f"power {current_power}W < threshold {self._threshold}W"
        )
        await self.hass.services.async_call(
            "switch",
            "turn_off",
            {"entity_id": self._switch_entity},
            blocking=True,
        )

    async def _send_notification(self, title: str, message: str) -> None:
        """Send notification via notify service."""
        try:
            await self.hass.services.async_call(
                "notify",
                "notify",
                {
                    "title": title,
                    "message": message,
                },
                blocking=False,
            )
        except Exception as err:
            _LOGGER.error(f"Failed to send notification: {err}")