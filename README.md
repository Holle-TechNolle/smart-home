# Smart Home Project

Dette er mit Smart Home projekt baseret på Home Assistant som centrum

- et pragmatisk eksempel på hvordan moderne IoT-systemer kan designes med fokus på enkelhed, sikkerhed og vedligeholdelse.

## Mission og Design-filosofi

Projektet demonstrerer en **pragmatisk service-orienteret arkitektur** hvor Home Assistant fungerer som en modulær kerne der udstiller funktionalitet til specialiserede komponenter. Tilgangen balancerer teoretisk soliditet med praktisk anvendelighed gennem konsekvent anvendelse af to kerneprincipper:

**Home Assistant som centrum** - Alle integrationer og enheder administreres centralt for at undgå redundans og sikre konsistent konfiguration.

**Minimer overlap, maksimer værdi** - Nye komponenter introduceres kun når de tilbyder unik funktionalitet og kan erstatte eksisterende løsninger.

Dette design-paradigme prioriterer langsigtet vedligeholdelse over kortsigtede features, sikkerhed som et fundament snarere end en efterklog, og dokumenteret beslutningstagning der gør systemet transparent og udvidelsesværdigt.

Projektet illustrerer hvordan komplekse tekniske systemer kan bygges med professionel struktur, samtidig med at de forbliver tilgængelige og brugbare i praksis.

## 📋 Task Management og Projektstyring

Dette projekt anvender **GitHub's indbyggede task management** i stedet for eksterne værktøjer som Jira. Dette valg understøtter projektets arkitektoniske princip om at minimere værktøjskompleksitet og maksimere integration.

### GitHub Projects Integration

**Projektboard:** [Smart Home Kanban](https://github.com/Holle-TechNolle/smart-home/projects)

#### Workflow struktur:

- **Backlog** - Ideer og fremtidige tasks
- **To Do** - Planlagte opgaver klar til påbegyndelse
- **In Progress** - Aktive arbejdsområder
- **Review** - Implementeret og klar til test/validering
- **Done** - Gennemførte tasks

#### Issue kategorisering:

- **`enhancement`** - Nye features og forbedringer
- **`documentation`** - Dokumentation og guides
- **`bug`** - Fejlrettelser og problemer
- **`security`** - Sikkerhedsrelaterede tasks
- **`infrastructure`** - DevOps og systemkonfiguration

#### Integration med udvikling:

- Issues linkes direkte til commits via `#issue-nummer`
- Pull requests refererer automatisk til relaterede issues
- Automated workflow flytter issues mellem kolonner baseret på commit status
- Milestone-baseret planlægning for større projektfaser

#### Drift og vedligeholdelse:

Task management fortsætter efter udviklingsfasen til løbende systemvedligeholdelse:

- **Maintenance tasks** - Opdateringer og patches
- **Monitoring issues** - Systemovervågning og alerts
- **Configuration changes** - Konfigurationsjusteringer
- **Performance optimization** - Systemoptimering

### Adgang og navigation:

Projektets task management tilgås via GitHub repository under **"Projects"** tab eller direkte gennem Issues-sektionen med filtering efter labels og milestones.

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

## 🔗 SSH Forbindelser (Eksempler)

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
