## Context

État actuel : `lib/core/custome_widget/custome_text.dart` définit deux widgets inutilisés :
- `CustomeText` (lignes 6-24) : widget Stateless affichant un `Text`.
- `ExpandableText` (lignes 26-75) : widget Stateful avec bouton "Lire la suite" / "Réduire".

Aucun de ces deux widgets n'est importé ou référencé ailleurs dans le projet (vérifié par recherche sur toutes les occurrences de `ExpandableText`, `CustomeText`, `isReadMore`, "Lire la suite", "Réduire"). Voir `proposal.md` pour la motivation.

## Goals / Non-Goals

**Goals:**
- Supprimer `ExpandableText` et `_ExpandableTextState` du fichier.
- Supprimer `CustomeText` du fichier.
- Nettoyer les importations devenues inutiles (`google_fonts`, `grace_church/core/constante/app_colors.dart` si elles ne servent plus à rien après la suppression).
- Ne rien casser : l'application doit conserver exactement le même comportement à l'exécution.

**Non-Goals:**
- Ne pas modifier `Icons.more_horiz_rounded` dans `task_card.dart` : ce menu `···` est utilisé activement et n'a aucun lien avec le code "more" mort.
- Ne pas toucher aux autres widgets de `lib/core/custome_widget/` (`button.dart`, `dater.dart`, `form_filed.dart`, `navigate.dart`).
- Ne pas ajouter de nouveau comportement ni de nouvelle fonctionnalité.

## Decisions

| Décision | Raison | Alternative envisagée |
|----------|--------|-----------------------|
| Supprimer `CustomeText` aussi bien que `ExpandableText` | `CustomeText` est défini mais jamais importé ni utilisé, tout comme `ExpandableText`. Les supprimer ensemble évite de laisser un autre widget mort juste à côté. | Conserver `CustomeText` "au cas où" — refusé, car c'est du code mort confirmé et il n'apporte aucune valeur. |
| Ne supprimer que ces deux classes, garder le fichier | Le fichier reste valide et peut accueillir d'autres widgets custom text à l'avenir. | Supprimer le fichier entier — refusé, car le fichier peut être réutilisé et d'autres widgets pourraient y être ajoutés plus tard. |

## Risks / Trade-offs

- [Risque] Une référence à `CustomeText` ou `ExpandableText` existerait dans un fichier non Dart (généré, configuration, documentation) échappé à la recherche Dart. → **Mitigation** : relancer une recherche globale après l'édition ; si une référence est trouvée, la traiter au cas par cas avant de valider.
- [Risque] Supprimer une importation encore utilisée par une autre classe restée dans le fichier. → **Mitigation** : n'extraire que les importations qui ne servent qu'aux deux classes supprimées (`google_fonts`, `app_colors` si elles ne servent qu'à `ExpandableText`).
- [Trade-off] Le fichier devient plus court et contient uniquement l'import `flutter/material.dart` sans classe définie, ce qui est un fichier Dart valide mais sans contenu exposé. → acceptable pour l'instant ; le fichier peut être supprimé ultérieurement s'il reste vide.

## Migration Plan

Aucune migration nécessaire : ce changement ne modifie aucun comportement, API, donnée ni dépendance. Le rollback consiste à restaurer le fichier depuis Git si besoin.

## Open Questions

Aucune.
