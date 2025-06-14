@echo off
echo Updating Smart Home documentation...
echo.

REM Create backup of existing files
echo Creating backup of existing files...
if exist docs\ENVIRONMENT.md copy docs\ENVIRONMENT.md docs\ENVIRONMENT.md.backup
if exist docs\ARCHITECTURE.md copy docs\ARCHITECTURE.md docs\ARCHITECTURE.md.backup
if exist README.md copy README.md README.md.backup
echo Backup created ✓
echo.

REM Update ENVIRONMENT.md
echo Updating docs/ENVIRONMENT.md...
echo # Environment Setup > docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Hardware >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Intel NUC (Home Assistant) >> docs\ENVIRONMENT.md
echo - **IPv4:** 192.168.1.15/24 >> docs\ENVIRONMENT.md
echo - **IPv6:** fe80::9492:4629:cef1:c40b/64 >> docs\ENVIRONMENT.md
echo - **OS Version:** Home Assistant OS 15.2 >> docs\ENVIRONMENT.md
echo - **Home Assistant Core:** 2025.6.1 >> docs\ENVIRONMENT.md
echo - **Home Assistant Supervisor:** 2025.05.5 >> docs\ENVIRONMENT.md
echo - **Architecture:** amd64 / generic-x86-64 >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Raspberry Pi 3 >> docs\ENVIRONMENT.md
echo - **Hostname:** raspberrypi >> docs\ENVIRONMENT.md
echo - **IPv4:** 192.168.1.35 >> docs\ENVIRONMENT.md
echo - **Brugernavn:** gladmin >> docs\ENVIRONMENT.md
echo - **OS:** Raspberry Pi OS (Debian GNU/Linux) >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Network og Connectivity >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Lokal adgang >> docs\ENVIRONMENT.md
echo - **Home Assistant URL:** http://homeassistant.local:8123 >> docs\ENVIRONMENT.md
echo - **Home Assistant (IP):** http://192.168.1.15:8123 >> docs\ENVIRONMENT.md
echo - **Observer URL:** http://homeassistant.local:4357 >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Tailscale adgang >> docs\ENVIRONMENT.md
echo - **Home Assistant URL:** http://homeassistant.tailc0a425.ts.net:8123 >> docs\ENVIRONMENT.md
echo - **Tailscale IP:** 100.93.196.4 >> docs\ENVIRONMENT.md
echo - **Hassio dashboard:** http://homeassistant.tailc0a425.ts.net:8123/hassio/dashboard >> docs\ENVIRONMENT.md
echo - **Tailscale konto:** holle-technolle.github >> docs\ENVIRONMENT.md
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
echo - **Adresse:** Skee-Tåstrupvej 12, 4370 Store Merløse, Danmark >> docs\ENVIRONMENT.md
echo - **Latitude:** 55.546341 >> docs\ENVIRONMENT.md
echo - **Longitude:** 11.716269 >> docs\ENVIRONMENT.md
echo - **Elevation:** 52 meter >> docs\ENVIRONMENT.md
echo - **Unit System:** Metric >> docs\ENVIRONMENT.md
echo - **Tidszone:** Europe/Copenhagen >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## SSH Adgang >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### Konfigurerede forbindelser >> docs\ENVIRONMENT.md
echo - **Intel NUC (Home Assistant):** `ssh root@192.168.1.15` >> docs\ENVIRONMENT.md
echo - **Raspberry Pi:** `ssh gladmin@192.168.1.35` >> docs\ENVIRONMENT.md
echo - **Via Tailscale:** `ssh root@homeassistant.tailc0a425.ts.net` >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ### SSH Konfiguration >> docs\ENVIRONMENT.md
echo Alle forbindelser konfigureret i `~/.ssh/config` for nem adgang via VS Code Remote SSH extension. >> docs\ENVIRONMENT.md

echo docs/ENVIRONMENT.md updated ✓
echo.

REM Create ADR-0002
echo Creating docs/decisions/0002-vscode-ssh-development.md...
echo # ADR-0002: VS Code SSH Remote Development > docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo **Status:** Accepteret >> docs\decisions\0002-vscode-ssh-development.md
echo **Dato:** 14. juni 2025 >> docs\decisions\0002-vscode-ssh-development.md
echo **Superseder:** N/A >> docs\decisions\0002-vscode-ssh-development.md
echo **Supersedes:** N/A >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo ## Context >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo Vi havde behov for et effektivt og integreret udviklersetup til at: >> docs\decisions\0002-vscode-ssh-development.md
echo - Redigere Home Assistant konfigurationsfiler direkte på target systemet >> docs\decisions\0002-vscode-ssh-development.md
echo - Udvikle og teste AppDaemon apps >> docs\decisions\0002-vscode-ssh-development.md
echo - Vedligeholde konsistent kodestil og formatering >> docs\decisions\0002-vscode-ssh-development.md
echo - Integrere udvikling med vores GitHub-baserede workflow >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo ## Decision >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo Vi implementerer **VS Code Remote Development med SSH** som vores primære udviklingsplatform. >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo ### Værktøjsstack >> docs\decisions\0002-vscode-ssh-development.md
echo - **VS Code** som central IDE >> docs\decisions\0002-vscode-ssh-development.md
echo - **Remote-SSH extension** til remote udvikling >> docs\decisions\0002-vscode-ssh-development.md
echo - **Home Assistant-specifikke extensions** til syntax support >> docs\decisions\0002-vscode-ssh-development.md
echo - **SSH forbindelser** til både Intel NUC (Home Assistant) og Raspberry Pi >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo ## Consequences >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo **Positive:** >> docs\decisions\0002-vscode-ssh-development.md
echo - Direkte redigering af Home Assistant konfiguration med øjeblikkelig test >> docs\decisions\0002-vscode-ssh-development.md
echo - Syntax highlighting og autocomplete for Home Assistant YAML >> docs\decisions\0002-vscode-ssh-development.md
echo - Integreret terminal adgang til både Home Assistant og Raspberry Pi >> docs\decisions\0002-vscode-ssh-development.md
echo - Git integration direkte fra development environment >> docs\decisions\0002-vscode-ssh-development.md
echo. >> docs\decisions\0002-vscode-ssh-development.md
echo **Implementation Status:** ✅ Fuldt implementeret og funktionsdygtig >> docs\decisions\0002-vscode-ssh-development.md

echo ADR-0002 created ✓
echo.

REM Add to ARCHITECTURE.md (append to existing file)
echo Adding developer workflow section to docs/ARCHITECTURE.md...
echo. >> docs\ARCHITECTURE.md
echo ## Udviklerværktøjer og Workflow >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ### VS Code som Primær IDE >> docs\ARCHITECTURE.md
echo VS Code anvendes som det centrale udviklingsværktøj med følgende konfiguration: >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo #### Extensions >> docs\ARCHITECTURE.md
echo - **Home Assistant Config Helper** - YAML autocomplete og validering >> docs\ARCHITECTURE.md
echo - **Python** - AppDaemon udvikling og debugging >> docs\ARCHITECTURE.md
echo - **YAML** - Syntax highlighting og formatering >> docs\ARCHITECTURE.md
echo - **GitLens** - Git integration og historik >> docs\ARCHITECTURE.md
echo - **Remote - SSH** - Remote development capabilities >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ### SSH Remote Development >> docs\ARCHITECTURE.md
echo Direkte udvikling på target systemer via SSH: >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo #### Intel NUC (Home Assistant) >> docs\ARCHITECTURE.md
echo - **Direkte adgang** til `/config` mappe med alle Home Assistant filer >> docs\ARCHITECTURE.md
echo - **Live redigering** af `configuration.yaml`, `automations.yaml`, osv. >> docs\ARCHITECTURE.md
echo - **Øjeblikkelig test** af ændringer i Home Assistant >> docs\ARCHITECTURE.md
echo - **ZSH shell** for forbedret terminal oplevelse >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo #### Raspberry Pi >> docs\ARCHITECTURE.md
echo - **Udvikling og test** af tilpassede komponenter >> docs\ARCHITECTURE.md
echo - **Python debugging** for AppDaemon apps >> docs\ARCHITECTURE.md
echo - **Isoleret testmiljø** før deployment til Home Assistant >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ### Etableret Udviklerworkflow >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo #### 1. Konfigurationsændringer >> docs\ARCHITECTURE.md
echo VS Code Remote SSH → Home Assistant /config → Live test → Git commit >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo #### 2. AppDaemon Udvikling >> docs\ARCHITECTURE.md
echo Lokal udvikling → Test på Raspberry Pi → Deploy til Home Assistant → Git commit >> docs\ARCHITECTURE.md

echo ARCHITECTURE.md updated ✓
echo.

REM Add to README.md (append to existing file)
echo Adding developer setup section to README.md...
echo. >> README.md
echo ## 🛠️ Udviklersetup >> README.md
echo. >> README.md
echo ### Forudsætninger >> README.md
echo - **VS Code** med Remote-SSH extension installeret >> README.md
echo - **Git** konfigureret med SSH nøgler eller HTTPS credentials >> README.md
echo - **Netværksadgang** til lokalt netværk (192.168.1.x) eller Tailscale VPN >> README.md
echo. >> README.md
echo ### 🚀 Første gang setup >> README.md
echo. >> README.md
echo 1. **Klon repository:** >> README.md
echo    ```bash >> README.md
echo    git clone https://github.com/Holle-TechNolle/smart-home.git >> README.md
echo    cd smart-home >> README.md
echo    ``` >> README.md
echo. >> README.md
echo 2. **Åbn i VS Code:** >> README.md
echo    ```bash >> README.md
echo    code . >> README.md
echo    ``` >> README.md
echo. >> README.md
echo 3. **Installer anbefalede extensions:** >> README.md
echo    - VS Code vil prompte dig til at installere anbefalede extensions >> README.md
echo    - Klik "Install All" for optimal udvikleroplevelse >> README.md
echo. >> README.md
echo ### 🔗 SSH Forbindelser >> README.md
echo. >> README.md
echo #### Home Assistant (Intel NUC) >> README.md
echo ```bash >> README.md
echo ssh root@192.168.1.15 >> README.md
echo # Eller via Tailscale >> README.md
echo ssh root@homeassistant.tailc0a425.ts.net >> README.md
echo ``` >> README.md
echo. >> README.md
echo #### Raspberry Pi (Test Environment) >> README.md
echo ```bash >> README.md
echo ssh gladmin@192.168.1.35 >> README.md
echo ``` >> README.md
echo. >> README.md
echo ### 🔄 Udviklerworkflow >> README.md
echo. >> README.md
echo #### Home Assistant Konfiguration >> README.md
echo 1. **Remote SSH til Home Assistant** via VS Code >> README.md
echo 2. **Rediger filer** i `/config` mappen direkte >> README.md
echo 3. **Test ændringer** live i Home Assistant UI >> README.md
echo 4. **Commit ændringer** til GitHub repository >> README.md
echo. >> README.md
echo ### 🎯 VS Code Remote Development >> README.md
echo. >> README.md
echo #### Få adgang til Home Assistant filer: >> README.md
echo 1. `Ctrl+Shift+P` → "Remote-SSH: Connect to Host" >> README.md
echo 2. Vælg "homeassistant-nuc" >> README.md
echo 3. Åbn `/config` mappen >> README.md
echo 4. Rediger `configuration.yaml`, `automations.yaml`, osv. >> README.md
echo. >> README.md
echo #### Features tilgængelige: >> README.md
echo - ✅ **Syntax highlighting** for Home Assistant YAML >> README.md
echo - ✅ **Autocomplete** og validering >> README.md
echo - ✅ **Integreret terminal** på remote systemer >> README.md
echo - ✅ **Live debugging** af automationer >> README.md
echo - ✅ **Git integration** for version control >> README.md

echo README.md updated ✓
echo.

echo.
echo Documentation update complete! ✓
echo.
echo Files updated:
echo - docs/ENVIRONMENT.md (with backup)
echo - docs/ARCHITECTURE.md (appended)
echo - README.md (appended)
echo - docs/decisions/0002-vscode-ssh-development.md (new)
echo.
echo Next steps:
echo 1. Review the updated files
echo 2. git add .
echo 3. git commit -m "Update documentation with SSH Remote Development setup"
echo 4. git push
echo.
pause
