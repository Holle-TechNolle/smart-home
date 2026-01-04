"""Protected Switch integration - wraps switches with power monitoring."""
import logging
from homeassistant.core import HomeAssistant
from homeassistant.helpers.typing import ConfigType
from homeassistant.helpers import discovery
from homeassistant.const import Platform

_LOGGER = logging.getLogger(__name__)

DOMAIN = "protected_switch"
PLATFORMS = [Platform.SWITCH]


async def async_setup(hass: HomeAssistant, config: ConfigType) -> bool:
    """Set up the Protected Switch component from configuration.yaml."""
    if DOMAIN not in config:
        return True
    
    # Store config for switch platform
    hass.data[DOMAIN] = config[DOMAIN]
    
    _LOGGER.info("Protected Switch integration loaded - forwarding to switch platform")
    
    # Load switch platform
    await discovery.async_load_platform(
        hass, Platform.SWITCH, DOMAIN, {}, config
    )
    
    return True