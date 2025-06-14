# Smart Home Project 
 
Dette er mit Smart Home projekt baseret på Home Assistant som centrum. 
 
## Arkitektoniske Principper 
- Home Assistant som centrum 
- Minimer overlap, maksimer værdi 
 
## 🛠️ Udviklersetup 
 
### Forudsætninger 
- **VS Code** med Remote-SSH extension installeret 
- **Git** konfigureret med SSH nøgler eller HTTPS credentials 
- **Netværksadgang** til lokalt netværk (192.168.1.x) eller Tailscale VPN 
 
### 🚀 Første gang setup 
 
1. **Klon repository:** 
   ```bash 
   git clone https://github.com/Holle-TechNolle/smart-home.git 
   cd smart-home 
   ``` 
 
2. **Åbn i VS Code:** 
   ```bash 
   code . 
   ``` 
 
3. **Installer anbefalede extensions:** 
   - VS Code vil prompte dig til at installere anbefalede extensions 
   - Klik "Install All" for optimal udvikleroplevelse 
 
### 🔗 SSH Forbindelser 
 
#### Home Assistant (Intel NUC) 
```bash 
ssh root@192.168.1.15 
# Eller via Tailscale 
ssh root@homeassistant.tailc0a425.ts.net 
``` 
 
#### Raspberry Pi (Test Environment) 
```bash 
ssh gladmin@192.168.1.35 
``` 
 
### 🔄 Udviklerworkflow 
 
#### Home Assistant Konfiguration 
1. **Remote SSH til Home Assistant** via VS Code 
2. **Rediger filer** i `/config` mappen direkte 
3. **Test ændringer** live i Home Assistant UI 
4. **Commit ændringer** til GitHub repository 
 
### 🎯 VS Code Remote Development 
 
#### Få adgang til Home Assistant filer: 
1. `Ctrl+Shift+P` → "Remote-SSH: Connect to Host" 
2. Vælg "homeassistant-nuc" 
3. Åbn `/config` mappen 
4. Rediger `configuration.yaml`, `automations.yaml`, osv. 
 
#### Features tilgængelige: 
- ✅ **Syntax highlighting** for Home Assistant YAML 
- ✅ **Autocomplete** og validering 
- ✅ **Integreret terminal** på remote systemer 
- ✅ **Live debugging** af automationer 
- ✅ **Git integration** for version control 
