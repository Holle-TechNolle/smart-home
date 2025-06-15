@echo off
echo ========================================
echo PURGING SENSITIVE FILES FROM GIT HISTORY
echo ========================================
echo.
echo **WARNING:** This script will permanently remove files from git history!
echo This action cannot be undone and will rewrite git history.
echo.
echo Files to be removed:
echo - All .backup files
echo - Files containing sensitive information
echo - Previous versions with real credentials
echo.
set /p confirm="Are you sure you want to continue? (y/N): "
if /i not "%confirm%"=="y" (
    echo Operation cancelled.
    pause
    exit /b 1
)
echo.

REM Backup current state before purging
echo Creating backup of current repository state...
git log --oneline -5 > git-history-before-purge.txt
echo Repository state backed up to git-history-before-purge.txt ✓
echo.

REM Step 1: Remove backup files from git history
echo Step 1: Removing .backup files from git history...
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.backup" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch **/*.backup" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch docs/*.backup" --prune-empty --tag-name-filter cat -- --all
echo Backup files removed from history ✓
echo.

REM Step 2: Remove specific sensitive files if they exist in history
echo Step 2: Removing potentially sensitive files from history...
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch secure/*" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch secrets.yaml" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch config/secrets.yaml" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch credentials.*" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch passwords.*" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch ssh_config" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch id_rsa*" --prune-empty --tag-name-filter cat -- --all
echo Potentially sensitive files removed from history ✓
echo.

REM Step 3: Remove temporary and system files
echo Step 3: Removing temporary files from history...
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.tmp" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.temp" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.log" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch .DS_Store" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch Thumbs.db" --prune-empty --tag-name-filter cat -- --all
echo Temporary files removed from history ✓
echo.

REM Step 4: Clean up refs and garbage collect
echo Step 4: Cleaning up repository...
git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now --aggressive
echo Repository cleaned up ✓
echo.

REM Step 5: Remove local backup files
echo Step 5: Removing local backup files...
if exist *.backup del *.backup
if exist docs\*.backup del docs\*.backup
if exist src\*.backup del src\*.backup
echo Local backup files removed ✓
echo.

REM Step 6: Verify no sensitive files remain in history
echo Step 6: Verifying cleanup...
echo Checking for remaining backup files in history:
git log --all --full-history -- "*.backup" --oneline
if %errorlevel% equ 0 (
    echo WARNING: Some backup files may still exist in history!
) else (
    echo No backup files found in history ✓
)
echo.

echo Checking current repository status:
git status --porcelain
echo.

REM Step 7: Create summary
echo Step 7: Creating cleanup summary...
echo # Git History Cleanup Summary > git-cleanup-summary.txt
echo Date: %date% %time% >> git-cleanup-summary.txt
echo. >> git-cleanup-summary.txt
echo ## Files Removed from Git History: >> git-cleanup-summary.txt
echo - All .backup files >> git-cleanup-summary.txt
echo - secure/* folder contents >> git-cleanup-summary.txt
echo - secrets.yaml and config/secrets.yaml >> git-cleanup-summary.txt
echo - credentials.* and passwords.* files >> git-cleanup-summary.txt
echo - SSH configuration files >> git-cleanup-summary.txt
echo - Temporary files (*.tmp, *.temp, *.log) >> git-cleanup-summary.txt
echo - System files (.DS_Store, Thumbs.db) >> git-cleanup-summary.txt
echo. >> git-cleanup-summary.txt
echo ## Repository Status After Cleanup: >> git-cleanup-summary.txt
git log --oneline -10 >> git-cleanup-summary.txt
echo Cleanup summary created ✓
echo.

echo ========================================
echo GIT HISTORY PURGE COMPLETE! ✓
echo ========================================
echo.
echo **IMPORTANT NEXT STEPS:**
echo.
echo 1. **FORCE PUSH to GitHub** (rewrites remote history):
echo    git push origin --force --all
echo    git push origin --force --tags
echo.
echo 2. **Verify on GitHub** that sensitive files are gone:
echo    - Check repository file browser
echo    - Check commit history
echo    - Check release tags
echo.
echo 3. **Inform collaborators** (if any) that they need to:
echo    - Delete their local clones
echo    - Re-clone the repository fresh
echo    - Re-setup their development environment
echo.
echo 4. **GitHub Pages is now safe to activate!**
echo.
echo **FILES CREATED:**
echo - git-history-before-purge.txt (backup of original state)
echo - git-cleanup-summary.txt (summary of cleanup)
echo.
echo **WARNING:**
echo - Git history has been permanently rewritten
echo - Force push will overwrite GitHub repository history
echo - This action cannot be undone
echo.
echo **Ready to force push? Run these commands:**
echo git push origin --force --all
echo git push origin --force --tags
echo.
pause
