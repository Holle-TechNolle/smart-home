# Varmestyring - Konceptdokument

## Status: I planlægning - Hardware besluttet, implementation pending

## Besluttet Arkitektur

### Overordnet Design

**FHEM som varme-controller** - Kører på Raspberry Pi 3 som dedikeret varme-styringssystem med gradvis integration til Home Assistant via MQTT.

**Pragmatisk to-fase tilgang:**
1. **Fase 1 (Kort sigt):** FHEM styrer varmen autonomt - fokus på at få kontrol over eksisterende hardware
2. **Fase 2 (Senere):** Dyb integration med Home Assistant via MQTT for unified control

Denne tilgang følger projektets kerneprincipper ved at introducere FHEM kun fordi det tilbyder **unik funktionalitet** (support for legacy EQ3 MAX hardware) og kan **erstatte en defekt løsning** (MAX Cube der ikke længere supporteres).

## Hardware Situation

### EQ3 MAX Termostater - Legacy Challenge

Alle eksisterende termostater er **EQ3 MAX** enheder - en EOL (End-of-Life) platform:

**Hvorfor det er kritisk:**
- Producenten har stoppet support
- MAX Cube (original controller) er ustabil og upålidelig
- Ingen officiel integration til moderne smart home platforme
- Hardware fungerer stadig, men mangler controller-software

**Derfor FHEM:**
- Native support for EQ3 MAX protokollen
- Aktiv community med vedligeholdt MAX-integration
- Kan erstatte MAX Cube fuldstændigt
- Open source alternativ til dead-end proprietær løsning

### MAX Cube - Skal den bruges?

**Nej, MAX Cube bliver pensioneret:**
- FHEM kommunikerer **direkte** med termostater via USB CUL/CUN dongle
- MAX Cube var original gateway, men er blevet reliability-problem
- Fjernelse af proprietary black-box aligner med projektets design-filosofi

**Alternative:** USB CUL/CUN dongle fungerer som radio-interface mellem FHEM og termostater.

## Teknisk Integration

### MQTT som Integration Layer

**FHEM → MQTT → Home Assistant:**

MQTT fungerer som message bus der forbinder FHEM's varme-kontrol med Home Assistant's dashboard og automationer:

- **FHEM publisher** temperatur-data og termostat-status til MQTT topics
- **Home Assistant subscriber** til samme topics for dashboard-visning
- **Home Assistant kan publisher** ønskede temperaturer tilbage til FHEM
- **Løst koblet arkitektur** - systemerne kan udvikles uafhængigt

### Hvorfor MQTT?

- **Standard protokol** i IoT/smart home økosystemer
- **Lightweight** og velegnet til Raspberry Pi
- **Async messaging** - ingen systemer blokerer hinanden
- **Topic-baseret** - let at tilføje nye data-flows senere
- **Supported** af både FHEM og Home Assistant out-of-the-box

## Funktionalitet

### Fase 1: Grundlæggende Varmestyring (FHEM standalone)

Mål: Få pålidelig kontrol over termostater uden afhængighed af MAX Cube

**Core Features:**
- Manuel temperatur-justering per termostat
- Tidsbaserede profiler (morgen/dag/aften/nat)
- Temperatur-monitoring i alle zoner
- Grundlæggende væk/hjemme mode

**FHEM håndterer:**
- Direkte kommunikation med EQ3 MAX termostater
- Scheduling og profiler
- Datalagring og logging
- Evt. simpel web-interface til debugging

### Fase 2: Home Assistant Integration (Future)

Mål: Unified dashboard og avanceret automation

**Integration Features:**
- Temperatur-display i Home Assistant dashboard
- HA automationer kan sætte temperaturer via MQTT
- Historiske data synlige i HA
- Notifikationer via HA's notification system

**Avancerede Muligheder (senere):**
- Vejrbaseret præ-heating
- Presence detection integration
- Energipris-optimering
- Vindue-åben detection med temperatur-sensors

## Design Rationale

### Hvorfor ikke direkte Home Assistant integration?

**Tekniske begrænsninger:**
- Ingen stabil EQ3 MAX integration i Home Assistant
- Community-plugins er ustabile eller discontinued
- Python-libraries for MAX protokol er ikke mature

**Pragmatisk løsning:**
- FHEM har mature, velvedligeholdt MAX-support
- Raspberry Pi kan køre FHEM dedikeret uden at belaste Home Assistant
- MQTT giver fleksibilitet til at ændre arkitektur senere

### Hvorfor dedikeret Raspberry Pi?

**Separation of concerns:**
- Varmestyring er kritisk og bør være robust
- Fejl i HA-eksperimenter påvirker ikke varme
- RPi kan køre 24/7 uden Home Assistant-afhængighed
- Simplere at debugge og troubleshoote

**Performance:**
- FHEM er lightweight og kører fint på RPi 3
- Ingen konkurrence om ressourcer med Home Assistant
- Dedikeret system = mere pålideligt system

## Implementationsplan

### Fase 1a: FHEM Grundsetup
- [ ] Installér FHEM på Raspberry Pi 3
- [ ] Konfigurér USB CUL/CUN dongle
- [ ] Pair første termostat som proof-of-concept
- [ ] Verificér kommunikation og kontrol

### Fase 1b: Full Deployment
- [ ] Pair alle termostater med FHEM
- [ ] Konfigurér zoner og rum-navne
- [ ] Implementér basis tidsplaner
- [ ] Test væk/hjemme mode

### Fase 2a: MQTT Setup
- [ ] Installér MQTT broker (Mosquitto)
- [ ] Konfigurér FHEM til at publisher til MQTT
- [ ] Konfigurér Home Assistant MQTT integration
- [ ] Test data-flow mellem systemer

### Fase 2b: Home Assistant Integration
- [ ] Opret HA dashboard med temperatur-displays
- [ ] Implementér HA automationer der sender kommandoer via MQTT
- [ ] Migrér tidsplaner til HA (hvis ønsket)
- [ ] Avancerede features efter behov

## Success Criteria

**Fase 1 Success:**
- Pålidelig kontrol over alle termostater uden MAX Cube
- Fungerende tidsbaserede profiler
- System kører stabilt 24/7 på RPi

**Fase 2 Success:**
- Alle temperatur-data synlige i Home Assistant
- HA kan sende kommandoer til FHEM via MQTT
- Unified interface til alle smart home funktioner

## Fremtidige Overvejelser

**Hardware upgrade path:**
Hvis EQ3 MAX termostater fejler i fremtiden, kan de udskiftes med moderne Zigbee/Z-Wave enheder. FHEM+MQTT arkitekturen gør det muligt at skifte backend uden at ændre Home Assistant integration.

**Alternative controller:**
FHEM kan potentielt erstattes af en anden MAX-controller, så længe MQTT-interface bevares. Systemets værdi ligger i data-flow design, ikke i specifik software.

---

**Dokument version:** 2.0  
**Sidst opdateret:** Oktober 2025  
**Status:** Arkitektur besluttet - klar til implementation
