## Why

Le fichier `lib/core/custome_widget/custome_text.dart` définit le widget `ExpandableText` (bouton "Lire la suite" / "Réduire") ainsi que `CustomeText`. Aucun de ces deux widgets n'est importé ou utilisé nulle part dans le projet. C'est du code mort qui alourdit le fichier sans apporter de valeur. Le supprimer allège le codebase sans modifier le comportement de l'application.

## What Changes

- Supprimer le widget `ExpandableText` (classe + état `_ExpandableTextState`) de `lib/core/custome_widget/custome_text.dart`.
- Supprimer le widget `CustomeText` du même fichier, car il est lui aussi inutilisé.
- Conserver les importations encore nécessaires (`flutter/material.dart`) et retirer celles devenues inutiles si elles ne servent plus à rien après la suppression.

## Capabilities

### New Capabilities

Aucune.

### Modified Capabilities

Aucune. Ce changement ne modifie aucun comportement ; il ne touche que l'implémentation (suppression de code mort). Par conséquent, aucune spécification n'est requise et `skip_specs: true` est activé.

## Impact

- `lib/core/custome_widget/custome_text.dart` : réduction du fichier (suppression des deux classes inutilisées).
- Aucun autre fichier du projet n'est affecté, car `ExpandableText` et `CustomeText` ne sont référencés nulle part ailleurs.
- Aucun impact sur l'interface utilisateur, les API, les dépendances ou les systèmes externes.
