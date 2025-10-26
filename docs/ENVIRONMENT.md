# Environment Setup 
 
## Hardware 
 
### Intel NUC (Home Assistant) 
- **Rolle:** Central smart home hub og brugerinterface
- **IPv4:** 192.168.1.x/24 (local network) 
- **IPv6:** fe80::[redacted]/64 
- **OS Version:** Home Assistant OS 15.2 
- **Home Assistant Core:** 2025.6.1 
- **Home Assistant Supervisor:** 2025.05.5 
- **Architecture:** amd64 / generic-x86-64 
 
### Raspberry Pi 3 (Heating Controller)
- **Rolle:** Dedikeret FHEM server til varmestyring
- **Hostname:** [pi-hostname] 
- **IPv4:** 192.168.1.x (local network) 
- **Username:** [pi-user] 
- **OS:** Raspberry Pi OS (Debian GNU/Linux)

**Installeret Software:**
- **FHEM** - Varmestyring og EQ3 MAX termostat kontrol (planlagt)
- **MQTT Client** - Integration med Home Assistant (planlagt)

**Hardware:**
- **USB CUL/CUN Dongle** - Radio interface til EQ3 MAX termostater (planlagt)

**Rationale:**
Raspberry Pi kører som dedikeret heating controller for at sikre robust varmestyring uafhængigt af Home Assistant. Dette følger separation of concerns princippet hvor kritiske systemer (varme) ikke påvirkes af eksperimenter på hovedsystemet.
 
## Network og Connectivity 
 
### Lokal adgang 
- **Home Assistant URL:** http://homeassistant.local:8123 
- **Home Assistant (IP):** http://[local-ip]:8123 
- **Observer URL:** http://homeassistant.local:4357
- **FHEM URL:** http://[pi-hostname]:8083 (planlagt)
 
### Remote adgang 
- **VPN URL:** http://homeassistant.[vpn-id].ts.net:8123 
- **VPN IP:** [vpn-ip] 
- **VPN Account:** [vpn-account] 
 
## Software Setup 
 
### Home Assistant Add-ons 
- **Advanced SSH & Web Terminal** (version 20.0.2) 
  - SSH aktiveret på port 22 
  - SFTP support aktiveret 
  - ZSH shell aktiveret 
  - Compatibility mode aktiveret for Windows SSH 
  - Port forwarding aktiveret for VS Code Remote 
 
### Database 
- **MySQL** kørende med Home Assistant integration 
- **Home Assistant recorder** konfigureret til MySQL 
 
### External Services 
- **Smart Life** integration konfigureret
- **Weather Integration** - Lokal vejrdata for automation

### MQTT Infrastructure (Planlagt)
- **MQTT Broker:** Mosquitto (placering TBD - enten på HA eller RPi)
- **Purpose:** Message bus mellem FHEM og Home Assistant
- **Topics:** 
  - `heating/room/[room-name]/temperature` - Aktuel temperatur
  - `heating/room/[room-name]/setpoint` - Ønsket temperatur
  - `heating/room/[room-name]/status` - Termostat status

## Heating Hardware

### EQ3 MAX Termostater
- **Type:** Legacy RF termostater (EOL produkt)
- **Protokol:** Proprietary 868 MHz
- **Antal:** [antal] enheder fordelt på zoner
- **Controller:** FHEM på Raspberry Pi (erstatter MAX Cube)

**Hvorfor FHEM:**
EQ3 MAX er end-of-life og mangler moderne smart home support. FHEM har mature native support for MAX protokollen og kan erstatte den ustabile MAX Cube.

### Radio Interface
- **USB CUL/CUN Dongle** - 868 MHz transceiver til FHEM
- Tilsluttet Raspberry Pi via USB
- Håndterer RF kommunikation med alle termostater
 
## Location og Konfiguration 
- **Location:** Store Merløse området, Danmark 
- **Latitude:** 55.5xxx (generalized) 
- **Longitude:** 11.7xxx (generalized) 
- **Elevation:** ~50 meter 
- **Unit System:** Metric 
- **Tidszone:** Europe/Copenhagen 
 
## SSH Adgang 
 
### Konfigurerede forbindelser 
- **Intel NUC (Home Assistant):** `ssh [user]@[local-ip]` 
- **Raspberry Pi (FHEM):** `ssh [user]@[pi-ip]` 
- **Via VPN:** `ssh [user]@[vpn-hostname]` 
 
### SSH Konfiguration 
Alle forbindelser konfigureret i `~/.ssh/config` for nem adgang via VS Code Remote SSH extension. 
 
**Note:** Præcise IP-adresser, hostnavne og credentials findes i krypterede filer i `secure/` mappen.

## System Architecture Overview

```
┌─────────────────┐
│  Intel NUC      │
│  Home Assistant │ ← Brugerinterface, dashboards, automationer
│  MySQL          │
└────────┬────────┘
         │
         │ MQTT (planlagt)
         │
┌────────┴────────┐
│  Raspberry Pi 3 │
│  FHEM           │ ← Dedikeret varmestyring
│  USB CUL/CUN    │
└────────┬────────┘
         │
         │ RF 868 MHz
         │
┌────────┴────────────┐
│  EQ3 MAX Termostater│ ← Radiatorer i alle rum
└─────────────────────┘
```

**Design Rationale:**
- Home Assistant = Smart home centrum for alle enheder og brugerinterface
- Raspberry Pi = Specialist controller for legacy hardware med kritisk funktion
- MQTT = Løst koblet integration mellem systemer
- Separation of concerns = Robust heating uafhængigt af HA-eksperimenter

Se [heating-concept.md](../guides/heating-concept.md) for detaljeret arkitektur og implementationsplan.
