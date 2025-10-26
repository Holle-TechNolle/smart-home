# ADR-0003: FHEM til EQ3 MAX Termostat Kontrol

**Status:** Accepteret  
**Dato:** 26. oktober 2025  
**Supersedes:** N/A  
**Superseded by:** N/A

## Context

Vi har eksisterende EQ3 MAX radiatortermostater installeret i hele huset. Disse termostater er end-of-life produkter hvor producenten har stoppet support, og den originale MAX Cube controller er blevet ustabil og upålidelig.

**Problemer med nuværende situation:**
- MAX Cube fejler periodisk og kræver genstart
- Ingen officiel integration til moderne smart home platforme
- Hardware fungerer stadig perfekt, men mangler controller
- Proprietary closed-source software uden community support
- Risiko for komplet tab af varmestyring ved Cube-fejl

**Udfordringen:**
Vi har brug for en pålidelig måde at kontrollere eksisterende termostater på, uden at skulle udskifte alt hardware (dyrt og arbejdskrævende), samtidig med at løsningen skal kunne integreres i vores Home Assistant-baserede smart home setup.

## Alternatives Considered

### Alternative 1: Native Home Assistant Integration
Brug community HACS integration til MAX.

**Fordele:**
- Alt i Home Assistant - ingen ekstra software
- Unified interface

**Ulemper:**
- Community plugins er ustabile og poorly maintained
- Mange brugere rapporterer connectivity issues
- Python libraries for MAX protokol er immature
- Risikerer samme problemer som MAX Cube

**Konklusion:** For risikabelt for kritisk infrastruktur som varme.

### Alternative 2: Udskift Alt Hardware
Køb nye Zigbee/Z-Wave termostater.

**Fordele:**
- Moderne hardware med god HA support
- Ingen legacy protocol issues
- Bedre features (batterilevetid, precision)

**Ulemper:**
- Dyrt (15-20 termostater × 400-600 kr = 6000-12000 kr)
- Tidskrævende installation
- Nuværende hardware fungerer fint
- Kan ikke genbruge investering i MAX ecosystem

**Konklusion:** Økonomisk uattraktivt når hardware virker.

### Alternative 3: Keep MAX Cube
Fortsæt med at bruge MAX Cube.

**Fordele:**
- Ingen ændringer nødvendige
- Kendt system

**Ulemper:**
- Upålidelig og fejlende
- Ingen integration med HA
- Closed source - kan ikke debugges eller fixes
- Producenten har droppet support
- Single point of failure

**Konklusion:** Ikke en langsigtet løsning.

### Alternative 4: FHEM på Raspberry Pi
Brug FHEM med USB CUL/CUN dongle til direkte MAX kontrol.

**Fordele:**
- Mature MAX protocol implementation
- Aktiv community og ongoing maintenance
- Open source - kan debugges og tilpasses
- Direkte RF kommunikation - ingen Cube nødvendig
- Separation of concerns - heating isoleret fra HA
- Kan integreres med HA via MQTT

**Ulemper:**
- Ekstra software at vedligeholde
- Læringskurve for FHEM
- Kræver USB CUL/CUN dongle (~200-400 kr)

**Konklusion:** Bedste balance mellem pålidelighed, omkostning og fremtidssikring.

## Decision

**Vi implementerer FHEM på Raspberry Pi 3 som dedikeret heating controller.**

**Teknisk setup:**
- FHEM installeres på eksisterende Raspberry Pi 3
- USB CUL/CUN dongle håndterer RF kommunikation til termostater
- MQTT bruges til integration med Home Assistant
- To-fase approach: Først standalone FHEM, senere HA integration

**Rationale:**
- FHEM er den mest mature løsning til EQ3 MAX
- Separation of concerns - heating er kritisk og bør være robust
- Raspberry Pi kan køre 24/7 uden afhængighed af HA
- MQTT giver flexibel integration uden tight coupling
- Open source giver fuld kontrol og debugging muligheder

## Consequences

### Positive

**Tekniske fordele:**
- Stabil og pålidelig varmestyring
- Fuld kontrol over legacy hardware
- Kan debugges og tilpasses efter behov
- Graceful degradation - heating fungerer selvom HA går ned

**Økonomiske fordele:**
- Genbruger eksisterende hardware-investering
- Minimal cost (kun USB dongle)
- Udskyder behov for dyr hardware-udskiftning

**Arkitektoniske fordele:**
- Følger separation of concerns princippet
- MQTT integration layer gør komponenter udskiftelige
- Kan migrere til anden controller senere uden at ændre HA

### Negative

**Kompleksitet:**
- Ekstra system at vedligeholde (FHEM)
- Ny teknologi at lære
- Mere kompleks fejlsøgning ved problemer

**Afhængigheder:**
- Kræver Raspberry Pi kører 24/7
- USB dongle er single point of failure (men nemt at erstatte)
- MQTT broker skal være stabil

**Teknisk gæld:**
- Legacy protokol support forbliver nødvendig
- Migration til moderne hardware stadig attraktiv på lang sigt

### Mitigations

**For kompleksitet:**
- Grundig dokumentation af FHEM setup
- Tekniske guider til troubleshooting
- Gradvis implementation (start med få termostater)

**For afhængigheder:**
- Raspberry Pi er dediceret til heating - minimal uptime risk
- Backup USB dongle (lav cost)
- MQTT broker kan køre på RPi sammen med FHEM

**For legacy teknologi:**
- Arkitekturen designes så FHEM kan udskiftes senere
- MQTT interface bevares ved fremtidig migration
- Planlæg for gradvis hardware-udskiftning over flere år

## Follow-up Actions

1. **Immediate:**
   - [ ] Bestil USB CUL/CUN dongle
   - [ ] Installer FHEM på Raspberry Pi
   - [ ] Test med én termostat som proof-of-concept

2. **Short term:**
   - [ ] Pair alle termostater med FHEM
   - [ ] Implementér basic tidsbaserede profiler
   - [ ] Verificér stabilitet over 1-2 uger

3. **Medium term:**
   - [ ] Implementér MQTT integration
   - [ ] Opret Home Assistant dashboard
   - [ ] Migrér avancerede automationer til HA

4. **Long term:**
   - [ ] Monitor for moderne MAX-kompatible termostater
   - [ ] Overvej gradvis migration til Zigbee når budget tillader
   - [ ] Evaluér alternative controllers hvis FHEM bliver problematisk

## References

- [FHEM MAX Module Documentation](https://wiki.fhem.de/wiki/MAX)
- [USB CUL/CUN Hardware](https://wiki.fhem.de/wiki/CUL)
- [EQ3 MAX Protocol Analysis](https://github.com/Bouni/max-cube-protocol)

## Related Documents

- [heating-concept.md](../guides/heating-concept.md) - Detaljeret konceptdokument
- [FHEM-installation-guide.md](../guides/FHEM-installation-guide.md) - Teknisk installationsguide
- ADR-0004 (kommende) - MQTT som integration layer

---

**Beslutningen afspejler projektets kerneprincipper:**
- Implementér kun nyt når det tilbyder **unik funktionalitet** (FHEM har mature MAX support)
- Kan **erstatte eksisterende** problematisk løsning (unstable MAX Cube)
- Home Assistant forbliver centrum via MQTT integration
