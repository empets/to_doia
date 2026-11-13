import 'package:formz/formz.dart';

/// Erreurs possibles pour la confirmation du mot de passe.
enum ConfirmationMotDePasseValidationError { vide, different }

/// Confirmation du mot de passe : doit correspondre au mot de passe saisi.
class ConfirmationMotDePasseFormz
    extends FormzInput<String, ConfirmationMotDePasseValidationError> {
  const ConfirmationMotDePasseFormz.pure([this.motDePasse = ''])
    : super.pure('');

  const ConfirmationMotDePasseFormz.dirty([
    super.value = '',
    this.motDePasse = '',
  ]) : super.dirty();

  /// Valeur du mot de passe à confirmer.
  final String motDePasse;

  @override
  ConfirmationMotDePasseValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmationMotDePasseValidationError.vide;
    return value == motDePasse
        ? null
        : ConfirmationMotDePasseValidationError.different;
  }
}
