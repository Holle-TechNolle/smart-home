@echo off
echo =====================================
echo Smart Home Development Setup
echo =====================================
echo.

:: Check if we're in the right directory
if not exist "src" (
    echo ERROR: Dette script skal køres fra smart-home rod-mappen
    echo Nuværende mappe: %cd%
    pause
    exit /b 1
)

echo [1/5] Opret mappestruktur...
if not exist "src\homeassistant" mkdir "src\homeassistant"
if not exist "docs" mkdir "docs"
if not exist "scripts" mkdir "scripts"
echo ✓ Mappestruktur oprettet

echo.
echo [2/5] Opret .gitignore...
if not exist ".gitignore" (
    echo # VSCode
    echo .vscode/
    echo *.code-workspace
    echo.
    echo # SSH FS
    echo .sshfs/
    echo .ssh/
    echo.
    echo # Logs
    echo *.log
    echo.
    echo # Temporary files
    echo *.tmp
    echo *.temp
    echo.
    echo # System files
    echo .DS_Store
    echo Thumbs.db
    echo desktop.ini
) > .gitignore
echo ✓ .gitignore oprettet

echo.
echo [3/5] Opret VSCode workspace fil...
(
    echo {
    echo   "folders": [
    echo     {
    echo       "name": "Smart Home Project",
    echo       "path": "."
    echo     }
    echo   ],
    echo   "settings": {
    echo     "sshfs.configs": [
    echo       {
    echo         "name": "HomeAssistant",
    echo         "host": "192.168.1.15",
    echo         "port": 22,
    echo         "root": "/config",
    echo         "username": "root"
    echo       }
    echo     ]
    echo   },
    echo   "extensions": {
    echo     "recommendations": [
    echo       "kelvin.vscode-sshfs",
    echo       "redhat.vscode-yaml"
    echo     ]
    echo   }
    echo }
) > smart-home.code-workspace
echo ✓ Workspace fil oprettet

echo.
echo [4/5] Tjek Git status...
git status >nul 2>&1
if %errorlevel% neq 0 (
    echo ! Git repository ikke initialiseret
    echo   Kør: git init
) else (
    echo ✓ Git repository fundet
)

echo.
echo [5/5] Setup fuldført!
echo.
echo =====================================
echo NÆSTE TRIN:
echo =====================================
echo 1. Åbn smart-home.code-workspace i VSCode
echo 2. Installer anbefalede extensions hvis spurgt
echo 3. SSH FS: Connect som workspace folder
echo    - Host: 192.168.1.15
echo    - Username: root  
echo    - Root: /config
echo 4. Kopier .yaml filer fra mounted /config til src/homeassistant/
echo.
echo SSH kommando test:
echo ssh root@192.168.1.15
echo.
echo =====================================
pause