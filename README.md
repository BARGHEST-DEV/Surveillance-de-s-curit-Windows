# ARGUS - Outil de surveillance de sécurité Windows

ARGUS est un outil de surveillance de sécurité en temps réel pour Windows, conçu pour détecter les activités anormales et les accès distants non autorisés.

## 🎯 Objectifs

- **Détection en temps réel** des activités suspectes
- **Surveillance réseau** des connexions entrantes/sortantes
- **Monitoring des processus** et services Windows
- **Corrélation d'événements** pour identifier les menaces complexes
- **Alertes multi-canaux** (console, logs, notifications Windows)

## 📋 Prérequis

- Windows 10/11 ou Windows Server
- Python 3.8 ou supérieur
- Privilèges administrateur recommandés (pour accès complet aux événements système)

## 🚀 Installation

1. **Cloner ou télécharger le projet**

```bash
cd "E:\CODING\SECURITY\SCAN SYSTEM"
```

2. **Installer les dépendances**

```bash
pip install -r requirements.txt
```

3. **Vérifier la configuration**

Éditez `core/config.py` pour personnaliser les paramètres de surveillance.

## 💻 Utilisation

### Mode Console

```bash
python core/main.py
```

### Mode Interface Graphique

```bash
# Méthode 1 : Script dédié
lanceur_gui.bat

# Méthode 2 : Ligne de commande
python run_argus_gui.py

# Méthode 3 : Option --gui
python core/main.py --gui
```

### Options de ligne de commande

```bash
# Changer le niveau de log
python core/main.py --log-level DEBUG

# Désactiver les notifications Windows
python core/main.py --no-notifications

# Lancer l'interface graphique
python core/main.py --gui
```

## 📁 Structure du projet

```
ARGUS/
├── core/
│   ├── main.py                 # Point d'entrée
│   ├── config.py               # Configuration globale
│   ├── logger.py               # Système de logs
│   ├── engine/
│   │   ├── scheduler.py        # Orchestrateur principal
│   │   ├── correlation.py     # Moteur de corrélation
│   │   └── alerts.py           # Gestionnaire d'alertes
│   ├── monitors/
│   │   ├── process_monitor.py  # Surveillance processus
│   │   ├── network_monitor.py  # Surveillance réseau
│   │   ├── session_monitor.py  # Surveillance sessions
│   │   └── service_monitor.py  # Surveillance services
│   └── utils/
│       ├── hashing.py          # Calcul de hashs
│       └── system.py           # Utilitaires Windows
├── data/
│   ├── whitelist.json          # Processus/IP autorisés
│   ├── blacklist.json          # Éléments suspects connus
│   └── history.db              # Base de données SQLite
├── logs/                        # Fichiers de logs
└── requirements.txt             # Dépendances Python
```

## 🔍 Modules de surveillance

### Process Monitor
- Détecte les nouveaux processus
- Analyse les chemins d'exécution suspects
- Vérifie les signatures numériques
- Calcule les hashs SHA256

### Network Monitor
- Surveille toutes les connexions TCP/UDP
- Détecte les connexions entrantes non autorisées
- Identifie les ports d'écoute suspects
- Analyse les connexions sortantes

### Session Monitor
- Surveille les événements de logon
- Détecte les connexions distantes (RDP, Terminal Services)
- Identifie les tentatives d'authentification suspectes
- Analyse les changements de privilèges

### Service Monitor
- Détecte la création de nouveaux services
- Surveille les modifications de services existants
- Analyse les chemins d'exécution des services

## 🧠 Moteur de corrélation

Le moteur de corrélation analyse les événements liés pour identifier des menaces complexes :

- **Processus suspect + Connexion réseau** → Alerte moyenne/haute
- **Processus suspect + Port ouvert** → Alerte haute
- **Logon distant + Service créé** → Alerte critique
- **Processus suspect + Connexion sortante** → Alerte haute
- **Multiples processus suspects** → Alerte haute

## 📊 Système d'alertes

Les alertes sont générées avec :
- **Score de risque** (0-100)
- **Niveau de sévérité** (INFO, LOW, MEDIUM, HIGH, CRITICAL)
- **Description détaillée**
- **Métadonnées** (PID, IP, ports, etc.)

### Canaux d'alerte

1. **Console** : Affichage en temps réel avec codes couleur
2. **Logs** : Fichiers horodatés dans `logs/`
3. **Base de données** : Stockage SQLite dans `data/history.db`
4. **Notifications Windows** : Pour les alertes HIGH/CRITICAL
5. **Export JSON/CSV** : Dans `data/exports/`

## ⚙️ Configuration

### Fichier `core/config.py`

Principaux paramètres :

```python
# Intervalles de scan (secondes)
PROCESS_SCAN_INTERVAL = 2
NETWORK_SCAN_INTERVAL = 3
SESSION_SCAN_INTERVAL = 5
SERVICE_SCAN_INTERVAL = 10

# Seuils d'alerte
RISK_SCORE_LOW = 20
RISK_SCORE_MEDIUM = 50
RISK_SCORE_HIGH = 80
RISK_SCORE_CRITICAL = 100

# Ports autorisés
ALLOWED_PORTS = [80, 443, 53, 123]

# Processus suspects
SUSPICIOUS_PROCESSES = ["powershell.exe", "cmd.exe", ...]
```

### Whitelist / Blacklist

Éditez les fichiers JSON dans `data/` :

- **whitelist.json** : Processus, IPs, ports autorisés
- **blacklist.json** : Processus, IPs, hashs suspects connus

## 🗄️ Base de données

La base SQLite stocke :
- **Table `alerts`** : Toutes les alertes générées
- **Table `events`** : Événements bruts (à implémenter)
- **Table `processes_seen`** : Historique des processus (à implémenter)
- **Table `connections_seen`** : Historique des connexions (à implémenter)

## 🔒 Sécurité

- **Signature des fichiers** : Vérification des signatures numériques
- **Hachage SHA256** : Calcul des hashs pour identification
- **Droits minimum** : Fonctionne avec privilèges utilisateur (limité)
- **Logs protégés** : Rotation automatique des logs

## 📝 Logs

Les logs sont stockés dans `logs/` avec :
- Format horodaté : `argus_YYYYMMDD_HHMMSS.log`
- Rotation automatique (10 MB max, 5 backups)
- Niveaux : DEBUG, INFO, WARNING, ERROR, CRITICAL

## 🐛 Dépannage

### Erreur "Access Denied"
- Exécutez avec des privilèges administrateur
- Certaines fonctionnalités nécessitent des droits élevés

### Erreur "Module not found"
- Vérifiez l'installation : `pip install -r requirements.txt`
- Vérifiez que vous êtes dans le bon répertoire

### Pas d'alertes générées
- Vérifiez les seuils dans `config.py`
- Consultez les logs pour les erreurs
- Vérifiez que les monitors fonctionnent (logs DEBUG)

## 🚧 Limitations

- **Userland uniquement** : Pas de driver kernel
- **Windows uniquement** : Nécessite Windows
- **Performance** : Peut impacter les performances sur systèmes chargés
- **Faux positifs** : Peut générer des alertes pour des activités légitimes

## 📈 Améliorations futures

- Interface graphique (GUI)
- Dashboard web
- Intégration avec SIEM
- Détection de malware avancée
- Machine learning pour réduire les faux positifs
- Support multi-systèmes

## 📄 Licence

Ce projet est fourni à des fins éducatives et de sécurité défensive.

## ⚠️ Avertissement

Cet outil est conçu pour la surveillance défensive uniquement. Utilisez-le de manière responsable et conformément aux lois et réglementations applicables.

## 👥 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir des issues ou des pull requests.

---

**ARGUS** - Gardien vigilant de votre système Windows

