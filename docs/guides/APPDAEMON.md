# AppDaemon - Installation og Konfiguration

## Hvad er AppDaemon?

Python-baseret automation framework til Home Assistant. Bruges til avanceret logik som HA's YAML-automationer ikke kan håndtere elegant.

## Installation

### Via Home Assistant Add-on Store

1. Settings → Add-ons → Add-on Store
2. Søg "AppDaemon"
3. Install
4. Configuration → Start on boot: ON
5. Start add-on

## Konfiguration

### 1. Opret Home Assistant API Token

1. Profile (nederst i sidebar) → Long-Lived Access Tokens
2. Create Token
3. Navn: "AppDaemon"
4. Copy token værdien (vises kun én gang!)

### 2. Tilføj token til secrets

Rediger `/config/secrets.yaml`:
```yaml
appdaemon_token: "dit_kopierede_token_her"
```

### 3. Konfigurer AppDaemon

Opret `/config/appdaemon/appdaemon.yaml`:

```yaml
appdaemon:
  latitude: 55.5463
  longitude: 11.7163
  elevation: 52
  time_zone: Europe/Copenhagen
  plugins:
    HASS:
      type: hass
      ha_url: http://homeassistant.local:8123
      token: !secret appdaemon_token

logs:
  main_log:
    filename: /config/appdaemon/logs/appdaemon.log
  error_log:
    filename: /config/appdaemon/logs/error.log
```

**Note:** Juster latitude/longitude/elevation til dine værdier.

### 4. Opret apps mappe struktur

```
/config/appdaemon/
├── appdaemon.yaml    # Hovedkonfiguration
├── apps/
│   └── apps.yaml     # App registrering (tomt til at starte)
└── logs/             # Logs (oprettes automatisk)
```

Opret `/config/appdaemon/apps/apps.yaml` (kan være tom fil):
```yaml
# AppDaemon apps registreres her
```

### 5. Genstart AppDaemon

Settings → Add-ons → AppDaemon → Restart

## Verificer Installation

### Check Logs

Via SSH/Terminal add-on:
```bash
tail -f /config/appdaemon/logs/appdaemon.log
```

Eller via AppDaemon add-on interface: Log tab

### Forventet Output

```
INFO AppDaemon: AppDaemon Version X.X.X starting
INFO AppDaemon: Connected to Home Assistant
```

## Mappestruktur

```
/config/appdaemon/
├── appdaemon.yaml       # Hovedkonfiguration
├── apps/
│   ├── apps.yaml        # App registrering
│   └── [dine_apps].py   # Python apps (tilføjes senere)
└── logs/
    ├── appdaemon.log    # Hoved log
    └── error.log        # Fejl log
```

## Troubleshooting

### AppDaemon starter ikke

1. Check logs i add-on interface
2. Verificer `appdaemon_token` i secrets.yaml
3. Test Home Assistant URL: `http://homeassistant.local:8123`

### Connection fejl til Home Assistant

- Verificer at token er korrekt kopieret
- Check at HA kører: `http://homeassistant.local:8123`
- Prøv IP i stedet: `http://192.168.1.15:8123`

### Apps loader ikke

- Check at `apps/apps.yaml` eksisterer
- Verificer YAML syntax i `apps.yaml`
- Se logs: `/config/appdaemon/logs/appdaemon.log`

## Næste Skridt

Installation og basis konfiguration er nu færdig. AppDaemon er klar til at køre Python apps.

For app udvikling, se Home Assistant Community eller AppDaemon dokumentation.

## Resources

- AppDaemon Docs: https://appdaemon.readthedocs.io
- Home Assistant Community: https://community.home-assistant.io/c/third-party/appdaemon

---

*Version: 1.0*  
*Sidst opdateret: Oktober 2025*
