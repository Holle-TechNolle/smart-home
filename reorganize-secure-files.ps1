# Reorganize secure/ credentials into structured files
# Run from smart-home root directory in VS Code terminal

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Reorganizing secure/ credentials..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verify we're in the right directory
if (-not (Test-Path "secure")) {
    Write-Host "ERROR: secure/ folder not found!" -ForegroundColor Red
    Write-Host "Make sure you're in the smart-home root directory" -ForegroundColor Red
    exit 1
}

# Backup existing CREDENTIALS.md
if (Test-Path "secure\CREDENTIALS.md") {
    Write-Host "Creating backup of existing CREDENTIALS.md..." -ForegroundColor Yellow
    Copy-Item "secure\CREDENTIALS.md" "secure\CREDENTIALS.md.backup"
    Write-Host "Backup created: secure\CREDENTIALS.md.backup" -ForegroundColor Green
    Write-Host ""
}

# Create CREDENTIALS.md
Write-Host "Creating secure\CREDENTIALS.md..." -ForegroundColor Yellow
@"
# Credentials og Følsomme Oplysninger

⚠️ **ADVARSEL:** Denne fil indeholder følsomme credentials og skal krypteres med git-crypt før commit til GitHub.

## SSH Adgang

### Intel NUC (Home Assistant)
- **Brugernavn:** root
- **Password:** GreteFraGylleGaarden.
- **SSH Port:** 22
- **Local IP:** 192.168.1.15
- **SSH Command:** ``ssh root@192.168.1.15``

### Raspberry Pi 3
- **Hostname:** raspberrypi
- **Brugernavn:** gladmin
- **Password:** pitonslange.
- **Local IP:** 192.168.1.35
- **SSH Command:** ``ssh gladmin@192.168.1.35``

## Database Credentials

### MySQL
- **Host:** 192.168.1.15 (Home Assistant)
- **Root Password:** FiskePtter.
- **Port:** 3306
- **Database Name:** homeassistant

## Home Assistant

### Access Tokens
- **Long-lived Access Token (VS Code):** [Generer i HA UI under Profile]
- **Long-lived Access Token (AppDaemon):** [Generer i HA UI under Profile]

### API Access
- **Local URL:** http://192.168.1.15:8123
- **Local (mDNS):** http://homeassistant.local:8123
- **Tailscale URL:** http://homeassistant.tailc0a425.ts.net:8123
- **Observer URL:** http://homeassistant.local:4357

---

*Sidst opdateret: Oktober 2025*
*HUSK: Denne fil skal krypteres med git-crypt*
"@ | Out-File -FilePath "secure\CREDENTIALS.md" -Encoding UTF8
Write-Host "✓ secure\CREDENTIALS.md created" -ForegroundColor Green
Write-Host ""

# Create NETWORK.md
Write-Host "Creating secure\NETWORK.md..." -ForegroundColor Yellow
@"
# Network Configuration

⚠️ **ADVARSEL:** Denne fil indeholder følsomme netværksoplysninger og skal krypteres med git-crypt.

## Location Details
- **Fuld adresse:** Skee-Tåstrupvej 12, 4370 Store Merløse, Danmark
- **Præcis latitude:** 55.546341
- **Præcis longitude:** 11.716269
- **Elevation:** 52 meter
- **Tidszone:** Europe/Copenhagen

## Local Network

### Network Information
- **Network Range:** 192.168.1.0/24
- **Gateway:** 192.168.1.1
- **DNS Primary:** 192.168.1.1
- **DNS Secondary:** 8.8.8.8

### Static IP Assignments

#### Intel NUC (Home Assistant)
- **IPv4:** 192.168.1.15/24
- **IPv6:** fe80::9492:4629:cef1:c40b/64
- **Hostname:** homeassistant.local

#### Raspberry Pi 3
- **IPv4:** 192.168.1.35/24
- **Hostname:** raspberrypi

## VPN Configuration

### Tailscale
- **Account:** holle-technolle.github
- **Magic DNS Enabled:** Yes
- **Network Name:** tailc0a425

#### Tailscale Devices
- **Home Assistant:**
  - Tailscale IP: 100.93.196.4
  - Hostname: homeassistant.tailc0a425.ts.net
  - Access URL: http://homeassistant.tailc0a425.ts.net:8123
  - Hassio Dashboard: http://homeassistant.tailc0a425.ts.net:8123/hassio/dashboard

## Port Forwarding
- **Home Assistant:** Port 8123 (kun lokal adgang)
- **SSH (NUC):** Port 22 (kun lokal adgang)
- **SSH (RPi):** Port 22 (kun lokal adgang)

## Firewall Rules
- **Inbound:** Deny all (undtagen etablerede forbindelser)
- **Outbound:** Allow all
- **Local Network:** Allow all fra 192.168.1.0/24

---

*Sidst opdateret: Oktober 2025*
*HUSK: Denne fil skal krypteres med git-crypt*
"@ | Out-File -FilePath "secure\NETWORK.md" -Encoding UTF8
Write-Host "✓ secure\NETWORK.md created" -ForegroundColor Green
Write-Host ""

# Create SERVICES.md
Write-Host "Creating secure\SERVICES.md..." -ForegroundColor Yellow
@"
# External Services og Integrationer

⚠️ **ADVARSEL:** Denne fil indeholder API nøgler, passwords og tokens. Skal krypteres med git-crypt.

## Smart Life / Tuya

### Account Information
- **User Code:** Ca5KJ60
- **Email:** [Din email]
- **Password:** [Dit password]

## MQTT Broker

### Mosquitto (Home Assistant Add-on)
- **Username:** mqtt_user
- **Password:** [Skal defineres]
- **Port:** 1883
- **Host:** core-mosquitto

### MQTT Clients
- **Home Assistant:** Bruger localhost connection
- **Zigbee2MQTT:** Bruger mqtt_user credentials
- **AppDaemon:** [Hvis MQTT bruges direkte]

## Zigbee2MQTT

### Network Configuration
- **Network Key:** [GENERATE i configuration.yaml]
- **PAN ID:** [GENERATE i configuration.yaml]
- **Channel:** [Default eller custom]
- **Web UI Port:** 8080 (kun lokal adgang)
- **Coordinator Port:** /dev/ttyUSB0

## Weather Services

### Weather Integration
- **Service:** [Hvilken weather service bruger du?]
- **API Key:** [Hvis relevant]
- **Location:** Store Merløse, Danmark (55.546341, 11.716269)

## Notification Services

### Mobile App
- **Push Notification Token:** [Genereres automatisk af HA app]

### Email (hvis konfigureret)
- **SMTP Server:** [Din SMTP server]
- **Port:** [Typisk 587 eller 465]
- **Username:** [Din email]
- **Password:** [Email password eller app-specific password]

## Backup og Cloud Storage

### GitHub
- **Repository:** https://github.com/Holle-TechNolle/smart-home
- **Personal Access Token:** [Hvis du bruger HTTPS]
- **SSH Key:** [Path til SSH private key]

---

## Rotation Schedule

**Passwords og tokens bør roteres regelmæssigt:**
- Home Assistant tokens: Årligt
- Database passwords: Ved mistanke om kompromittering
- API keys: Når services opdateres
- SSH keys: Hvert 2. år eller ved mistanke

---

*Sidst opdateret: Oktober 2025*
*HUSK: Denne fil skal krypteres med git-crypt*
"@ | Out-File -FilePath "secure\SERVICES.md" -Encoding UTF8
Write-Host "✓ secure\SERVICES.md created" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Reorganization complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Created files:" -ForegroundColor Yellow
Write-Host "  - secure\CREDENTIALS.md (SSH, DB, HA tokens)" -ForegroundColor White
Write-Host "  - secure\NETWORK.md (IPs, location, VPN)" -ForegroundColor White
Write-Host "  - secure\SERVICES.md (External services, API keys)" -ForegroundColor White
Write-Host ""
Write-Host "Backup:" -ForegroundColor Yellow
Write-Host "  - secure\CREDENTIALS.md.backup (original file)" -ForegroundColor White
Write-Host ""
Write-Host "Next step: Review files and fill in missing information" -ForegroundColor Cyan
