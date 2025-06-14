# ADR-0002: VS Code SSH Remote Development 
 
**Status:** Accepteret 
**Dato:** 14. juni 2025 
**Superseder:** N/A 
**Supersedes:** N/A 
 
## Context 
 
Vi havde behov for et effektivt og integreret udviklersetup til at: 
- Redigere Home Assistant konfigurationsfiler direkte på target systemet 
- Udvikle og teste AppDaemon apps 
- Vedligeholde konsistent kodestil og formatering 
- Integrere udvikling med vores GitHub-baserede workflow 
 
## Decision 
 
Vi implementerer **VS Code Remote Development med SSH** som vores primære udviklingsplatform. 
 
### Værktøjsstack 
- **VS Code** som central IDE 
- **Remote-SSH extension** til remote udvikling 
- **Home Assistant-specifikke extensions** til syntax support 
- **SSH forbindelser** til både Intel NUC (Home Assistant) og Raspberry Pi 
 
## Consequences 
 
**Positive:** 
- Direkte redigering af Home Assistant konfiguration med øjeblikkelig test 
- Syntax highlighting og autocomplete for Home Assistant YAML 
- Integreret terminal adgang til både Home Assistant og Raspberry Pi 
- Git integration direkte fra development environment 
 
**Implementation Status:** ✅ Fuldt implementeret og funktionsdygtig 
