@echo off
REM ============================================
REM ARGUS - Lanceur principal
REM ============================================
title ARGUS - Surveillance de securite Windows

REM Vérifier si Python est installé
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Python n'est pas installe ou n'est pas dans le PATH
    echo Veuillez installer Python 3.8 ou superieur depuis https://www.python.org/
    pause
    exit /b 1
)

REM Vérifier si les dépendances sont installées
python -c "import psutil" >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Les dependances ne sont pas installees
    echo Veuillez executer install.bat d'abord
    pause
    exit /b 1
)

REM Afficher le menu
:MENU
cls
echo.
echo ============================================
echo ARGUS - Surveillance de securite Windows
echo ============================================
echo.
echo 1. Demarrer ARGUS (mode normal)
echo 2. Demarrer ARGUS (mode DEBUG)
echo 3. Demarrer ARGUS (sans notifications Windows)
echo 4. Demarrer ARGUS (mode DEBUG, sans notifications)
echo 5. Demarrer ARGUS (Interface Graphique)
echo 6. Verifier l'installation
echo 7. Quitter
echo.
set /p choice="Votre choix (1-7): "

if "%choice%"=="1" goto START_NORMAL
if "%choice%"=="2" goto START_DEBUG
if "%choice%"=="3" goto START_NO_NOTIF
if "%choice%"=="4" goto START_DEBUG_NO_NOTIF
if "%choice%"=="5" goto START_GUI
if "%choice%"=="6" goto CHECK_INSTALL
if "%choice%"=="7" goto END
goto MENU

:START_NORMAL
cls
echo.
echo ============================================
echo Demarrage d'ARGUS en mode normal...
echo ============================================
echo Appuyez sur Ctrl+C pour arreter
echo.
python run_argus.py
goto END

:START_DEBUG
cls
echo.
echo ============================================
echo Demarrage d'ARGUS en mode DEBUG...
echo ============================================
echo Appuyez sur Ctrl+C pour arreter
echo.
python core/main.py --log-level DEBUG
goto END

:START_NO_NOTIF
cls
echo.
echo ============================================
echo Demarrage d'ARGUS (sans notifications)...
echo ============================================
echo Appuyez sur Ctrl+C pour arreter
echo.
python core/main.py --no-notifications
goto END

:START_DEBUG_NO_NOTIF
cls
echo.
echo ============================================
echo Demarrage d'ARGUS (DEBUG, sans notifications)...
echo ============================================
echo Appuyez sur Ctrl+C pour arreter
echo.
python core/main.py --log-level DEBUG --no-notifications
goto END

:START_GUI
cls
echo.
echo ============================================
echo Demarrage d'ARGUS en mode Interface Graphique...
echo ============================================
echo.
python run_argus_gui.py
goto END

:CHECK_INSTALL
cls
echo.
echo ============================================
echo Verification de l'installation...
echo ============================================
echo.

REM Vérifier Python
python --version
if errorlevel 1 (
    echo [ERREUR] Python non detecte
) else (
    echo [OK] Python installe
)
echo.

REM Vérifier les dépendances
echo Verification des dependances:
python -c "import psutil; print('[OK] psutil')" 2>nul || echo [ERREUR] psutil manquant
python -c "import win32service; print('[OK] pywin32')" 2>nul || echo [ATTENTION] pywin32 manquant
python -c "import win10toast; print('[OK] win10toast')" 2>nul || echo [ATTENTION] win10toast manquant
echo.

REM Vérifier les fichiers
echo Verification des fichiers:
if exist "core\main.py" (echo [OK] core\main.py) else (echo [ERREUR] core\main.py manquant)
if exist "run_argus.py" (echo [OK] run_argus.py) else (echo [ERREUR] run_argus.py manquant)
if exist "requirements.txt" (echo [OK] requirements.txt) else (echo [ERREUR] requirements.txt manquant)
if exist "data\whitelist.json" (echo [OK] data\whitelist.json) else (echo [ATTENTION] data\whitelist.json manquant)
if exist "data\blacklist.json" (echo [OK] data\blacklist.json) else (echo [ATTENTION] data\blacklist.json manquant)
echo.

REM Vérifier les répertoires
echo Verification des repertoires:
if exist "data" (echo [OK] data\) else (echo [ATTENTION] Repertoire data\ manquant)
if exist "logs" (echo [OK] logs\) else (echo [ATTENTION] Repertoire logs\ manquant)
echo.

echo ============================================
pause
goto MENU

:END
echo.
echo ARGUS ferme.
timeout /t 2 >nul
exit

