import 'package:formz/formz.dart';
import 'package:grace_church/core/extention/app_extention.dart';

/// Erreurs possibles pour les champs facultatifs du formulaire.
enum ChampFacultatifValidationError { invalide }

/// Champ texte facultatif : une valeur vide est toujours acceptée.
class TextFacultatifFormz
    extends FormzInput<String, ChampFacultatifValidationError> {
  const TextFacultatifFormz.pure() : super.pure('');
  const TextFacultatifFormz.dirty([super.value = '']) : super.dirty();

  @override
  ChampFacultatifValidationError? validator(String value) => null;
}

/// Champ e-mail facultatif : vide accepté, format vérifié si renseigné.
class EmailFacultatifFormz
    extends FormzInput<String, ChampFacultatifValidationError> {
  const EmailFacultatifFormz.pure() : super.pure('');
  const EmailFacultatifFormz.dirty([super.value = '']) : super.dirty();

  @override
  ChampFacultatifValidationError? validator(String value) {
    final result = value.trim();
    if (result.isEmpty) return null;
    return result.isValidEmail()
        ? null
        : ChampFacultatifValidationError.invalide;
  }
}
