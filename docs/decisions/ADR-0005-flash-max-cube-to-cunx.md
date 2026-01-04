# ADR-0005: Flash MAX Cube to CUNX

**Status:** Rejected  
**Date:** 2024-10-26  
**Updated:** 2025-01-05  
**Decision Makers:** Holger (Project Owner)

---

## Context

The EQ3 MAX heating system uses proprietary 868 MHz RF protocol for communication between thermostats and the MAX Cube gateway. FHEM requires RF hardware to communicate with these devices.

**Original Problem:**
- MAX Cube is discontinued and unreliable
- Web-based MAX Cube API has been shut down by manufacturer
- Native MAX Cube integration in Home Assistant no longer works
- Need RF interface for FHEM to control EQ3 MAX thermostats

**Initially Considered Solution:**
Purchase USB CUL/CUN dongle (200-400 DKK) for RF communication.

**Alternative Discovered:**
Flash existing MAX Cube hardware with CULFW firmware to convert it to CUNX (network-connected CUL), avoiding hardware purchase.

---

## Decision

**REJECTED - Hardware incompatible with flashing**

After investigation and attempted implementation, we discovered that the specific MAX Cube hardware version cannot be flashed to CUNX firmware. The hardware does not support the required DFU mode for firmware flashing.

**New Decision:**
- Abandon MAX Cube completely
- Purchase USB CUL dongle as originally planned
- Proceed with standard FHEM setup using USB CUL hardware

---

## Alternatives Considered

### Alternative 1: Flash MAX Cube to CUNX ❌ REJECTED
**Advantages:**
- Zero hardware cost
- Network connectivity more flexible than USB
- Better RF range than typical USB dongles
- Reuse existing hardware

**Disadvantages (Discovered):**
- ❌ **Specific hardware version not flashable**
- ❌ **No DFU mode available on this unit**
- ❌ **Incompatible bootloader**
- One-way conversion (cannot revert)
- All devices must be factory reset and re-paired
- 2-3 hours implementation time (if it worked)

**Why Rejected:**
Hardware incompatibility - the specific MAX Cube unit does not support firmware flashing.

### Alternative 2: Purchase USB CUL/CUN Dongle ✅ CHOSEN
**Advantages:**
- ✅ Well-documented, proven solution
- ✅ Broad FHEM community support
- ✅ Works with standard FHEM setup
- Direct USB connection to Raspberry Pi
- No modification required

**Disadvantages:**
- 200-400 DKK hardware cost
- USB location limited to Raspberry Pi placement
- Potentially shorter RF range than CUNX

**Why Chosen:**
Reliable, proven solution with extensive community support. Hardware cost is acceptable for guaranteed compatibility.

### Alternative 3: Keep MAX Cube as-is ❌ REJECTED
**Why Rejected:**
- Web API shut down by manufacturer
- Unreliable operation
- No integration with modern systems
- Product discontinued

### Alternative 4: Replace entire system with Zigbee/Z-Wave ❌ REJECTED
**Why Rejected:**
- Very high cost (replace all thermostats)
- Not addressing immediate need
- Can be future upgrade path

---

## Consequences

### Positive
- Clear path forward with proven technology
- No risk of bricking hardware
- Standard FHEM documentation applies
- Broad community support available

### Negative
- 200-400 DKK hardware purchase required
- Additional 1-2 week wait for delivery
- USB dongle limits physical placement options

### Neutral
- Implementation timeline unchanged (once hardware arrives)
- All thermostats still need pairing (would be required either way)
- FHEM configuration identical to original plan

---

## Implementation Notes

**MAX Cube Status:**
- Hardware Version: [specific version that cannot be flashed]
- Attempted Flash: Failed - no DFU mode available
- Current Status: Out of project, no longer in use
- Future: Can be discarded or kept as spare parts

**USB CUL Hardware:**
- To Purchase: 868 MHz USB CUL or CUN dongle
- Estimated Cost: 200-400 DKK
- Delivery Time: 1-2 weeks
- Vendor: [TBD - research reliable sellers]

**Next Steps:**
1. Research and purchase USB CUL/CUN dongle
2. Wait for hardware delivery
3. Follow original FHEM installation guide
4. Connect USB dongle to Raspberry Pi
5. Configure FHEM with CUL device
6. Pair thermostats one by one

---

## Related Documents

- **FHEM-installation-guide.md** - Updated to use USB CUL instead of CUNX
- **ADR-0003-fhem-eq3-max-control.md** - Original decision to use FHEM
- **ADR-0004-mqtt-integration-layer.md** - MQTT integration design
- **~~max-cube-to-cunx-flash-guide.md~~** - No longer relevant, archived for reference

---

## Lessons Learned

### Technical Lessons
1. **Not all MAX Cube hardware is created equal** - Different versions have different capabilities
2. **Always verify hardware compatibility before planning** - Check specific version/model
3. **Community documentation may not apply to all variants** - CUNX flashing works for some units, not all
4. **Fallback to proven solutions** - USB CUL is well-tested and reliable

### Process Lessons
1. **Document failures as well as successes** - This ADR now captures what didn't work
2. **Time spent on research is not wasted** - We learned valuable information
3. **Hardware constraints are real** - Cannot software our way out of hardware limitations
4. **Proven solutions have value** - Sometimes the "boring" option is the right choice

### Project Lessons
1. **Keep original plan as backup** - USB CUL was always viable alternative
2. **Budget for hardware** - 200-400 DKK is acceptable for proven solution
3. **Community support matters** - USB CUL has much broader support than CUNX
4. **Don't let perfect be enemy of good** - USB solution will work fine

---

## References

- [FHEM CUL Module Documentation](https://wiki.fhem.de/wiki/CUL)
- [EQ3 MAX Protocol Documentation](https://wiki.fhem.de/wiki/MAX)
- [USB CUL Hardware Options](https://wiki.fhem.de/wiki/CUL#Hardware)
- [CULFW Firmware Compatibility](https://github.com/culfw/culfw/wiki)

---

**Status Update Log:**

**2024-10-26:** Initial decision to flash MAX Cube to CUNX  
**2025-01-05:** Rejected after discovering hardware incompatibility - proceeding with USB CUL purchase