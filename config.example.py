"""
Exemple de fichier de configuration personnalisé pour ARGUS
Copiez ce fichier et modifiez les valeurs selon vos besoins
"""
from core.config import Config

# Personnalisation des intervalles de scan
Config.PROCESS_SCAN_INTERVAL = 2      # Secondes entre chaque scan de processus
Config.NETWORK_SCAN_INTERVAL = 3      # Secondes entre chaque scan réseau
Config.SESSION_SCAN_INTERVAL = 5      # Secondes entre chaque scan de sessions
Config.SERVICE_SCAN_INTERVAL = 10     # Secondes entre chaque scan de services

# Personnalisation des seuils d'alerte
Config.RISK_SCORE_LOW = 20
Config.RISK_SCORE_MEDIUM = 50
Config.RISK_SCORE_HIGH = 80
Config.RISK_SCORE_CRITICAL = 100

# Ajouter des ports autorisés
Config.ALLOWED_PORTS.extend([
    3389,  # RDP
    22,    # SSH (si utilisé)
])

# Ajouter des IPs de confiance
Config.TRUSTED_IPS.extend([
    "192.168.1.1",      # Routeur local
    "10.0.0.1",         # Autre réseau de confiance
])

# Personnalisation des chemins suspects
Config.SUSPICIOUS_PATHS.extend([
    r"C:\Users\Public",
    r"C:\Windows\Tasks",
])

# Configuration des logs
Config.LOG_LEVEL = "INFO"  # DEBUG, INFO, WARNING, ERROR, CRITICAL
Config.LOG_TO_CONSOLE = True
Config.LOG_TO_FILE = True

# Configuration des alertes
Config.ENABLE_WINDOWS_NOTIFICATIONS = True
Config.ENABLE_CONSOLE_ALERTS = True
Config.EXPORT_JSON = True
Config.EXPORT_CSV = False


