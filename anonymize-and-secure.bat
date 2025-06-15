@echo off
echo ========================================
echo Anonymizing Smart Home documentation...
echo ========================================
echo.

REM Create secure folder for encrypted files
echo Creating secure folder for encrypted files...
mkdir secure 2>nul
echo Secure folder created ✓
echo.

REM Backup files preserved for now (will be cleaned later)
echo Backup files preserved for verification...
echo (Will be removed after confirmation that anonymization is correct)
echo.

REM Create .gitattributes for git-crypt (to be configured later)
echo Creating .gitattributes for git-crypt...
echo # Git-crypt configuration > .gitattributes
echo secure/** filter=git-crypt diff=git-crypt >> .gitattributes
echo .gitattributes created ✓
echo.

REM ======================================
REM UPDATE PUBLIC DOCUMENTATION (ANONYMIZED)
REM ======================================

echo Updating docs/ENVIRONMENT.md with anonymized content...
echo # Environment Setup > docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Hardware >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Intel NUC (Home Assistant) >> docs\ENVIRONMENT.md
echo - **IPv4:** 192.168.1.x/24 (local network) >> docs\ENVIRONMENT.md
echo - **IPv6:** fe80::[redacted]/64 >> docs\ENVIRONMENT.md
echo - **OS Version:** Home Assistant OS 15.2 >> docs\ENVIRONMENT.md
echo - **Home Assistant Core:** 2025.6.1 >> docs\ENVIRONMENT.md
echo - **Home Assistant Supervisor:** 2025.05.5 >> docs\ENVIRONMENT.md
echo - **Architecture:** amd64 / generic-x86-64 >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Raspberry Pi 3 >> docs\ENVIRONMENT.md
echo - **Hostname:** [pi-hostname] >> docs\ENVIRONMENT.md
echo - **IPv4:** 192.168.1.x (local network) >> docs\ENVIRONMENT.md
echo - **Username:** [pi-user] >> docs\ENVIRONMENT.md
echo - **OS:** Raspberry Pi OS (Debian GNU/Linux) >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Network og Connectivity >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Lokal adgang >> docs\ENVIRONMENT.md
echo - **Home Assistant URL:** http://homeassistant.local:8123 >> docs\ENVIRONMENT.md
echo - **Home Assistant (IP):** http://[local-ip]:8123 >> docs\ENVIRONMENT.md
echo - **Observer URL:** http://homeassistant.local:4357 >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Remote adgang >> docs\ENVIRONMENT.md
echo - **VPN URL:** http://homeassistant.[vpn-id].ts.net:8123 >> docs\ENVIRONMENT.md
echo - **VPN IP:** [vpn-ip] >> docs\ENVIRONMENT.md
echo - **VPN Account:** [vpn-account] >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Software Setup >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Home Assistant Add-ons >> docs\ENVIRONMENT.md
echo - **Advanced SSH ^& Web Terminal** (version 20.0.2) >> docs\ENVIRONMENT.md
echo   - SSH aktiveret på port 22 >> docs\ENVIRONMENT.md
echo   - SFTP support aktiveret >> docs\ENVIRONMENT.md
echo   - ZSH shell aktiveret >> docs\ENVIRONMENT.md
echo   - Compatibility mode aktiveret for Windows SSH >> docs\ENVIRONMENT.md
echo   - Port forwarding aktiveret for VS Code Remote >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Database >> docs\ENVIRONMENT.md
echo - **MySQL** kørende med Home Assistant integration >> docs\ENVIRONMENT.md
echo - **Home Assistant recorder** konfigureret til MySQL >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### External Services >> docs\ENVIRONMENT.md
echo - **Smart Life** integration konfigureret >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Location og Konfiguration >> docs\ENVIRONMENT.md
echo - **Location:** Store Merløse området, Danmark >> docs\ENVIRONMENT.md
echo - **Latitude:** 55.5xxx (generalized) >> docs\ENVIRONMENT.md
echo - **Longitude:** 11.7xxx (generalized) >> docs\ENVIRONMENT.md
echo - **Elevation:** ~50 meter >> docs\ENVIRONMENT.md
echo - **Unit System:** Metric >> docs\ENVIRONMENT.md
echo - **Tidszone:** Europe/Copenhagen >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## SSH Adgang >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Konfigurerede forbindelser >> docs\ENVIRONMENT.md
echo - **Intel NUC (Home Assistant):** `ssh [user]@[local-ip]` >> docs\ENVIRONMENT.md
echo - **Raspberry Pi:** `ssh [user]@[pi-ip]` >> docs\ENVIRONMENT.md
echo - **Via VPN:** `ssh [user]@[vpn-hostname]` >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### SSH Konfiguration >> docs\ENVIRONMENT.md
echo Alle forbindelser konfigureret i `~/.ssh/config` for nem adgang via VS Code Remote SSH extension. >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo **Note:** Præcise IP-adresser, hostnavne og credentials findes i krypterede filer i `secure/` mappen. >> docs\ENVIRONMENT.md

echo docs/ENVIRONMENT.md anonymized ✓
echo.

REM Update README.md with anonymized SSH examples
echo Updating README.md with anonymized SSH examples...
echo. >> README.md
echo ## 🔗 SSH Forbindelser (Eksempler) >> README.md
echo. >> README.md
echo #### Home Assistant (Intel NUC) >> README.md
echo ```bash >> README.md
echo ssh [ha-user]@[local-ip] >> README.md
echo # Eller via VPN >> README.md
echo ssh [ha-user]@[vpn-hostname] >> README.md
echo ``` >> README.md
echo. >> README.md
echo #### Raspberry Pi (Test Environment) >> README.md
echo ```bash >> README.md
echo ssh [pi-user]@[pi-ip] >> README.md
echo ``` >> README.md
echo. >> README.md
echo **Note:** Aktuelle værdier findes i krypterede konfigurationsfiler. >> README.md

echo README.md updated with anonymized examples ✓
echo.

REM ======================================
REM CREATE ENCRYPTED FILES WITH REAL DATA
REM ======================================

echo Creating secure/CREDENTIALS.md with real credentials...
echo # Smart Home Credentials og Følsomme Oplysninger > secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo **ADVARSEL:** Denne fil indeholder følsomme oplysninger og skal forblive krypteret! >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ## Location Details >> secure\CREDENTIALS.md
echo - **Fuld adresse:** Skee-Tåstrupvej 12, 4370 Store Merløse, Danmark >> secure\CREDENTIALS.md
echo - **Præcis latitude:** 55.546341 >> secure\CREDENTIALS.md
echo - **Præcis longitude:** 11.716269 >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ## Network Konfiguration >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ### Intel NUC (Home Assistant) >> secure\CREDENTIALS.md
echo - **Local IP:** 192.168.1.15 >> secure\CREDENTIALS.md
echo - **IPv6:** fe80::9492:4629:cef1:c40b/64 >> secure\CREDENTIALS.md
echo - **SSH Brugernavn:** root >> secure\CREDENTIALS.md
echo - **SSH Password:** GreteFraGylleGaarden. >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ### Raspberry Pi >> secure\CREDENTIALS.md
echo - **Hostname:** raspberrypi >> secure\CREDENTIALS.md
echo - **Local IP:** 192.168.1.35 >> secure\CREDENTIALS.md
echo - **SSH Brugernavn:** gladmin >> secure\CREDENTIALS.md
echo - **SSH Password:** pitonslange. >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ## Database >> secure\CREDENTIALS.md
echo - **MySQL Root Password:** FiskePtter. >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ## External Services >> secure\CREDENTIALS.md
echo - **Smart Life User Code:** Ca5KJ60 >> secure\CREDENTIALS.md
echo. >> secure\CREDENTIALS.md
echo ## Tailscale >> secure\CREDENTIALS.md
echo - **Account:** holle-technolle.github >> secure\CREDENTIALS.md
echo - **Home Assistant Tailscale URL:** http://homeassistant.tailc0a425.ts.net:8123 >> secure\CREDENTIALS.md
echo - **Tailscale IP:** 100.93.196.4 >> secure\CREDENTIALS.md
echo - **Hassio Dashboard:** http://homeassistant.tailc0a425.ts.net:8123/hassio/dashboard >> secure\CREDENTIALS.md

echo secure/CREDENTIALS.md created ✓
echo.

REM Create SSH config file template
echo Creating secure/ssh-config with real SSH configuration...
echo # Real SSH Configuration > secure\ssh-config
echo # Copy this to ~/.ssh/config >> secure\ssh-config
echo. >> secure\ssh-config
echo Host homeassistant-nuc >> secure\ssh-config
echo     HostName 192.168.1.15 >> secure\ssh-config
echo     User root >> secure\ssh-config
echo     # Password: GreteFraGylleGaarden. >> secure\ssh-config
echo. >> secure\ssh-config
echo Host raspberry-pi >> secure\ssh-config
echo     HostName 192.168.1.35 >> secure\ssh-config
echo     User gladmin >> secure\ssh-config
echo     # Password: pitonslange. >> secure\ssh-config
echo. >> secure\ssh-config
echo Host homeassistant-tailscale >> secure\ssh-config
echo     HostName homeassistant.tailc0a425.ts.net >> secure\ssh-config
echo     User root >> secure\ssh-config
echo     # Password: GreteFraGylleGaarden. >> secure\ssh-config

echo secure/ssh-config created ✓
echo.

REM Create Home Assistant secrets template
echo Creating secure/secrets.yaml template...
echo # Home Assistant Secrets Template > secure\secrets.yaml
echo # Copy relevant values to your Home Assistant /config/secrets.yaml >> secure\secrets.yaml
echo. >> secure\secrets.yaml
echo # Database >> secure\secrets.yaml
echo mysql_password: "FiskePtter." >> secure\secrets.yaml
echo. >> secure\secrets.yaml
echo # Smart Life >> secure\secrets.yaml
echo smart_life_code: "Ca5KJ60" >> secure\secrets.yaml
echo. >> secure\secrets.yaml
echo # Location (precise coordinates) >> secure\secrets.yaml
echo home_latitude: 55.546341 >> secure\secrets.yaml
echo home_longitude: 11.716269 >> secure\secrets.yaml
echo. >> secure\secrets.yaml
echo # Network >> secure\secrets.yaml
echo local_ip_ha: "192.168.1.15" >> secure\secrets.yaml
echo local_ip_pi: "192.168.1.35" >> secure\secrets.yaml
echo tailscale_url: "homeassistant.tailc0a425.ts.net" >> secure\secrets.yaml

echo secure/secrets.yaml created ✓
echo.

REM Update .gitignore to protect sensitive files during development
echo Updating .gitignore...
echo # Backup files (prevent accidental exposure) >> .gitignore
echo *.backup >> .gitignore
echo. >> .gitignore
echo # Development secrets (before git-crypt setup) >> .gitignore
echo secrets.yaml >> .gitignore
echo config/secrets.yaml >> .gitignore
echo. >> .gitignore
echo # Temporary files >> .gitignore
echo *.tmp >> .gitignore
echo *.temp >> .gitignore

echo .gitignore updated ✓
echo.

echo ========================================
echo Anonymization complete! ✓
echo ========================================
echo.
echo **IMPORTANT NEXT STEPS:**
echo 1. Install git-crypt: choco install git-crypt
echo 2. Initialize git-crypt: git-crypt init
echo 3. Add GPG key: git-crypt add-gpg-user [YOUR-GPG-KEY-ID]
echo 4. Commit changes: git add . ^&^& git commit -m "Anonymize public docs, add encrypted credentials"
echo 5. Push to GitHub: git push
echo 6. Activate GitHub Pages (now safe!)
echo.
echo **FILES CREATED:**
echo - docs/ENVIRONMENT.md (anonymized)
echo - README.md (updated with anonymized examples)
echo - secure/CREDENTIALS.md (contains real credentials - WILL BE ENCRYPTED)
echo - secure/ssh-config (real SSH config)
echo - secure/secrets.yaml (Home Assistant secrets template)
echo - .gitattributes (git-crypt configuration)
echo - .gitignore (updated)
echo.
echo **FILES PRESERVED:**
echo - *.backup files (for verification - will be cleaned later)
echo.
echo **NEXT STEPS AFTER VERIFICATION:**
echo 1. Review anonymized files vs originals
echo 2. Install git-crypt: choco install git-crypt
echo 3. Initialize git-crypt: git-crypt init
echo 4. Add GPG key: git-crypt add-gpg-user [YOUR-GPG-KEY-ID]
echo 5. Clean backup files: del *.backup
echo 6. Remove from git history if needed: git filter-branch
echo 7. Commit changes: git add . ^&^& git commit -m "Anonymize public docs, add encrypted credentials"
echo 8. Push to GitHub: git push
echo 9. Activate GitHub Pages (now safe!)
echo.
pause
