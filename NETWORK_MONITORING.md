# Surveillance des Connexions Réseau - ARGUS

## 🎯 Fonctionnalités

L'interface graphique d'ARGUS inclut maintenant une vue dédiée aux connexions réseau avec détection automatique des connexions suspectes vers des institutions (police, gendarmerie, etc.).

## 📋 Onglet "Connexions"

### Colonnes affichées

- **PID** : Identifiant du processus
- **Local (IP:Port)** : Adresse et port locaux
- **Distant (IP:Port)** : Adresse et port distants
- **Statut** : État de la connexion (ESTABLISHED, LISTENING, etc.)
- **Direction** : INBOUND, OUTBOUND, LOCAL
- **Processus** : Nom du processus associé
- **Institution** : Institution détectée (si applicable)
- **Suspect** : Indicateur de suspicion

### Codes couleur

- **🔴 Rouge** : Connexions vers des institutions suspectes (police, gendarmerie, etc.)
- **🟠 Orange clair** : Connexions suspectes (IPs dans la liste noire)
- **⚪ Blanc** : Connexions normales

### Filtres disponibles

- **Toutes** : Affiche toutes les connexions
- **Suspectes** : Affiche uniquement les connexions suspectes
- **Sortantes** : Affiche uniquement les connexions sortantes
- **Entrantes** : Affiche uniquement les connexions entrantes

### Actions disponibles

1. **Double-clic** ou **Clic droit → Détails** : Ouvre une fenêtre avec les détails complets
2. **Clic droit → Ajouter IP à la liste noire** : Ajoute l'IP distante à la liste noire

## 🔍 Fenêtre de détails d'une connexion

### Onglet "Informations"

- Adresses IP et ports (local et distant)
- Statut et direction de la connexion
- Informations sur le processus associé (nom, chemin, utilisateur)

### Onglet "Analyse IP"

- Résultat de l'analyse de l'IP distante
- Détection d'institution (police, gendarmerie, etc.)
- Score de confiance
- Indicateurs de suspicion
- Informations techniques (IP privée/publique, hostname)

### Actions

- **Fermer la connexion** : Ferme la connexion (nécessite des privilèges élevés)
- **Ajouter IP à la liste noire** : Ajoute l'IP à la liste permanente
- **Actualiser** : Met à jour les informations

## ⚙️ Configuration des institutions suspectes

### Fichier de configuration

Éditez le fichier `data/institutions_ips.json` pour ajouter des plages d'IPs d'institutions :

```json
{
  "institutions": {
    "police_gendarmerie": {
      "name": "Police / Gendarmerie",
      "ranges": [
        "192.0.2.0/24",
        "203.0.113.0/24"
      ],
      "keywords": ["police", "gendarmerie", "dgsn", "dgsi"]
    }
  }
}
```

### Format des plages

Utilisez le format **CIDR** pour les plages d'IPs :
- `192.0.2.0/24` : Plage de 192.0.2.0 à 192.0.2.255
- `203.0.113.0/24` : Plage de 203.0.113.0 à 203.0.113.255

### Mots-clés

Les mots-clés sont utilisés pour détecter les institutions via le **reverse DNS** (hostname). Si le hostname d'une IP contient un de ces mots-clés, elle sera marquée comme suspecte.

Exemples de mots-clés :
- `police`
- `gendarmerie`
- `dgsn` (Direction Générale de la Sécurité Nationale)
- `dgsi` (Direction Générale de la Sécurité Intérieure)
- `law enforcement`
- `government`

## 📝 Liste noire d'IPs

### Fichier

Les IPs ajoutées manuellement sont stockées dans `data/suspicious_ips.json`.

### Ajout manuel

1. Via l'interface : Clic droit sur une connexion → "Ajouter IP à la liste noire"
2. Via le fichier JSON : Éditez `data/suspicious_ips.json` :

```json
{
  "ips": [
    "192.0.2.100",
    "203.0.113.50"
  ]
}
```

## 🔴 Détection automatique

### Critères de détection

Une connexion est marquée en **rouge** si :

1. **IP dans la liste noire** : L'IP distante est dans `suspicious_ips.json`
2. **Plage d'institution** : L'IP appartient à une plage configurée dans `institutions_ips.json`
3. **Hostname suspect** : Le reverse DNS contient un mot-clé d'institution

### Score de confiance

- **100%** : IP dans la liste noire
- **80%** : IP dans une plage d'institution
- **70%** : Hostname contient un mot-clé suspect

## ⚠️ Notes importantes

1. **Privilèges administrateur** : Recommandés pour un accès complet aux connexions réseau
2. **Performance** : L'actualisation se fait toutes les 3 secondes par défaut
3. **Reverse DNS** : Peut être lent, les vérifications sont faites en arrière-plan
4. **Plages d'IPs** : Vous devez configurer les plages réelles des institutions à surveiller

## 🚀 Utilisation

1. Lancez ARGUS avec l'interface graphique : `lanceur_gui.bat`
2. Allez dans l'onglet **"Connexions"**
3. Les connexions suspectes apparaissent en **rouge**
4. Double-cliquez sur une connexion pour voir les détails
5. Utilisez les filtres pour affiner la vue

## 📊 Exemples de détection

### Connexion normale
- IP distante : `8.8.8.8` (Google DNS)
- Couleur : Blanc
- Institution : N/A
- Suspect : ✓ NON

### Connexion suspecte
- IP distante : `192.0.2.100` (dans une plage de police)
- Couleur : 🔴 Rouge
- Institution : Police / Gendarmerie
- Suspect : ⚠ OUI

### Connexion avec hostname suspect
- IP distante : `203.0.113.50`
- Hostname : `police-surveillance.example.com`
- Couleur : 🔴 Rouge
- Institution : Police / Gendarmerie
- Suspect : ⚠ OUI

---

Pour toute question, consultez le `README.md` principal.

