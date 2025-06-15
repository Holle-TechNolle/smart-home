# Environment Setup 
 
## Hardware 
 
### Intel NUC (Home Assistant) 
- **IPv4:** 192.168.1.x/24 (local network) 
- **IPv6:** fe80::[redacted]/64 
- **OS Version:** Home Assistant OS 15.2 
- **Home Assistant Core:** 2025.6.1 
- **Home Assistant Supervisor:** 2025.05.5 
- **Architecture:** amd64 / generic-x86-64 
 
### Raspberry Pi 3 
- **Hostname:** [pi-hostname] 
- **IPv4:** 192.168.1.x (local network) 
- **Username:** [pi-user] 
- **OS:** Raspberry Pi OS (Debian GNU/Linux) 
 
## Network og Connectivity 
 
### Lokal adgang 
- **Home Assistant URL:** http://homeassistant.local:8123 
- **Home Assistant (IP):** http://[local-ip]:8123 
- **Observer URL:** http://homeassistant.local:4357 
 
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
- **Raspberry Pi:** `ssh [user]@[pi-ip]` 
- **Via VPN:** `ssh [user]@[vpn-hostname]` 
 
### SSH Konfiguration 
Alle forbindelser konfigureret i `~/.ssh/config` for nem adgang via VS Code Remote SSH extension. 
 
**Note:** Præcise IP-adresser, hostnavne og credentials findes i krypterede filer i `secure/` mappen. 
