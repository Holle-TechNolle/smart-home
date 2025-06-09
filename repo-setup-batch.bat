@echo off
echo Creating Smart Home repository structure...
echo.

REM Create main directories
mkdir docs
mkdir docs\decisions
mkdir docs\diagrams
mkdir src
mkdir src\homeassistant
mkdir src\homeassistant\automations
mkdir src\homeassistant\scripts
mkdir src\homeassistant\integrations
mkdir src\appdaemon
mkdir src\appdaemon\apps
mkdir src\appdaemon\config
mkdir tests
mkdir tests\validation
mkdir tests\integration
mkdir tools
mkdir tools\maintenance
mkdir .github
mkdir .github\ISSUE_TEMPLATE
mkdir .github\workflows

echo Created directory structure ✓
echo.

REM Create basic files
echo # Smart Home Project > README.md
echo. >> README.md
echo Dette er mit Smart Home projekt baseret på Home Assistant som centrum. >> README.md
echo. >> README.md
echo ## Arkitektoniske Principper >> README.md
echo - Home Assistant som centrum >> README.md
echo - Minimer overlap, maksimer værdi >> README.md

echo # Arkitektoniske Principper for Smart Home Projektet > docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ## Grundlæggende Principper >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ### 1. Home Assistant som Centrum >> docs\ARCHITECTURE.md
echo **"Home Assistant er centrum - integrer én gang, brug alle steder."** >> docs\ARCHITECTURE.md
echo. >> docs\ARCHITECTURE.md
echo ### 2. Minimer Overlap, Maksimer Værdi >> docs\ARCHITECTURE.md
echo **"Implementér kun nyt når det tilbyder unik funktionalitet og erstatter eksisterende komponenter."** >> docs\ARCHITECTURE.md

echo # Environment Setup > docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Hardware >> docs\ENVIRONMENT.md
echo - Intel NUC med Home Assistant OS >> docs\ENVIRONMENT.md
echo - Raspberry Pi 3 >> docs\ENVIRONMENT.md
echo. >> docs\ENVIRONMENT.md
echo ## Network >> docs\ENVIRONMENT.md
echo - Home Assistant URL: http://homeassistant.local:8123 >> docs\ENVIRONMENT.md
echo - Observer URL: http://homeassistant.local:4357 >> docs\ENVIRONMENT.md

REM Create .gitignore
echo # Home Assistant > .gitignore
echo secrets.yaml >> .gitignore
echo known_devices.yaml >> .gitignore
echo home-assistant.log >> .gitignore
echo home-assistant_v2.db >> .gitignore
echo .uuid >> .gitignore
echo .HA_VERSION >> .gitignore
echo. >> .gitignore
echo # Python >> .gitignore
echo __pycache__/ >> .gitignore
echo *.py[cod] >> .gitignore
echo *$py.class >> .gitignore
echo. >> .gitignore
echo # AppDaemon >> .gitignore
echo appdaemon.log >> .gitignore
echo. >> .gitignore
echo # VS Code >> .gitignore
echo .vscode/settings.json >> .gitignore
echo. >> .gitignore
echo # Credentials (before git-crypt setup) >> .gitignore
echo docs/CREDENTIALS.md >> .gitignore

REM Create basic issue template
echo ---name: Task > .github\ISSUE_TEMPLATE\task.md
echo about: Standard task for project development >> .github\ISSUE_TEMPLATE\task.md
echo title: "[TASK] " >> .github\ISSUE_TEMPLATE\task.md
echo labels: task >> .github\ISSUE_TEMPLATE\task.md
echo assignees: '' >> .github\ISSUE_TEMPLATE\task.md
echo --- >> .github\ISSUE_TEMPLATE\task.md
echo. >> .github\ISSUE_TEMPLATE\task.md
echo ## Beskrivelse >> .github\ISSUE_TEMPLATE\task.md
echo Beskriv hvad der skal implementeres >> .github\ISSUE_TEMPLATE\task.md
echo. >> .github\ISSUE_TEMPLATE\task.md
echo ## Acceptkriterier >> .github\ISSUE_TEMPLATE\task.md
echo - [ ] Kriterie 1 >> .github\ISSUE_TEMPLATE\task.md
echo - [ ] Kriterie 2 >> .github\ISSUE_TEMPLATE\task.md

REM Create first ADR
echo # ADR-0001: GitHub som Central Platform > docs\decisions\0001-github-platform.md
echo. >> docs\decisions\0001-github-platform.md
echo **Status:** Accepteret >> docs\decisions\0001-github-platform.md
echo **Dato:** %DATE% >> docs\decisions\0001-github-platform.md
echo. >> docs\decisions\0001-github-platform.md
echo ## Context >> docs\decisions\0001-github-platform.md
echo Vi havde behov for en central platform til kode, dokumentation og projektstyring. >> docs\decisions\0001-github-platform.md
echo. >> docs\decisions\0001-github-platform.md
echo ## Decision >> docs\decisions\0001-github-platform.md
echo Vi bruger GitHub som den centrale platform for Smart Home projektet. >> docs\decisions\0001-github-platform.md
echo. >> docs\decisions\0001-github-platform.md
echo ## Consequences >> docs\decisions\0001-github-platform.md
echo - Konsolidering af alle projektaktiviteter på én platform >> docs\decisions\0001-github-platform.md
echo - Eliminering af behov for separate systemer som Jira >> docs\decisions\0001-github-platform.md

echo.
echo Created basic files ✓
echo - README.md
echo - docs/ARCHITECTURE.md  
echo - docs/ENVIRONMENT.md
echo - .gitignore
echo - .github/ISSUE_TEMPLATE/task.md
echo - docs/decisions/0001-github-platform.md
echo.

echo Repository structure setup complete!
echo.
echo Next steps:
echo 1. Review created files and folders
echo 2. Initialize git: git init
echo 3. Add files: git add .
echo 4. Commit: git commit -m "Initial repository structure"
echo 5. Add remote: git remote add origin [your-repo-url]
echo 6. Push: git push -u origin main
echo.
pause