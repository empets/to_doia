#!/usr/bin/env bash
# Lance l'application avec la configuration locale (env.json).
#
# Pourquoi ce script ?
# Les clés ne sont plus dans le code : elles sont injectées au build via
# --dart-define-from-file. Ce script évite de retenir la commande complète
# et vérifie que env.json existe avant de lancer Flutter.
#
# Usage :
#   ./run.sh                 # appareil par défaut
#   ./run.sh -d macos        # appareil explicite
#   ./run.sh --release       # build release

set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f env.json ]]; then
  cp env.example.json env.json
  echo "env.json était absent : un modèle a été créé."
  echo "Renseigne les clés dans env.json, puis relance ./run.sh"
  exit 1
fi

exec flutter run --dart-define-from-file=env.json "$@"
