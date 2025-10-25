# PowerShell script til at fjerne irrelevante VS Code extensions
# Kør i VS Code Terminal: .\remove_vscode_extensions.ps1

Write-Host "Fjerner irrelevante VS Code extensions..." -ForegroundColor Cyan
Write-Host ""

# .NET/C# extensions
code --uninstall-extension ms-dotnettools.csdevkit
code --uninstall-extension ms-dotnettools.csharp
code --uninstall-extension ms-dotnettools.dotnet-maui
code --uninstall-extension ms-dotnettools.vscode-dotnet-runtime
code --uninstall-extension ms-dotnettools.vscodeintellicode-csharp
code --uninstall-extension leo-labs.dotnet
code --uninstall-extension fernandoescolar.vscode-solution-explorer
code --uninstall-extension jesschadwick.nuget-reverse-package-search

# Docker/Container extensions
code --uninstall-extension ms-azuretools.vscode-containers
code --uninstall-extension ms-azuretools.vscode-docker
code --uninstall-extension ms-vscode-remote.remote-containers

# Office/OOXML extensions
code --uninstall-extension cweijan.vscode-office
code --uninstall-extension sergey-tihon.openxml-explorer
code --uninstall-extension yuenm18.ooxml-viewer

# GraphViz extensions
code --uninstall-extension efanzh.graphviz-preview
code --uninstall-extension qiu.graphviz-language-support-and-preivew

# Remote/WSL extensions (beholder kun SSH)
code --uninstall-extension ms-vscode-remote.remote-wsl
code --uninstall-extension github.remotehub
code --uninstall-extension ms-vscode.remote-repositories
code --uninstall-extension ms-vscode.remote-server
code --uninstall-extension kelvin.vscode-sshfs

# Auto-tag extensions (kan være irriterende)
code --uninstall-extension formulahendry.auto-close-tag
code --uninstall-extension formulahendry.auto-rename-tag

# Prettier (brug YAML formatter i stedet)
code --uninstall-extension esbenp.prettier-vscode

# C++ tools (ikke relevant)
code --uninstall-extension ms-vscode.cpptools

# PowerShell (ikke nødvendig for Smart Home)
code --uninstall-extension ms-vscode.powershell

# Markdown preview enhanced (du har allerede markdown-all-in-one)
code --uninstall-extension shd101wyy.markdown-preview-enhanced

# Remote Explorer (inkluderet i remote-ssh-extensionpack)
code --uninstall-extension ms-vscode.remote-explorer

# Python envs (pylance håndterer dette)
code --uninstall-extension ms-python.vscode-python-envs

Write-Host ""
Write-Host "Færdig! Extensions er fjernet." -ForegroundColor Green
Write-Host ""
Write-Host "Kør 'code --list-extensions' for at se din rensede liste." -ForegroundColor Yellow
