# Arkitektoniske Principper for Smart Home Projektet 
 
## Grundlæggende Principper 
 
### 1. Home Assistant som Centrum 
**"Home Assistant er centrum - integrer én gang, brug alle steder."** 
 
### 2. Minimer Overlap, Maksimer Værdi 
**"Implementér kun nyt når det tilbyder unik funktionalitet og erstatter eksisterende komponenter."** 
 
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
 
#### Raspberry Pi 
- **Udvikling og test** af tilpassede komponenter 
- **Python debugging** for AppDaemon apps 
- **Isoleret testmiljø** før deployment til Home Assistant 
 
### Etableret Udviklerworkflow 
 
#### 1. Konfigurationsændringer 
VS Code Remote SSH → Home Assistant /config → Live test → Git commit 
 
#### 2. AppDaemon Udvikling 
Lokal udvikling → Test på Raspberry Pi → Deploy til Home Assistant → Git commit 
