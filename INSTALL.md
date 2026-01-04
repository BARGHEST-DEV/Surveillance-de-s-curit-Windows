# Guide d'installation ARGUS

## Installation rapide

### 1. Prérequis

- Windows 10/11 ou Windows Server
- Python 3.8 ou supérieur
- Privilèges administrateur (recommandé)

### 2. Installation des dépendances

```bash
pip install -r requirements.txt
```

**Note importante** : Sur Windows, vous devrez peut-être installer `pywin32` séparément :

```bash
pip install pywin32
```

Après l'installation de pywin32, exécutez :

```bash
python Scripts/pywin32_postinstall.py -install
```

### 3. Vérification de l'installation

Testez que tous les modules sont disponibles :

```bash
python -c "import psutil; import win32service; print('OK')"
```

### 4. Configuration initiale

1. **Whitelist** : Éditez `data/whitelist.json` pour ajouter vos processus/IP autorisés
2. **Blacklist** : Éditez `data/blacklist.json` pour ajouter des éléments suspects connus
3. **Configuration** : Optionnellement, copiez `config.example.py` et personnalisez

### 5. Lancement

**Méthode 1 - Script de démarrage** :
```bash
python run_argus.py
```

**Méthode 2 - Module principal** :
```bash
python core/main.py
```

**Méthode 3 - Avec options** :
```bash
python core/main.py --log-level DEBUG --no-notifications
```

## Dépannage

### Erreur "No module named 'win32service'"

Solution :
```bash
pip install pywin32
python Scripts/pywin32_postinstall.py -install
```

### Erreur "Access Denied"

- Exécutez avec des privilèges administrateur
- Clic droit → "Exécuter en tant qu'administrateur"

### Erreur "psutil not found"

Solution :
```bash
pip install psutil
```

### Pas d'alertes générées

1. Vérifiez les seuils dans `core/config.py`
2. Consultez les logs dans `logs/`
3. Lancez avec `--log-level DEBUG` pour plus de détails

## Structure des fichiers générés

Après le premier lancement, vous trouverez :

- `data/history.db` : Base de données SQLite avec l'historique
- `logs/argus_*.log` : Fichiers de logs horodatés
- `data/exports/` : Exports JSON/CSV des alertes

## Utilisation en production

Pour une utilisation en production :

1. **Service Windows** : Configurez ARGUS comme service Windows
2. **Surveillance continue** : Utilisez un gestionnaire de processus (NSSM, etc.)
3. **Rotation des logs** : Configurée automatiquement
4. **Base de données** : Nettoyage automatique après 30 jours (configurable)

## Support

Consultez le `README.md` pour plus d'informations sur l'utilisation et la configuration.


