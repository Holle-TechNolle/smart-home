# Arkitektoniske Principper for Smart Home Projektet 
 
## Grundlæggende Principper 
 
### 1. Home Assistant som Centrum 
**"Home Assistant er centrum - integrer én gang, brug alle steder."** 

Home Assistant fungerer som central hub hvor alle enheder og services integreres. Dette sikrer én kilde til konfiguration, unified brugerinterface og konsistent data-håndtering.

**Undtagelse for Legacy Hardware:**
Når eksisterende hardware ikke kan integreres direkte i Home Assistant (f.eks. EOL produkter som EQ3 MAX), anvendes **specialist controllers** der integreres via standard protokoller som MQTT. Dette bevarer princippet om Home Assistant som brugernes centrum, mens teknisk kontrol håndteres af dedikerede systemer.
 
### 2. Minimer Overlap, Maksimer Værdi 
**"Implementér kun nyt når det tilbyder unik funktionalitet og erstatter eksisterende komponenter."** 

Nye komponenter introduceres kun når de:
- Tilbyder funktionalitet som ikke findes i eksisterende setup
- Kan erstatte problematiske eller udaterede løsninger
- Forbedrer systemets robusthed eller vedligeholdelse

**Eksempel:**
FHEM introduceres ikke for at tilføje "endnu en automation engine", men fordi det er den eneste mature løsning til kontrol af legacy EQ3 MAX termostater. Det erstatter den ustabile MAX Cube og giver adgang til hardware der ellers ville være ubrugelig.

## System Arkitektur

### Hardware Distribution

**Intel NUC (Home Assistant):**
- Central smart home hub
- Brugerinterface og dashboards
- Automation orchestration
- Data persistence (MySQL)

**Raspberry Pi 3 (FHEM):**
- Dedikeret heating controller
- Legacy hardware support (EQ3 MAX)
- Kritisk system adskilt fra eksperimenter
- 24/7 operation uafhængigt af HA

**Design Rationale:**
Separation of concerns - varme er kritisk infrastruktur der ikke skal påvirkes af eksperimenter på hovedsystemet. RPi kan debugges og genstartes uden at varmen går ned.

### Integration Layer: MQTT

**MQTT fungerer som message bus** mellem systemer:

```
Home Assistant ←→ MQTT Broker ←→ FHEM
     ↓                               ↓
Dashboard/UI                   EQ3 MAX Control
Automations                    Temperature Monitoring
Notifications                  Schedule Management
```

**MQTT Topics Struktur:**
- `heating/room/[navn]/temperature` - Aktuel temperatur
- `heating/room/[navn]/setpoint` - Ønsket temperatur
- `heating/room/[navn]/status` - Valve position, battery, etc.
- `heating/system/mode` - Home/Away/Off
- `heating/system/status` - Overall system health

**Fordele ved MQTT:**
- **Løs kobling** - Systemer kan opdateres uafhængigt
- **Async messaging** - Ingen blocking eller timeouts
- **Standard protokol** - Bredt supporteret i IoT
- **Lightweight** - Minimal overhead
- **Topic-based** - Let at tilføje nye data flows

### Data Flow Eksempel

**Scenario:** Bruger ændrer temperatur i Home Assistant dashboard

1. **HA UI** → Bruger sætter temperatur til 22°C for "Stue"
2. **HA → MQTT** → Publisher til `heating/room/stue/setpoint_cmd` med værdi 22
3. **FHEM subscriber** → Modtager kommando fra MQTT
4. **FHEM → Termostat** → Sender RF kommando til EQ3 MAX termostat
5. **Termostat → FHEM** → Bekræfter ny setpoint
6. **FHEM → MQTT** → Publisher bekræftelse til `heating/room/stue/setpoint`
7. **HA subscriber** → Opdaterer dashboard med bekræftet værdi

Total round-trip tid: < 2 sekunder

## Udviklerværktøjer og Workflow 
 
### VS Code som Primær IDE 
VS Code anvendes som det centrale udviklingsværktøj med følgende konfiguration: 
 
#### Extensions 
- **Home Assistant Config Helper** - YAML autocomplete og validering 
- **Python** - AppDaemon udvikling og debugging 
- **YAML** - Syntax highlighting og formatering 
- **GitLens** - Git integration og historik 
- **Remote - SSH** - Remote development capabilities 
 
### SSH Remote Development 
Direkte udvikling på target systemer via SSH: 
 
#### Intel NUC (Home Assistant) 
- **Direkte adgang** til `/config` mappe med alle Home Assistant filer 
- **Live redigering** af `configuration.yaml`, `automations.yaml`, osv. 
- **Øjeblikkelig test** af ændringer i Home Assistant 
- **ZSH shell** for forbedret terminal oplevelse 
 
#### Raspberry Pi (FHEM)
- **Udvikling og test** af FHEM konfiguration
- **Live logs** for debugging af termostat kommunikation
- **MQTT testing** med direkte adgang til topics
- **Isoleret testmiljø** før produktion
 
### Etableret Udviklerworkflow 
 
#### 1. Home Assistant Konfigurationsændringer 
VS Code Remote SSH → Home Assistant /config → Live test → Git commit 
 
#### 2. FHEM Varmestyring
VS Code Remote SSH → Raspberry Pi FHEM config → Test med termostater → Verificer MQTT → Git commit

#### 3. Cross-System Features (Future)
HA automation idé → Test MQTT flow → Implementér i både HA og FHEM → Verificer end-to-end → Git commit

## Sikkerhed og Robusthed

### Graceful Degradation

Systemet designes til at fungere selvom dele fejler:

**Hvis Home Assistant går ned:**
- FHEM fortsætter varmestyring autonomt
- Termostater følger deres lokale schedules
- Manuel kontrol på termostater fungerer altid

**Hvis MQTT går ned:**
- FHEM fortsætter med at styre termostater
- HA mister kun visibility, ikke core funktioner
- Reconnect automatisk når MQTT er tilbage

**Hvis FHEM går ned:**
- Termostater følger sidst kendte setpoints
- Manuel kontrol på termostater fungerer
- HA viser sidste kendte data

### Monitoring og Alerting

**Critical System Health Metrics:**
- FHEM proces status (via MQTT heartbeat)
- Termostat battery levels
- MQTT broker connectivity
- Abnormal temperature readings

**Notification Strategy:**
- Critical alerts via HA notifications
- Non-critical warnings in HA logs
- FHEM logs tilgængelige via SSH

## Future Architecture Considerations

### Potential Evolution Paths

**Path 1: FHEM Replacement**
Hvis moderne EQ3 MAX alternativ dukker op, kan FHEM erstattes mens MQTT interface bevares. Home Assistant integration skal ikke ændres.

**Path 2: AppDaemon Addition**
Når MQTT er etableret, kan AppDaemon tilføjes for avanceret automation logic der bruger data fra både HA og FHEM.

**Path 3: Hardware Migration**
Ved udskiftning til Zigbee/Z-Wave termostater kan FHEM udfases og styring flyttes til HA, mens MQTT topics bevares for backward compatibility med eksisterende automationer.

**Arkitekturens Fleksibilitet:**
Ved at bruge MQTT som integration layer, er individual komponenter udskiftelige uden at ændre hele systemet. Dette er essentielt for et långsigtet hobby-projekt hvor teknologi og krav ændrer sig over tid.

## Documentation Standards

### Architecture Decision Records (ADR)

Alle vigtige arkitektoniske beslutninger dokumenteres som ADR'er i `docs/decisions/`:
- Hvorfor blev beslutningen taget?
- Hvilke alternativer blev overvejet?
- Hvilke konsekvenser har beslutningen?

**Eksisterende ADR'er:**
- [ADR-0001: GitHub som platform](decisions/0001-github-platform.md)
- [ADR-0002: VS Code SSH Development](decisions/0002-vscode-ssh-development.md)

**Kommende ADR'er:**
- ADR-0003: FHEM til EQ3 MAX kontrol
- ADR-0004: MQTT som integration layer

### Living Documentation

Arkitekturdokumentation opdateres løbende når systemet udvikler sig. Gamle beslutninger markeres som "Superseded" men bevares for historisk kontekst.

---

**Dokument version:** 2.0  
**Sidst opdateret:** Oktober 2025  
**Status:** Reflects current architecture with FHEM and MQTT additions
