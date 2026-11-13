## 1. Supprimer le code mort de custome_text.dart

- [x] 1.1 Ouvrir `lib/core/custome_widget/custome_text.dart` et supprimer la classe `CustomeText` (lignes 6-24) et vérifier qu'aucune autre partie du projet ne l'importe → vérification : recherche globale `CustomeText` retourne 0 occurrence hors ce fichier
- [x] 1.2 Supprimer la classe `ExpandableText` et son état `_ExpandableTextState` (lignes 26-75) du même fichier → vérification : recherche globale `ExpandableText` et `_ExpandableTextState` retourne 0 occurrence hors ce fichier
- [x] 1.3 Nettoyer les importations devenues inutiles (`google_fonts`, `grace_church/core/constante/app_colors.dart`) si elles ne servent qu'aux classes supprimées, garder `flutter/material.dart` → vérification : le fichier compile sans erreur d'import inutilisé. Le fichier est devenu vide (plus aucune classe), il est donc supprimé en entier.
- [x] 1.4 Vérifier qu'aucune référence résiduelle à `isReadMore`, "Lire la suite", "Réduire" ne reste dans le projet → vérification : recherche globale retourne 0 occurrence

## 2. Vérification finale

- [x] 2.1 `flutter analyze` : plus aucune erreur liée aux widgets supprimés ; le fichier `custome_text.dart` n'existe plus et n'est importé nulle part → vérification : recherche globale `custome_text` retourne 0 occurrence, `flutter analyze` sur le fichier supprimé ne rapporte rien à ce sujet
- [x] 2.2 Comportement inchangé : aucun écran ne fait référence aux widgets supprimés ; le menu `···` (`Icons.more_horiz_rounded`) de `task_card.dart` est conservé et sans rapport
