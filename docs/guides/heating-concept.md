# Varmestyring - Koncept Skitse

## Status: Planlagt (ikke implementeret)

Dette dokument er en tidlig konceptskitse til fremtidig varmestyring i smart home systemet.

## Grundkoncept

Intelligent styring af radiatortermostater og gulvvarme baseret på:
- Daglige rutiner (morgen/aften)
- Tilstedeværelse (hjemme/ude)
- Vejrforhold

## Arkitektoniske Principper

### Home Assistant som centrum
- Alle termostater integreres i Home Assistant
- Én kilde til konfiguration

### AppDaemon for kompleks logik
- Håndterer avancerede rutiner som HA's automationer ikke kan
- Python-baseret for fleksibilitet

## Potentielle Komponenter

### Hardware (ikke besluttet)
- Zigbee/Z-Wave/WiFi termostater
- USB dongle til Zigbee (hvis valgt)

### Software (ikke besluttet)
- Zigbee2MQTT (hvis Zigbee)
- AppDaemon for rutiner
- Weather integration

## Funktionalitet (ideer)

### Basis
- [ ] Morgen/aften rutiner
- [ ] Tilstedeværelsesstyring
- [ ] Manuel override

### Avanceret (mulige fremtidige features)
- [ ] Vejrbaseret justering
- [ ] Vindue-åben detection
- [ ] Energipris-optimering

## Næste Skridt

1. Research termostater (Zigbee vs Z-Wave vs WiFi)
2. Beslut hardware platform
3. Test med én termostat
4. Udvid til flere zoner

---

*Dette er en arbejdsskitse - ingen beslutninger er truffet endnu*  
*Oprettet: Oktober 2025*
