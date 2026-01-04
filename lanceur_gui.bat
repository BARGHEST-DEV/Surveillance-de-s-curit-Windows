@echo off
REM ============================================
REM ARGUS - Lanceur Interface Graphique
REM ============================================
title ARGUS - Interface Graphique

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

echo.
echo ============================================
echo Demarrage d'ARGUS en mode Interface Graphique...
echo ============================================
echo.

python run_argus_gui.py

if errorlevel 1 (
    echo.
    echo [ERREUR] Erreur lors du lancement de l'interface graphique
    pause
)


