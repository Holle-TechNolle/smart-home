# ADR-0004: MQTT som Integration Layer

**Status:** Accepteret  
**Dato:** 26. oktober 2025  
**Supersedes:** N/A  
**Superseded by:** N/A  
**Related to:** ADR-0003 (FHEM til EQ3 MAX kontrol)

## Context

Med beslutningen om at implementere FHEM på Raspberry Pi til varmestyring (ADR-0003), har vi brug for en måde at integrere FHEM med Home Assistant på. Home Assistant skal kunne:
- Vise temperatur-data fra alle termostater
- Sende temperatur-kommandoer til FHEM
- Inkludere heating i automationer sammen med andre enheder
- Logge historiske temperatur-data

Samtidig skal løsningen:
- Respektere separation of concerns (heating isolated fra HA)
- Understøtte graceful degradation (heating fungerer hvis HA går ned)
- Være udvidelig til fremtidige integration behov
- Være standard og ikke vendor-locked

## Alternatives Considered

### Alternative 1: REST API
FHEM eksponerer REST API, HA kalder direkte.

**Fordele:**
- HTTP er universelt
- Simpelt request/response pattern
- Nem debugging med curl

**Ulemper:**
- Synkron kommunikation - blocking calls
- Polling nødvendigt for status updates
- Overhead ved hyppige requests
- Ingen event-driven updates
- Tight coupling mellem systemer

**Konklusion:** For meget overhead og polling for real-time data.

### Alternative 2: Direct Database Integration
FHEM og HA deler MySQL database.

**Fordele:**
- Data persisteret ét sted
- Ingen extra middleware
- SQL queries for kompleks data

**Ulemper:**
- Tight coupling via schema
- Concurrent write conflicts
- Database bliver single point of failure
- Svært at udvide til andre systemer
- Schema changes påvirker begge systemer

**Konklusion:** For tight coupling, dårlig separation.

### Alternative 3: Home Assistant Custom Component
Byg custom HACS component til FHEM.

**Fordele:**
- Native HA integration
- Looks like any other integration

**Ulemper:**
- Vedligeholdelse af custom Python kode
- Tighter coupling end nødvendigt
- Limited reusability for andre projekter
- Breaking changes ved HA updates

**Konklusion:** Overkill for et personligt projekt.

### Alternative 4: MQTT Message Bus
FHEM og HA kommunikerer via MQTT broker.

**Fordele:**
- Async pub/sub pattern - ingen blocking
- Loose coupling - systemer kender ikke hinanden
- Event-driven updates - ingen polling
- Standard IoT protocol - bredt supporteret
- Lightweight og effektiv
- Easy to debug med CLI tools
- Kan tilføje flere subscribers senere

**Ulemper:**
- Kræver MQTT broker (Mosquitto)
- Ekstra komponent at vedligeholde
- Læringskurve for topic design

**Konklusion:** Industry standard for IoT integration, perfekt fit.

## Decision

**Vi implementerer MQTT som integration layer mellem FHEM og Home Assistant.**

**Teknisk setup:**
- Mosquitto MQTT broker på Raspberry Pi (samme som FHEM)
- FHEM publisher temperatur-data og status til topics
- Home Assistant subscriber til heating topics
- HA kan publisher kommandoer som FHEM subscriber til
- Topic struktur: `heating/room/[navn]/[metric]`

**Topic Design:**
```
heating/room/[room]/temperature       # Current temp (FHEM→HA)
heating/room/[room]/setpoint          # Current setpoint (FHEM→HA)
heating/room/[room]/setpoint_cmd      # Set new setpoint (HA→FHEM)
heating/room/[room]/battery           # Battery % (FHEM→HA)
heating/room/[room]/valve             # Valve position (FHEM→HA)
heating/room/[room]/mode              # Current mode (FHEM→HA)
heating/room/[room]/mode_cmd          # Set mode (HA→FHEM)
heating/system/heartbeat              # FHEM alive status
heating/system/status                 # Overall system health
```

## Consequences

### Positive

**Arkitektoniske fordele:**
- **Loose coupling:** FHEM og HA kan udvikles uafhængigt
- **Async messaging:** Ingen blocking eller timeouts
- **Event-driven:** Real-time updates uden polling
- **Scalable:** Let at tilføje flere subscribers
- **Standard:** MQTT er industry standard for IoT

**Operationelle fordele:**
- **Graceful degradation:** Hvis HA går ned, fortsætter FHEM
- **Independent uptime:** Systemer kan genstartes separat
- **Easy debugging:** `mosquitto_sub` til monitoring
- **Topic-based filtering:** Nem routing af messages

**Fremtidssikring:**
- Andre systemer kan subscribe til heating data
- Kan tilføje logging service på topics
- AppDaemon kan bruge samme topics
- Migration til anden heating controller bevarer topics

### Negative

**Kompleksitet:**
- Ekstra komponent (MQTT broker) at administrere
- Topic design kræver forethought
- Message format skal dokumenteres
- Flere points of failure (broker, network)

**Tekniske udfordringer:**
- QoS levels skal konfigureres korrekt
- Retain flag påvirker startup behavior
- Message ordering kan være issue ved high volume
- Debugging er non-trivial ved message flow problemer

**Afhængigheder:**
- MQTT broker skal være stabil (single point of failure)
- Network connectivity mellem RPi og HA
- Message serialization (JSON) skal være konsistent

### Mitigations

**For kompleksitet:**
- Grundig topic dokumentation
- Message examples i docs
- Debugging scripts til monitoring
- Standardized JSON format for alle messages

**For broker stability:**
- Mosquitto på samme RPi som FHEM - minimal network hop
- Systemd service for auto-restart
- Monitoring af broker health via heartbeat
- Future: Overvej broker clustering hvis nødvendigt

**For network issues:**
- MQTT's built-in reconnection logic
- Retained messages for last known state
- Quality of Service levels til kritiske messages

## Implementation Plan

### Phase 1: Basic Setup
1. **Installér Mosquitto** på Raspberry Pi
2. **Test broker** med CLI tools
3. **Configure FHEM** til at publish test messages
4. **Configure HA** til at subscribe og verify reception

### Phase 2: Core Integration
1. **FHEM publishes** temperatur og setpoint for alle termostater
2. **HA displays** data i dashboard
3. **Verify** data updates in real-time

### Phase 3: Bidirectional Control
1. **HA publishes** setpoint commands
2. **FHEM subscribes** og eksekverer commands
3. **FHEM confirms** ny setpoint tilbage til HA
4. **Test** round-trip latency

### Phase 4: Advanced Features
1. **Battery monitoring** via MQTT
2. **System health** heartbeat
3. **Automation integration** i HA
4. **Logging** af all messages for debugging

## Success Criteria

**Technical:**
- Sub-second latency for temperature updates
- Reliable command execution (>99% success rate)
- Broker uptime >99.9%
- Zero message loss for critical data (QoS 1)

**Operational:**
- HA kan display all thermostat data
- HA kan control all thermostats via dashboard
- System continues if either HA or FHEM restarts
- Easy troubleshooting via CLI tools

**User Experience:**
- Thermostat changes reflect in HA within 2 seconds
- Commands from HA execute within 5 seconds
- No noticeable lag in dashboard updates

## Monitoring and Maintenance

### Health Checks
```bash
# Verify broker is running
systemctl status mosquitto

# Monitor all heating messages
mosquitto_sub -h localhost -t "heating/#" -v

# Check message rate
mosquitto_sub -h localhost -t "heating/#" | pv -l > /dev/null
```

### Metrics to Track
- Message publish rate per topic
- Broker uptime
- Connection failures
- Message queue depth
- Round-trip command latency

### Alerting
- HA automation alerts if heartbeat missing >5 min
- Email alert if broker service fails
- Dashboard indicator for MQTT connection status

## Future Considerations

### Potential Extensions

**Additional Subscribers:**
- AppDaemon for advanced automation logic
- Separate logging service for long-term data
- Mobile app direct MQTT access (future)
- External monitoring dashboard

**Enhanced Features:**
- MQTT discovery for auto-configuration
- Encryption with TLS (if security needed)
- Authentication with username/password
- MQTT bridge til cloud for remote access

**Alternative Brokers:**
- Migrate to HiveMQ if Mosquitto insufficient
- Consider EMQX for clustering if high availability needed
- Evaluate cloud MQTT for remote access

## References

- [MQTT Protocol Specification](https://mqtt.org/mqtt-specification/)
- [Mosquitto Documentation](https://mosquitto.org/documentation/)
- [Home Assistant MQTT Integration](https://www.home-assistant.io/integrations/mqtt/)
- [FHEM MQTT2 Module](https://wiki.fhem.de/wiki/MQTT2)
- [MQTT QoS Levels](https://www.hivemq.com/blog/mqtt-essentials-part-6-mqtt-quality-of-service-levels/)

## Related Documents

- ADR-0003: FHEM til EQ3 MAX kontrol
- [heating-concept.md](../guides/heating-concept.md)
- [FHEM-installation-guide.md](../guides/FHEM-installation-guide.md)
- [HA-MQTT-integration-guide.md](../guides/HA-MQTT-integration-guide.md)

---

**Beslutningen afspejler projektets kerneprincipper:**
- MQTT tilbyder **unik værdi** som lightweight async messaging
- Kan **erstatte** direkte API calls med bedre performance
- Bevarer **Home Assistant som centrum** for brugerinterface
- Støtter **separation of concerns** for kritiske systemer
