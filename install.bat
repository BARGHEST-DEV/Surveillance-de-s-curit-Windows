@echo off
REM ============================================
REM ARGUS - Script d'installation des dépendances
REM ============================================
echo.
echo ============================================
echo ARGUS - Installation des dependances
echo ============================================
echo.

REM Vérifier si Python est installé
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Python n'est pas installe ou n'est pas dans le PATH
    echo Veuillez installer Python 3.8 ou superieur depuis https://www.python.org/
    pause
    exit /b 1
)

echo [OK] Python detecte
python --version

REM Vérifier la version de Python (minimum 3.8)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Version Python: %PYTHON_VERSION%
echo.

REM Mettre à jour pip
echo [1/4] Mise a jour de pip...
python -m pip install --upgrade pip
if errorlevel 1 (
    echo [ATTENTION] Erreur lors de la mise a jour de pip, continuation...
)
echo.

REM Installer les dépendances depuis requirements.txt
echo [2/4] Installation des dependances depuis requirements.txt...
if not exist requirements.txt (
    echo [ERREUR] Fichier requirements.txt introuvable
    pause
    exit /b 1
)

python -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERREUR] Erreur lors de l'installation des dependances
    pause
    exit /b 1
)
echo.

REM Installation spéciale pour pywin32
echo [3/4] Installation et configuration de pywin32...
python -m pip install pywin32
if errorlevel 1 (
    echo [ATTENTION] Erreur lors de l'installation de pywin32
    echo Certaines fonctionnalites peuvent etre limitees
) else (
    REM Exécuter le post-install de pywin32
    echo Configuration de pywin32...
    REM Trouver le script pywin32_postinstall.py
    for /f "delims=" %%i in ('python -c "import site; import os; print(os.path.join(site.getsitepackages()[0] if site.getsitepackages() else '', 'pywin32_system32'))" 2^>nul') do set PYWIN32_PATH=%%i
    
    REM Essayer plusieurs chemins possibles pour pywin32_postinstall.py
    python -m pywin32_postinstall -install 2>nul
    if errorlevel 1 (
        REM Essayer avec le chemin direct
        where /r "%LOCALAPPDATA%\Programs\Python" pywin32_postinstall.py >nul 2>&1
        if not errorlevel 1 (
            for /f "delims=" %%f in ('where /r "%LOCALAPPDATA%\Programs\Python" pywin32_postinstall.py') do (
                python "%%f" -install 2>nul
            )
        )
    )
    echo [OK] pywin32 configure (si disponible)
)
echo.

REM Vérification de l'installation
echo [4/4] Verification de l'installation...
python -c "import psutil; print('[OK] psutil installe')" 2>nul || echo [ERREUR] psutil non installe
python -c "import win32service; print('[OK] pywin32 installe')" 2>nul || echo [ATTENTION] pywin32 non installe - certaines fonctionnalites seront limitees
python -c "import win10toast; print('[OK] win10toast installe')" 2>nul || echo [ATTENTION] win10toast non installe - les notifications Windows seront desactivees
echo.

REM Créer les répertoires nécessaires
echo Creation des repertoires necessaires...
if not exist "data" mkdir data
if not exist "logs" mkdir logs
if not exist "data\exports" mkdir "data\exports"
echo [OK] Repertoires crees
echo.

echo ============================================
echo Installation terminee avec succes!
echo ============================================
echo.
echo Vous pouvez maintenant lancer ARGUS avec lanceur.bat
echo.
pause

