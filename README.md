# Smart Home Project

A comprehensive Home Assistant-based smart home automation system with focus on heating control, lighting automation, and integrated device management.

## Project Status

**Current Phase:** MQTT Integration & Automation Development  
**Last Updated:** 5 January 2025

### Completed
- ✅ Home Assistant on Bee-link mini PC
- ✅ VS Code Remote SSH development environment
- ✅ GitHub repository and documentation
- ✅ MySQL database integration
- ✅ Smart Life WiFi devices
- ✅ Tailscale VPN
- ✅ MQTT broker configured and operational
- ✅ Custom Home Assistant components (Protected Switch)
- ✅ Advanced automations with parallel execution

### In Progress
- 🚧 FHEM heating control system (awaiting USB CUL hardware)
- 🚧 Expanding automation library
- 🚧 Testing and refinement of complex sequences

### Planned
- 📅 FHEM-HA MQTT integration (when FHEM operational)
- 📅 Presence detection integration
- 📅 Energy monitoring
- 📅 AppDaemon advanced automations

## Architecture Overview

### Hardware
- **Bee-link Mini PC** (192.168.1.15) - Home Assistant OS
- **Raspberry Pi 3** (192.168.1.28) - MQTT broker & MySQL database
- **EQ3 MAX Thermostats** - Legacy heating hardware (controlled via FHEM when implemented)

### Software Stack
```
Home Assistant (Central Hub)
    ↕ MQTT
FHEM (Raspberry Pi) - Future
    ↕ RF 868 MHz
EQ3 MAX Thermostats
```

### Key Integrations
- **MQTT** - Message broker for distributed communication
- **MySQL** - Database recorder for long-term data storage
- **Smart Life** - WiFi device control
- **Tailscale** - VPN access
- **Custom Components** - Protected Switch for safety-critical devices

## Quick Start

### Prerequisites
- Home Assistant OS running
- VS Code with Remote SSH extension
- Git with git-crypt (for encrypted credentials)
- SSH access to both HA and Raspberry Pi

### Access URLs
- **Home Assistant:** http://homeassistant.local:8123
- **Observer:** http://homeassistant.local:4357
- **VPN:** http://homeassistant.[vpn-id].ts.net:8123

### Initial Setup
```bash
# Clone repository
git clone git@github.com:Holle-TechNolle/smart-home.git
cd smart-home

# Unlock encrypted files (requires git-crypt key)
git-crypt unlock

# Connect to Home Assistant via VS Code Remote SSH
# Target: homeassistant.local or 192.168.1.15
```

## Project Structure
```
smart-home/
├── docs/                          # Documentation
│   ├── ARCHITECTURE.md            # System design principles
│   ├── ENVIRONMENT.md             # Hardware & network setup
│   ├── decisions/                 # Architecture Decision Records
│   │   ├── 0001-github-platform.md
│   │   ├── 0002-vscode-ssh-development.md
│   │   ├── ADR-0003-fhem-eq3-max-control.md
│   │   ├── ADR-0004-mqtt-integration-layer.md
│   │   └── ADR-0005-flash-max-cube-to-cunx.md
│   ├── guides/                    # Technical guides
│   │   ├── heating-concept.md
│   │   ├── FHEM-installation-guide.md
│   │   └── HA-MQTT-integration-guide.md
│   └── troubleshooting/           # Problem-solving documentation
│       └── github-pages-jekyll-fix.md
├── src/                           # Source code
│   └── homeassistant/             # Home Assistant configuration
│       ├── configuration.yaml
│       ├── automations.yaml
│       ├── scripts.yaml
│       ├── scenes.yaml
│       └── protected_switch/      # Custom component
├── secure/                        # Encrypted credentials (git-crypt)
│   └── readme.md                  # Security documentation (not encrypted)
├── .vscode/                       # VS Code configuration
└── README.md                      # This file
```

## Documentation

### Main Documents
- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - Design principles and system architecture
- **[ENVIRONMENT.md](docs/ENVIRONMENT.md)** - Hardware, network, and software setup

### Architecture Decision Records (ADRs)
- **[ADR-0001](docs/decisions/0001-github-platform.md)** - GitHub as platform
- **[ADR-0002](docs/decisions/0002-vscode-ssh-development.md)** - VS Code Remote SSH
- **[ADR-0003](docs/decisions/ADR-0003-fhem-eq3-max-control.md)** - FHEM for EQ3 MAX
- **[ADR-0004](docs/decisions/ADR-0004-mqtt-integration-layer.md)** - MQTT integration layer
- **[ADR-0005](docs/decisions/ADR-0005-flash-max-cube-to-cunx.md)** - MAX Cube flash decision (rejected)

### Technical Guides
- **[Heating Concept](docs/guides/heating-concept.md)** - Heating system conceptual design
- **[FHEM Installation](docs/guides/FHEM-installation-guide.md)** - FHEM setup on Raspberry Pi
- **[MQTT Integration](docs/guides/HA-MQTT-integration-guide.md)** - Home Assistant MQTT setup
- **[AppDaemon Guide](docs/guides/APPDAEMON.md)** - Advanced Python automations (planned)

## Key Features

### Heating Control (In Development)
- FHEM-based control of EQ3 MAX thermostats
- MQTT integration with Home Assistant
- Time-based heating schedules
- Away mode automation
- Individual room temperature control

### Lighting Automation
- Motion-based activation
- Time-based scenes
- Multi-room coordination
- Integration with leaving-home sequences

### Device Protection
- Custom Protected Switch component
- Prevents accidental PC shutdown during active use
- Power consumption monitoring
- Safe shutdown sequences

### Complex Automations
- Parallel execution threads
- Dynamic wait conditions
- State-based logic
- Multi-area coordination

## Development Workflow

### Using VS Code Remote SSH
1. Open VS Code
2. Connect to `homeassistant.local` or `192.168.1.15`
3. Edit configuration files directly
4. Test changes live
5. Commit to repository

### Configuration Management
- **Direct editing:** Via VS Code SSH for complex changes
- **UI editing:** For simple modifications and testing
- **Version control:** All changes committed to Git
- **Documentation:** Changes logged in ADRs when architectural

### Testing Approach
1. Test in development environment first
2. Verify configuration with `ha core check`
3. Monitor logs for errors
4. Gradual rollout of new features
5. Keep backups before major changes

## Security

### Credential Management
- Git-crypt encryption for sensitive files
- All files in `/secure/` encrypted (except `readme.md`)
- `.gitattributes` controls encryption rules
- Never commit credentials unencrypted

### Network Security
- Tailscale VPN for remote access
- SSH key-based authentication
- Local network only for critical services
- Regular security updates

### Access Control
- Separate user accounts for different services
- SSH keys per device
- Regular password rotation
- Audit logs enabled

## Contributing

This is a personal project, but documentation is maintained for:
- Personal reference and continuity
- Knowledge sharing with community
- Future migration paths
- Learning and experimentation

## Resources

### External Links
- **GitHub Repository:** [Holle-TechNolle/smart-home](https://github.com/Holle-TechNolle/smart-home)
- **GitHub Pages:** [Project Documentation](https://holle-technolle.github.io/smart-home/)
- **Project Board:** [Kanban Board](https://github.com/users/Holle-TechNolle/projects/3)

### Home Assistant
- **Official Documentation:** [home-assistant.io](https://www.home-assistant.io/)
- **Community Forum:** [community.home-assistant.io](https://community.home-assistant.io/)
- **HACS Store:** [hacs.xyz](https://hacs.xyz/)

### FHEM
- **Official Wiki:** [wiki.fhem.de](https://wiki.fhem.de/)
- **MAX Module:** [wiki.fhem.de/wiki/MAX](https://wiki.fhem.de/wiki/MAX)
- **CUL Hardware:** [wiki.fhem.de/wiki/CUL](https://wiki.fhem.de/wiki/CUL)

### MQTT
- **Eclipse Mosquitto:** [mosquitto.org](https://mosquitto.org/)
- **MQTT.org:** [mqtt.org](https://mqtt.org/)
- **HA MQTT Integration:** [home-assistant.io/integrations/mqtt](https://www.home-assistant.io/integrations/mqtt/)

## Project Principles

From [ARCHITECTURE.md](docs/ARCHITECTURE.md):

1. **Home Assistant as Centre** - All integrations converge here
2. **Minimise Overlap, Maximise Value** - Only add when unique and replaces existing
3. **Separation of Concerns** - Critical systems isolated from experiments
4. **Documentation-Driven** - Decisions captured in ADRs
5. **Pragmatic SOA** - Service-oriented with modular monolith core

## Licence

This is a personal project. Code and documentation are provided as-is for reference and learning purposes.

---

**Maintained by:** Holger  
**Language Policy:** Technical content in English, communication in Danish  
**Last Updated:** 5 January 2025