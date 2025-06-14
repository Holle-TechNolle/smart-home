# Environment Setup 
 
## Hardware 
 
### Intel NUC (Home Assistant) 
- **IPv4:** 192.168.1.15/24 
- **IPv6:** fe80::9492:4629:cef1:c40b/64 
- **OS Version:** Home Assistant OS 15.2 
- **Home Assistant Core:** 2025.6.1 
- **Home Assistant Supervisor:** 2025.05.5 
- **Architecture:** amd64 / generic-x86-64 
 
### Raspberry Pi 3 
- **Hostname:** raspberrypi 
- **IPv4:** 192.168.1.35 
- **Brugernavn:** gladmin 
- **OS:** Raspberry Pi OS (Debian GNU/Linux) 
 
## Network og Connectivity 
 
### Lokal adgang 
- **Home Assistant URL:** http://homeassistant.local:8123 
- **Home Assistant (IP):** http://192.168.1.15:8123 
- **Observer URL:** http://homeassistant.local:4357 
 
### Tailscale adgang 
- **Home Assistant URL:** http://homeassistant.tailc0a425.ts.net:8123 
- **Tailscale IP:** 100.93.196.4 
- **Hassio dashboard:** http://homeassistant.tailc0a425.ts.net:8123/hassio/dashboard 
- **Tailscale konto:** holle-technolle.github 
 
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
 
## Location og Konfiguration 
- **Adresse:** Skee-Tåstrupvej 12, 4370 Store Merløse, Danmark 
- **Latitude:** 55.546341 
- **Longitude:** 11.716269 
- **Elevation:** 52 meter 
- **Unit System:** Metric 
- **Tidszone:** Europe/Copenhagen 
 
## SSH Adgang 
 
### Konfigurerede forbindelser 
- **Intel NUC (Home Assistant):** `ssh root@192.168.1.15` 
- **Raspberry Pi:** `ssh gladmin@192.168.1.35` 
- **Via Tailscale:** `ssh root@homeassistant.tailc0a425.ts.net` 
 
### SSH Konfiguration 
Alle forbindelser konfigureret i `~/.ssh/config` for nem adgang via VS Code Remote SSH extension. 
