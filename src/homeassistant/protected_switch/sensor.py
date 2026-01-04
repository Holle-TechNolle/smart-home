"""Sensor platform for Protected Switch."""
import logging
from homeassistant.components.sensor import SensorEntity, SensorDeviceClass, SensorStateClass
from homeassistant.const import STATE_UNAVAILABLE, STATE_UNKNOWN, UnitOfPower
from homeassistant.core import HomeAssistant, callback
from homeassistant.helpers.entity_platform import AddEntitiesCallback
from homeassistant.helpers.typing import ConfigType, DiscoveryInfoType
from homeassistant.helpers.event import async_track_state_change_event

_LOGGER = logging.getLogger(__name__)

DOMAIN = "protected_switch"


async def async_setup_platform(
    hass: HomeAssistant,
    config: ConfigType,
    async_add_entities: AddEntitiesCallback,
    discovery_info: DiscoveryInfoType | None = None,
) -> None:
    """Set up Protected Switch sensor platform."""
    
    if discovery_info is None:
        return
    
    sensors = []
    for sensor_config in discovery_info:
        sensors.append(
            ProtectedSwitchPowerSensor(
                hass,
                sensor_config['name'],
                sensor_config['power_sensor'],
            )
        )
    
    async_add_entities(sensors, True)
    _LOGGER.info(f"Added {len(sensors)} protected switch power sensor(s)")


class ProtectedSwitchPowerSensor(SensorEntity):
    """Power sensor for Protected Switch."""

    def __init__(
        self,
        hass: HomeAssistant,
        name: str,
        power_sensor: str,
    ) -> None:
        """Initialize the power sensor."""
        self.hass = hass
        self._attr_name = name
        self._power_sensor = power_sensor
        self._attr_unique_id = f"protected_{power_sensor}_power"
        self._attr_device_class = SensorDeviceClass.POWER
        self._attr_state_class = SensorStateClass.MEASUREMENT
        self._attr_native_unit_of_measurement = UnitOfPower.WATT
        self._attr_native_value = None
        self._attr_available = True

    async def async_added_to_hass(self) -> None:
        """Run when entity about to be added to hass."""
        @callback
        def _async_state_changed_listener(event):
            """Handle power sensor state changes."""
            self.async_schedule_update_ha_state(True)
        
        async_track_state_change_event(
            self.hass, [self._power_sensor], _async_state_changed_listener
        )

    async def async_update(self) -> None:
        """Update the sensor state."""
        power_state = self.hass.states.get(self._power_sensor)
        
        if power_state is None:
            _LOGGER.debug(f"Power sensor {self._power_sensor} not found (might be loading)")
            self._attr_available = False
            self._attr_native_value = None
            return
        
        if power_state.state in (STATE_UNAVAILABLE, STATE_UNKNOWN):
            _LOGGER.debug(f"Power sensor {self._power_sensor} is {power_state.state}")
            self._attr_available = False
            self._attr_native_value = None
            return
        
        try:
            self._attr_native_value = float(power_state.state)
            self._attr_available = True
        except (ValueError, TypeError):
            _LOGGER.debug(f"Could not convert power value to float: {power_state.state}")
            self._attr_available = False
            self._attr_native_value = None

    @property
    def native_value(self) -> float | None:
        """Return the current power value."""
        return self._attr_native_value

    @property
    def available(self) -> bool:
        """Return True if entity is available."""
        return self._attr_available