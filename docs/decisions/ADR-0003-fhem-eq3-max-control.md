# ADR-0003: FHEM for EQ3 MAX Thermostat Control

**Status:** Accepted  
**Date:** 26 October 2025  
**Updated:** 5 January 2025  
**Supersedes:** N/A  
**Superseded by:** N/A

## Context

We have existing EQ3 MAX radiator thermostats installed throughout the house. These thermostats are end-of-life products where the manufacturer has stopped support, and the original MAX Cube controller has become unstable and unreliable.

**Problems with current situation:**
- MAX Cube fails periodically and requires restart
- No official integration to modern smart home platforms
- Hardware still works perfectly, but lacks controller
- Proprietary closed-source software without community support
- Risk of complete loss of heating control if Cube fails

**The challenge:**
We need a reliable way to control existing thermostats without having to replace all hardware (expensive and labour-intensive), whilst ensuring the solution can integrate with our Home Assistant-based smart home setup.

**Update 5 January 2025:**
The MAX Cube is now completely out of the project. Attempts to flash it to CUNX firmware failed due to hardware incompatibility (specific hardware version does not support DFU mode). The decision to use FHEM with USB CUL dongle remains valid and is now the only viable path forward.

## Alternatives Considered

### Alternative 1: Native Home Assistant Integration
Use community HACS integration for MAX.

**Advantages:**
- Everything in Home Assistant - no extra software
- Unified interface

**Disadvantages:**
- Community plugins are unstable and poorly maintained
- Many users report connectivity issues
- Python libraries for MAX protocol are immature
- Risks same problems as MAX Cube

**Conclusion:** Too risky for critical infrastructure like heating.

### Alternative 2: Replace All Hardware
Purchase new Zigbee/Z-Wave thermostats.

**Advantages:**
- Modern hardware with good HA support
- No legacy protocol issues
- Better features (battery life, precision)

**Disadvantages:**
- Expensive (15-20 thermostats × 400-600 kr = 6000-12000 kr)
- Time-consuming installation
- Current hardware works fine
- Cannot reuse investment in MAX ecosystem

**Conclusion:** Economically unattractive when hardware is functional.

### Alternative 3: Keep MAX Cube
Continue using MAX Cube as-is.

**Advantages:**
- No changes necessary
- Known system

**Disadvantages:**
- Unreliable and failing
- No integration with HA
- Closed source - cannot be debugged or fixed
- Manufacturer has dropped support
- Single point of failure

**Conclusion:** Not a long-term solution.

**Update 5 January 2025:** This alternative is now impossible - hardware cannot be flashed to CUNX and original firmware is too unreliable. MAX Cube has been retired from the project.

### Alternative 4: FHEM on Raspberry Pi
Use FHEM with USB CUL/CUN dongle for direct MAX control.

**Advantages:**
- Mature MAX protocol implementation
- Active community and ongoing maintenance
- Open source - can be debugged and customised
- Direct RF communication - no Cube necessary
- Separation of concerns - heating isolated from HA
- Can integrate with HA via MQTT

**Disadvantages:**
- Extra software to maintain
- Learning curve for FHEM
- Requires USB CUL/CUN dongle (~200-400 kr)

**Conclusion:** Best balance between reliability, cost and future-proofing.

## Decision

**We implement FHEM on Raspberry Pi 3 as dedicated heating controller.**

**Technical setup:**
- FHEM installed on existing Raspberry Pi 3
- USB CUL/CUN dongle handles RF communication to thermostats
- MQTT used for integration with Home Assistant
- Two-phase approach: First standalone FHEM, later HA integration

**Rationale:**
- FHEM is the most mature solution for EQ3 MAX
- Separation of concerns - heating is critical and should be robust
- Raspberry Pi can run 24/7 without dependency on HA
- MQTT provides flexible integration without tight coupling
- Open source gives full control and debugging possibilities

**Update 5 January 2025:**
This decision is now the only viable path. The MAX Cube hardware cannot be used (incompatible with CUNX flashing), so USB CUL dongle is required. See ADR-0005 for details on why the CUNX alternative was rejected.

## Consequences

### Positive

**Technical advantages:**
- Stable and reliable heating control
- Full control over legacy hardware
- Can be debugged and customised as needed
- Graceful degradation - heating functions even if HA goes down

**Economic advantages:**
- Reuses existing hardware investment
- Minimal cost (only USB dongle)
- Postpones need for expensive hardware replacement

**Architectural advantages:**
- Follows separation of concerns principle
- MQTT integration layer makes components replaceable
- Can migrate to different controller later without changing HA

### Negative

**Complexity:**
- Extra system to maintain (FHEM)
- New technology to learn
- More complex troubleshooting when problems occur

**Dependencies:**
- Requires Raspberry Pi runs 24/7
- USB dongle is single point of failure (but easy to replace)
- MQTT broker must be stable

**Technical debt:**
- Legacy protocol support remains necessary
- Migration to modern hardware still attractive in long term

### Mitigations

**For complexity:**
- Thorough documentation of FHEM setup
- Technical guides for troubleshooting
- Gradual implementation (start with few thermostats)

**For dependencies:**
- Raspberry Pi dedicated to heating - minimal uptime risk
- Backup USB dongle (low cost)
- MQTT broker can run on RPi together with FHEM

**For legacy technology:**
- Architecture designed so FHEM can be replaced later
- MQTT interface preserved during future migration
- Plan for gradual hardware replacement over several years

## Follow-up Actions

1. **Immediate:**
   - [x] ~~Order USB CUL/CUN dongle~~ - Status: Pending purchase
   - [ ] Install FHEM on Raspberry Pi
   - [ ] Test with one thermostat as proof-of-concept

2. **Short term:**
   - [ ] Pair all thermostats with FHEM
   - [ ] Implement basic time-based profiles
   - [ ] Verify stability over 1-2 weeks

3. **Medium term:**
   - [ ] Implement MQTT integration
   - [ ] Create Home Assistant dashboard
   - [ ] Migrate advanced automations to HA

4. **Long term:**
   - [ ] Monitor for modern MAX-compatible thermostats
   - [ ] Consider gradual migration to Zigbee when budget allows
   - [ ] Evaluate alternative controllers if FHEM becomes problematic

## References

- [FHEM MAX Module Documentation](https://wiki.fhem.de/wiki/MAX)
- [USB CUL/CUN Hardware](https://wiki.fhem.de/wiki/CUL)
- [EQ3 MAX Protocol Analysis](https://github.com/Bouni/max-cube-protocol)

## Related Documents

- [heating-concept.md](../guides/heating-concept.md) - Detailed concept document
- [FHEM-installation-guide.md](../guides/FHEM-installation-guide.md) - Technical installation guide
- [ADR-0004-mqtt-integration-layer.md](ADR-0004-mqtt-integration-layer.md) - MQTT as integration layer
- [ADR-0005-flash-max-cube-to-cunx.md](ADR-0005-flash-max-cube-to-cunx.md) - Why MAX Cube flash failed

---

**This decision reflects the project's core principles:**
- Only implement new solutions when they offer **unique functionality** (FHEM has mature MAX support)
- Can **replace existing** problematic solution (unstable MAX Cube)
- Home Assistant remains centre via MQTT integration