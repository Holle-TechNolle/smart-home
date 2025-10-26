# ADR-0005: Flash MAX Cube to CUNX for RF Control

**Status:** Accepted  
**Date:** 2025-10-26  
**Decision Makers:** Project Owner  
**Related:** ADR-0003 (FHEM for EQ3 MAX Control)

---

## Context

The original plan (ADR-0003) was to purchase a USB CUL/CUN dongle for FHEM to control EQ3 MAX thermostats. However, we discovered that the existing MAX Cube hardware can be reflashed with CULFW firmware to act as a CUNX (network-connected CUL) device.

### Current Situation
- **MAX Cube present:** Already owned, currently unstable
- **MAX Cube value:** Zero - product discontinued, web API shut down in Germany
- **Hardware needed:** 868 MHz RF transceiver for FHEM
- **Original plan:** Purchase USB CUL (~200-400 DKK)

### Technical Background
The MAX Cube uses an Atmel ATmega32U4 microcontroller that can be reflashed with CULFW (CUL firmware). When flashed, it can:
- Act as CUNX (CUL with network interface)
- Communicate via 868 MHz with EQ3 MAX devices
- Be controlled by FHEM over the network
- Provide better control than original MAX Cube firmware

---

## Decision

**Flash the existing MAX Cube with CULFW to create a CUNX device.**

This means:
1. MAX Cube firmware will be replaced with CULFW
2. Device will function as network-connected RF transceiver
3. FHEM will control thermostats via CUNX over network
4. All EQ3 MAX devices must be factory reset and re-paired

---

## Alternatives Considered

### Alternative 1: Purchase USB CUL/CUN dongle
**Pros:**
- Simple plug-and-play solution
- Keep MAX Cube as potential backup
- No firmware flashing required

**Cons:**
- Cost: 200-400 DKK
- USB connection to Raspberry Pi (cabled)
- MAX Cube has no value as backup (API shut down)
- Need to wait for delivery

**Rejected because:** Unnecessary cost when existing hardware can be repurposed.

### Alternative 2: Use MAX Cube with FHEM MAXLAN module
**Pros:**
- No hardware modifications
- No device re-pairing needed

**Cons:**
- Limited FHEM functionality (listen-only mode while Cube controls)
- Known stability issues (original problem)
- MAX Cube software unreliable
- Can't fully replace unstable Cube

**Rejected because:** Doesn't solve the core stability problem.

### Alternative 3: Replace with Zigbee thermostats
**Pros:**
- Modern protocol with better support
- Already have Zigbee dongle

**Cons:**
- High cost (replace all thermostats)
- EQ3 MAX thermostats still functional
- Unnecessary waste

**Rejected because:** EQ3 MAX hardware still works fine, only Cube software is problematic.

---

## Consequences

### Positive
- ✅ **Zero cost:** Uses existing hardware
- ✅ **Better connectivity:** Network connection instead of USB
- ✅ **Better range:** MAX Cube has good RF range
- ✅ **Immediate start:** No waiting for hardware delivery
- ✅ **Repurposes e-waste:** MAX Cube otherwise useless
- ✅ **Full FHEM control:** No Cube software limitations

### Negative
- ⚠️ **Firmware flashing required:** Technical process with some risk
- ⚠️ **One-time effort:** All devices must be factory reset
- ⚠️ **Family downtime:** Heating unavailable during re-pairing (1-2 days)
- ⚠️ **Lost heating curves:** Thermostats must relearn PI control curves

### Neutral
- 🔄 **Irreversible (practically):** Can technically re-flash, but no reason to
- 🔄 **Learning curve:** New CUNX configuration in FHEM

---

## Implementation Plan

### Phase 1: Preparation (1-2 hours)
1. Document all current device addresses from MAX Cube
2. Backup MAX Cube configuration (via MAX software)
3. Download CULFW firmware files
4. Install required flashing tools (Windows: DfuProgrammer)
5. Read flashing guides thoroughly

### Phase 2: Flashing (30-60 minutes)
1. Connect MAX Cube to computer via USB
2. Put MAX Cube in bootloader mode
3. Flash CULFW firmware to MAX Cube
4. Configure as CUNX device with network settings
5. Test basic connectivity

### Phase 3: FHEM Setup (30 minutes)
1. Install FHEM on Raspberry Pi (if not already done)
2. Configure FHEM CUL_MAX module for CUNX
3. Test FHEM can communicate with CUNX

### Phase 4: Device Re-pairing (2-4 hours)
1. Factory reset all EQ3 MAX thermostats
2. Factory reset all window contacts
3. Pair devices one by one to FHEM via CUNX
4. Assign room names and attributes
5. Test basic temperature control

### Phase 5: Configuration (1-2 hours)
1. Configure time-based heating schedules
2. Associate window contacts with thermostats
3. Test automation scenarios
4. Let system stabilize for 1-2 weeks

**Total estimated time:** 6-10 hours spread over 2-3 days  
**Family impact:** Plan when family can be away for 1-2 days

---

## Risks and Mitigations

### Risk: Flashing fails and bricks MAX Cube
**Likelihood:** Low (well-documented process)  
**Impact:** High (need to purchase USB CUL)  
**Mitigation:** 
- Follow guides carefully
- Use recommended tools
- Have backup plan to purchase USB CUL if needed

### Risk: Devices won't re-pair to CUNX
**Likelihood:** Low (same RF protocol)  
**Impact:** Medium (heating unavailable)  
**Mitigation:**
- Test with one device first
- Keep old MAX Cube firmware backup
- Can re-flash if critical issues

### Risk: CUNX has worse RF range than expected
**Likelihood:** Very Low (MAX Cube has good antenna)  
**Impact:** Medium (some devices unreachable)  
**Mitigation:**
- CUNX typically has same/better range as original
- Can position device optimally on network
- Worst case: purchase USB CUL as backup

---

## Success Criteria

The decision will be considered successful when:
1. ✅ MAX Cube successfully flashed to CUNX firmware
2. ✅ FHEM can communicate with CUNX over network
3. ✅ All EQ3 MAX devices paired and responding
4. ✅ Basic temperature control working via FHEM
5. ✅ System runs stable for 1-2 weeks without issues

---

## References

### Flashing Guides
- **Windows:** https://tinkerblog.net/maxcube-mit-culfw-flashen/
- **Linux:** https://forum.pimatic.org/topic/2483/pimatic-maxcul-and-max-cube-with-aculfw-acting-as-cul
- **OpenHAB tutorial:** https://community.openhab.org/t/howto-reflash-max-cube-to-cul-cunx-and-use-with-homegar-and-homematic-binding/55047

### Technical Documentation
- **CULFW Project:** https://culfw.de/
- **FHEM Wiki CUL:** https://wiki.fhem.de/wiki/CUL
- **FHEM CUL_MAX module:** https://wiki.fhem.de/wiki/CUL_MAX

---

## Updates

**2025-10-26:** ADR created - Decision to flash MAX Cube to CUNX  
*(Future updates will be added here)*

---

## Related Documents

- **ADR-0003:** FHEM for EQ3 MAX Control (parent decision)
- **ADR-0004:** MQTT Integration Layer (future integration)
- **max-cube-to-cunx-flash-guide.md:** Detailed technical flashing guide
- **FHEM-installation-guide.md:** Updated with CUNX configuration
