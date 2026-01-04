#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Script de démarrage pour l'interface graphique ARGUS
"""
import sys
import os

# Ajouter le répertoire racine au path Python
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Vérifier que nous sommes sur Windows
if sys.platform != 'win32':
    print("ARGUS nécessite Windows pour fonctionner")
    sys.exit(1)

if __name__ == "__main__":
    try:
        from core.gui.main_window import main
        main()
    except ImportError as e:
        print(f"Erreur d'import: {e}")
        print("Assurez-vous que toutes les dépendances sont installées.")
        sys.exit(1)
    except Exception as e:
        print(f"Erreur: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


