# Smart Home Project

Dette er mit Smart Home projekt baseret på Home Assistant som centrum - et pragmatisk eksempel på hvordan moderne IoT-systemer kan designes med fokus på enkelhed, sikkerhed og vedligeholdelse.

**📚 [Komplet Dokumentation](https://holle-technolle.github.io/smart-home/)** | **📋 [Kanban Board](https://github.com/users/Holle-TechNolle/projects/3)**

## Mission og Design-filosofi

Projektet demonstrerer en **pragmatisk service-orienteret arkitektur** hvor Home Assistant fungerer som en modulær kerne der udstiller funktionalitet til specialiserede komponenter. Tilgangen balancerer teoretisk soliditet med praktisk anvendelighed gennem konsekvent anvendelse af to kerneprincipper:

**Home Assistant som centrum** - Alle integrationer og enheder administreres centralt for at undgå redundans og sikre konsistent konfiguration.

**Minimer overlap, maksimer værdi** - Nye komponenter introduceres kun når de tilbyder unik funktionalitet og kan erstatte eksisterende løsninger.

Dette design-paradigme prioriterer langsigtet vedligeholdelse over kortsigtede features, sikkerhed som et fundament snarere end en efterklog, og dokumenteret beslutningstagning der gør systemet transparent og udvidelsesværdigt.

Projektet illustrerer hvordan komplekse tekniske systemer kan bygges med professionel struktur, samtidig med at de forbliver tilgængelige og brugbare i praksis.

## Hvad Virker Nu

### Platform og Infrastruktur
- **Home Assistant OS** kørende på Intel NUC
- **VS Code Remote Development** setup med SSH til live-redigering
- **GitHub** som central platform for kode og dokumentation
- **GitHub Pages** til dokumentations-hosting
- **Tailscale VPN** for sikker remote adgang

### Integrationer
- **Smart Life** - WiFi-baserede enheder
- **MySQL Database** - Persistent storage til Home Assistant recorder
- **Weather Integration** - Lokal vejrdata

### Udviklerværktøjer
- **Advanced SSH & Web Terminal** add-on med ZSH shell
- **VS Code Extensions** til YAML, Python og Git
- **GitHub Kanban Board** til task management

### Dokumentation
- **Architecture Decision Records** (ADR) for vigtige beslutninger
- **Environment Documentation** - Hardware og netværk setup
- **Architecture Guide** - Design-principper og workflow

Se [ENVIRONMENT.md](https://holle-technolle.github.io/smart-home/docs/ENVIRONMENT.md) for detaljer om hardware og netværk.

## Roadmap

### I Gang
- **Heating Control System** - FHEM-baseret varmestyring (se [heating-concept.md](https://holle-technolle.github.io/smart-home/docs/guides/heating-concept.md))
  - **Fase 1:** FHEM setup på Raspberry Pi 3 til kontrol af EQ3 MAX termostater
  - **Fase 2:** MQTT integration med Home Assistant for unified dashboard
  - Erstatter ustabil MAX Cube med open source løsning

### Planlagt
- **MQTT Broker** - Message bus til system-integration
- **Presence Detection** - Avanceret tilstedeværelsesstyring integration med varmestyring
- **Energy Monitoring** - Strømforbrug tracking og optimering
- **AppDaemon Integration** - Python-baseret automation engine (efter MQTT etableret)

Se [Kanban Board](https://github.com/users/Holle-TechNolle/projects/3) for aktuel status på alle opgaver.

## Task Management og Projektstyring

Dette projekt anvender **GitHub's indbyggede Kanban-board** for kontinuerlig task management og organisk udvikling.

### Projektboard: [Smart Home Kanban](https://github.com/users/Holle-TechNolle/projects/3)

#### Workflow struktur:

* **Backlog** - Ideer og planlagte opgaver
* **In Progress** - Aktiv udvikling og test
* **Implementing** - Deployment og produktionsindkøring med parameterjusteringer
* **Done** - Stabile features i produktion

#### Kanban-filosofi for personlige projekter:

Kanban anvendes uden sprints for at understøtte organisk udvikling hvor opgaver håndteres kontinuerligt efter prioritet og kapacitet. Dette undgår Jira's problematiske auto-completion af sprints der kan resultere i tab af tasks.

#### Task-håndtering:

**Indholdstunge tasks** - Detaljeret information om test, implementering og roll-back procedurer gemmes direkte på task-kortet for at placere viden tæt på anvendelsesstedet.

**Fejlhåndtering** - Ved alvorlige implementeringsproblemer flyttes tasks tilbage til "In Progress" for redesign og re-test.

**Arkivering** - Gennemførte tasks forbliver i "Done" for reference og flyttes manuelt til arkivfunktion efter en periode.

#### Integration med udvikling:

* Issues linkes direkte til commits via `#issue-nummer`
* Automated workflow baseret på commit references
* Labels for kategorisering: `enhancement`, `documentation`, `bug`, `security`, `infrastructure`

#### Fremtidig udvidelse:

Projektets task management kan udvides med NoSQL-baseret wiki-funktionalitet hvor task-indhold indekseres for avanceret søgning og knowledge management.

## Dokumentation

Komplet teknisk dokumentation findes på [GitHub Pages](https://holle-technolle.github.io/smart-home/):

### Arkitektur og Design
- **[Architecture](https://holle-technolle.github.io/smart-home/docs/ARCHITECTURE.md)** - Design-principper og workflow
- **[Environment](https://holle-technolle.github.io/smart-home/docs/ENVIRONMENT.md)** - Hardware, netværk og software setup

### Architecture Decision Records
- **[ADR 0001](https://holle-technolle.github.io/smart-home/docs/decisions/0001-github-platform.md)** - Valg af GitHub som platform
- **[ADR 0002](https://holle-technolle.github.io/smart-home/docs/decisions/0002-vscode-ssh-development.md)** - VS Code Remote SSH workflow
- **[ADR 0003](https://holle-technolle.github.io/smart-home/docs/decisions/0003-fhem-eq3-max-control.md)** - FHEM til EQ3 MAX termostat kontrol
- **[ADR 0004](https://holle-technolle.github.io/smart-home/docs/decisions/0004-mqtt-integration-layer.md)** - MQTT som integration layer

### Tekniske Guider
- **[FHEM Installation](https://holle-technolle.github.io/smart-home/docs/guides/FHEM-installation-guide.md)** - Komplet setup guide til Raspberry Pi
- **[HA MQTT Integration](https://holle-technolle.github.io/smart-home/docs/guides/HA-MQTT-integration-guide.md)** - Home Assistant MQTT konfiguration

## Udviklersetup

### Forudsætninger

* **VS Code** med Remote-SSH extension installeret
* **Git** konfigureret med SSH nøgler eller HTTPS credentials
* **Netværksadgang** til lokalt netværk eller VPN

### Første gang setup

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
   * VS Code vil prompte dig til at installere anbefalede extensions
   * Klik "Install All" for optimal udvikleroplevelse

### SSH Forbindelser (Eksempler)

#### Home Assistant (Intel NUC)

```bash
ssh [ha-user]@[local-ip]
# Eller via VPN
ssh [ha-user]@[vpn-hostname]
```

#### Raspberry Pi (Test Environment)

```bash
ssh [pi-user]@[pi-ip]
```

**Note:** Aktuelle værdier findes i krypterede konfigurationsfiler.

### Udviklerworkflow

#### Home Assistant Konfiguration

1. **Remote SSH til Home Assistant** via VS Code
2. **Rediger filer** i `/config` mappen direkte
3. **Test ændringer** live i Home Assistant UI
4. **Commit ændringer** til GitHub repository

#### AppDaemon Udvikling

1. **Udvikl lokalt** eller på Raspberry Pi
2. **Test funktionalitet** i isoleret miljø
3. **Deploy til Home Assistant** når stabil
4. **Dokumenter ændringer** og commit til GitHub

### VS Code Remote Development

#### Få adgang til Home Assistant filer:

1. `Ctrl+Shift+P` → "Remote-SSH: Connect to Host"
2. Vælg din Home Assistant host
3. Åbn `/config` mappen
4. Rediger `configuration.yaml`, `automations.yaml`, osv.

#### Features tilgængelige:

* Syntax highlighting for Home Assistant YAML
* Autocomplete og validering
* Integreret terminal på remote systemer
* Live debugging af automationer
* Git integration for version control

### Projektstruktur:

```
smart-home/
├── docs/                     # Projektdokumentation
│   ├── ARCHITECTURE.md       # Design-principper
│   ├── ENVIRONMENT.md        # Hardware/netværk setup
│   ├── decisions/            # Architecture Decision Records
│   └── guides/               # Koncepter og guider
├── src/homeassistant/        # HA konfiguration (sync til /config)
│   ├── configuration.yaml
│   ├── automations.yaml
│   ├── scripts.yaml
│   └── scenes.yaml
├── secure/                   # Krypterede credentials (ikke i Git)
└── .vscode/                  # VS Code workspace indstillinger
```

### Troubleshooting

#### SSH forbindelsesproblemer:

* Kontroller at Advanced SSH & Web Terminal add-on kører
* Verificer at compatibility mode er aktiveret
* Test forbindelse med `ssh -v` for debug output

#### YAML syntax fejl:

* Brug VS Code's indbyggede YAML validering
* Tjek indentation (skal være 2 spaces)
* Validér konfiguration i Home Assistant før restart

For yderligere hjælp, se [dokumentationen](https://holle-technolle.github.io/smart-home/) eller opret en issue i repositoriet.
