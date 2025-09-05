
# Smart Home Projekt

Et pragmatisk smart home system baseret på Home Assistant som centralt hub, implementeret med fokus på enkelhed og vedligeholdelse.

## Arkitektur

Projektet følger princippet **"Home Assistant som Centrum"** - hvor alle enheder og integrationer konfigureres primært i Home Assistant, og andre komponenter fungerer som klienter der udnytter disse integrationer.

### Grundlæggende Principper

* **Home Assistant som hub** : Alle enheder integreres gennem HA
* **Minimer overlap** : Nye komponenter implementeres kun når de tilbyder unik funktionalitet
* **Enkelhed først** : Undgå funktionel duplikering og hold systemet vedligeholdeligt
* **Modulær struktur** : Klart opdelt kodebase med centraliseret konfiguration

## Projektstruktur

```
smart-home/
├── src/
│   └── homeassistant/          # Home Assistant konfiguration (synket fra remote)
│       ├── configuration.yaml
│       ├── automations.yaml
│       └── ...
├── docs/
│   └── Arkitektur.md          # Detaljerede arkitektur principper
├── scripts/
│   └── setup.bat              # Development setup script
└── README.md
```

## Miljø

### Hardware

* **Intel NUC** : Home Assistant OS (192.168.1.15)
* **Raspberry Pi 3** : Auxiliary services (gladmin/pitonslange.)

### Services

* **Home Assistant** : http://homeassistant.local:8123
* **Observer** : http://homeassistant.local:4357
* **MySQL** : Root password: FiskePtter.
* **Tailscale** : homeassistant node: 100.93.196.4

### External Integrations

* **Smart Life** : User Code: Ca5KJ60

## Development Setup

### Forudsætninger

* VSCode med SSH FS extension
* Git konfigureret
* SSH adgang til Home Assistant

### Quick Start

1. **Klon repository** :

```bash
   git clone [repository-url]
   cd smart-home
```

1. **Kør setup script** :

```bash
   scripts/setup.bat
```

1. **Mount Home Assistant filer** :

* `Ctrl+Shift+P` → "SSH FS: Connect as Workspace folder"
* Brug konfiguration: Host: 192.168.1.15, Root: /config, Username: root

### Manual Setup

Hvis du ikke bruger setup scriptet:

1. **SSH FS konfiguration** :

```json
   {
     "name": "HomeAssistant",
     "host": "192.168.1.15",
     "root": "/config",
     "username": "root",
     "port": 22
   }
```

1. **Sync filer** :

* Mount `/config` via SSH FS
* Kopier relevante .yaml filer til `src/homeassistant/`

## Workflow

### File Management

* Home Assistant konfiguration vedligeholdes i `/config` på serveren
* Lokale kopier i `src/homeassistant/` bruges til udvikling og versionering
* SSH FS bruges til live adgang og synkronisering

### Development Process

1. Arbejd på lokale filer i `src/homeassistant/`
2. Test ændringer via SSH FS mounted filer
3. Commit ændringer til git
4. Deploy via Home Assistant reload

### Git Workflow

```bash
# Standard workflow
git add .
git commit -m "feat: beskrivelse af ændring"
git push
```

## Komponenter

### Core System

* **Home Assistant OS** : Central hub og koordinator
* **MySQL** : Database backend
* **MQTT** : Enheds kommunikation (via HA)

### Development Tools

* **VSCode** : Primary development environment
* **SSH FS** : File system integration
* **Git** : Version control

### Network

* **Tailscale** : Secure remote access
* **Local Network** : 192.168.1.x range

## Support

For spørgsmål eller problemer, se:

* [Arkitektur dokumentation](https://claude.ai/chat/docs/Arkitektur.md)
* Home Assistant logs via Observer interface
* Git commit history for ændringsoversigt

## License

Private projekt - ikke til offentlig distribution.
