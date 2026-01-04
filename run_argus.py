#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Script de démarrage simplifié pour ARGUS
"""
import sys
import os

# Ajouter le répertoire racine au path Python
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

if __name__ == "__main__":
    from core.main import main
    main()


