# Interface Graphique ARGUS

## 🖥️ Présentation

ARGUS dispose maintenant d'une interface graphique moderne et intuitive pour faciliter la surveillance de sécurité.

## 🚀 Lancement

### Méthode 1 : Script dédié
```bash
lanceur_gui.bat
```

### Méthode 2 : Depuis le menu principal
```bash
lanceur.bat
# Choisir l'option 5 : Interface Graphique
```

### Méthode 3 : Ligne de commande
```bash
python run_argus_gui.py
```

### Méthode 4 : Avec l'option --gui
```bash
python core/main.py --gui
```

## 📋 Fonctionnalités

### Dashboard Principal

L'interface est divisée en plusieurs sections :

#### Panneau Gauche - Contrôles et Statistiques

1. **Contrôles**
   - Bouton "▶ Démarrer" : Lance la surveillance
   - Bouton "⏹ Arrêter" : Arrête la surveillance
   - Indicateur de statut : Affiche l'état actuel (Arrêté/En cours/Erreur)

2. **Statistiques en temps réel**
   - Processus surveillés
   - Connexions actives
   - Alertes totales
   - Alertes par niveau (Critique, Élevée, Moyenne, Faible)

#### Panneau Droit - Onglets

1. **Onglet "Alertes"**
   - Tableau interactif avec toutes les alertes
   - Colonnes : ID, Heure, Type, Sévérité, Score, Description
   - Code couleur selon la sévérité :
     - 🔴 Critique : Fond rouge clair
     - 🟠 Élevée : Fond orange clair
     - 🟡 Moyenne : Fond jaune clair
     - 🔵 Faible : Fond bleu clair
   - Boutons :
     - "Effacer" : Supprime toutes les alertes affichées
     - "Exporter" : Exporte les alertes vers un fichier texte

2. **Onglet "Logs"**
   - Affichage en temps réel des logs système
   - Fond sombre pour un meilleur confort visuel
   - Défilement automatique
   - Limite automatique à 1000 lignes pour les performances

3. **Onglet "Configuration"**
   - Affiche la configuration actuelle d'ARGUS
   - Intervalles de scan
   - Seuils d'alerte
   - Chemins des fichiers
   - Options activées/désactivées

## 🎨 Caractéristiques de l'interface

- **Design moderne** : Interface sombre et professionnelle
- **Temps réel** : Mise à jour automatique des alertes et statistiques
- **Responsive** : Fenêtre redimensionnable (minimum 1000x600)
- **Thread-safe** : Gestion correcte des threads pour éviter les blocages
- **Codes couleur** : Visualisation rapide de la sévérité des alertes

## ⌨️ Raccourcis et Actions

- **Double-clic sur une alerte** : Affiche les détails complets
- **Fermeture de la fenêtre** : Demande confirmation si la surveillance est active
- **Export** : Sauvegarde les alertes dans un fichier texte

## 🔧 Configuration

L'interface graphique utilise la même configuration que le mode console :
- Fichier `core/config.py` pour les paramètres généraux
- Fichiers `data/whitelist.json` et `data/blacklist.json` pour les listes

## ⚠️ Notes importantes

1. **Privilèges administrateur** : Recommandés pour un accès complet aux événements système
2. **Performance** : L'interface peut consommer plus de ressources que le mode console
3. **Threads** : La surveillance s'exécute dans des threads séparés pour ne pas bloquer l'interface

## 🐛 Dépannage

### L'interface ne se lance pas
- Vérifiez que Python est installé : `python --version`
- Vérifiez que tkinter est disponible : `python -m tkinter`
- Sur certaines distributions Linux, installez : `sudo apt-get install python3-tk`

### Les alertes n'apparaissent pas
- Vérifiez que la surveillance est démarrée (bouton "▶ Démarrer")
- Consultez l'onglet "Logs" pour voir les erreurs éventuelles
- Vérifiez les seuils dans l'onglet "Configuration"

### L'interface est lente
- Réduisez les intervalles de scan dans `core/config.py`
- Limitez le nombre d'alertes affichées (bouton "Effacer" régulièrement)
- Fermez d'autres applications pour libérer des ressources

## 📸 Aperçu

L'interface comprend :
- Un panneau de contrôle avec boutons de démarrage/arrêt
- Des statistiques en temps réel
- Un tableau d'alertes avec codes couleur
- Une zone de logs
- Un affichage de la configuration

## 🔄 Mises à jour futures

Fonctionnalités prévues :
- Graphiques de tendances
- Filtres d'alertes avancés
- Export en plusieurs formats (JSON, CSV, PDF)
- Thèmes personnalisables
- Notifications système intégrées
- Historique des alertes avec recherche

---

Pour toute question ou problème, consultez le `README.md` principal.


