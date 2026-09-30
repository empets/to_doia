import 'package:formz/formz.dart';
import 'package:to_doia/core/extention/app_extention.dart';

enum TextFormzValidationError { empty }

enum IdentifiantFormzValidationError { empty }

// isValidPassword

class TextFormz extends FormzInput<String, TextFormzValidationError> {
  const TextFormz.dirty([super.value = '']) : super.dirty();
  const TextFormz.pure() : super.pure('');

  @override
  TextFormzValidationError? validator(String value) {
    final result = value.trim();

    return result.isNotEmpty ? null : TextFormzValidationError.empty;
  }
}

class IdentifiantFormz
    extends FormzInput<String, IdentifiantFormzValidationError> {
  const IdentifiantFormz.dirty([super.value = '']) : super.dirty();
  const IdentifiantFormz.pure() : super.pure('');

  @override
  IdentifiantFormzValidationError? validator(String value) {
    final result = value.trim();
    if (result.isNotEmpty && result.startsWith('27')) {
      return result.isIdentifiantFibre()
          ? null
          : IdentifiantFormzValidationError.empty;
    } else if (result.isNotEmpty && result.isValidEmail()) {
      return (result.contains('ofibre') || result.contains('ovsat'))
          ? null
          : IdentifiantFormzValidationError.empty;
    } else if (result.isNotEmpty &&
        RegExp(r'^\d{5,20}$').hasMatch(result) &&
        !result.startsWith('27')) {
      return null;
    } else {
      return IdentifiantFormzValidationError.empty;
    }
  }
}

enum TextOTPFormzValidationError { empty }

class TextOTPFormz extends FormzInput<String, TextOTPFormzValidationError> {
  const TextOTPFormz.dirty([super.value = '']) : super.dirty();
  const TextOTPFormz.pure() : super.pure('');

  @override
  TextOTPFormzValidationError? validator(String value) {
    final result = value.trim();
    return result.isNotEmpty && result.length == 6
        ? null
        : TextOTPFormzValidationError.empty;
  }
}

enum TextValiderNdFibreFormzValidationError { empty, invalid }

class TextValiderNdFibreFormz
    extends FormzInput<String, TextValiderNdFibreFormzValidationError> {
  const TextValiderNdFibreFormz.pure() : super.pure('');
  const TextValiderNdFibreFormz.dirty([super.value = '']) : super.dirty();

  @override
  TextValiderNdFibreFormzValidationError? validator(String value) {
    final result = value.trim();

    // Vérifie que la chaîne n’est pas vide
    if (result.isEmpty) {
      return TextValiderNdFibreFormzValidationError.empty;
    }

    // 🔹 Cas 1 : Numéro qui commence par 27 et contient 10 chiffres
    final isTenDigitNumberStartingWith27 =
        RegExp(r'^27\d{8}$').hasMatch(result);
    if (isTenDigitNumberStartingWith27) return null;

    // 🔹 Sinon, invalide
    return TextValiderNdFibreFormzValidationError.invalid;
  }
}

enum TextMacFormzValidationError { empty, invalid }

class TextMacFormz extends FormzInput<String, TextMacFormzValidationError> {
  const TextMacFormz.dirty([super.value = '']) : super.dirty();
  const TextMacFormz.pure() : super.pure('');

  @override
  TextMacFormzValidationError? validator(String value) {
    final result = value.trim();

    if (result.isEmpty) {
      return TextMacFormzValidationError.empty;
    }

    final macRegex = RegExp(r'^([0-9A-F]{2}:){5}[0-9A-F]{2}$');

    return macRegex.hasMatch(result)
        ? null
        : TextMacFormzValidationError.invalid;
  }
}

enum TextTrackingCodeFormzValidationError { empty, invalid }

class TextTrackingCodeFormz
    extends FormzInput<String, TextTrackingCodeFormzValidationError> {
  const TextTrackingCodeFormz.pure() : super.pure('');
  const TextTrackingCodeFormz.dirty([super.value = '']) : super.dirty();

  @override
  TextTrackingCodeFormzValidationError? validator(String value) {
    final result = value.trim();

    if (result.isEmpty) {
      return TextTrackingCodeFormzValidationError.empty;
    }

    // Doit être uniquement des chiffres
    if (!RegExp(r'^\d+$').hasMatch(result)) {
      return TextTrackingCodeFormzValidationError.invalid;
    }

    // Doit avoir entre 5 et 20 caractères
    if (result.length < 5 || result.length > 20) {
      return TextTrackingCodeFormzValidationError.invalid;
    }

    // Ne doit pas commencer par 27 (c'est un ND fibre)
    if (result.startsWith('27')) {
      return TextTrackingCodeFormzValidationError.invalid;
    }

    return null;
  }
}

enum PhoneAlternativeFormzValidationError {
  empty,
  invalid,
}

class PhoneAlternativeFormz
    extends FormzInput<String, PhoneAlternativeFormzValidationError> {
  const PhoneAlternativeFormz.pure() : super.pure('');
  const PhoneAlternativeFormz.dirty([super.value = '']) : super.dirty();

  @override
  PhoneAlternativeFormzValidationError? validator(String value) {
    final phone = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.isEmpty) {
      return PhoneAlternativeFormzValidationError.empty;
    }

    if (!RegExp(r'^(01|05|07)\d{8}$').hasMatch(phone)) {
      return PhoneAlternativeFormzValidationError.invalid;
    }

    return null;
  }
}
