import 'package:formz/formz.dart';
import 'package:to_doia/core/extention/app_extention.dart';

enum ContactFormzValidationError { empty }

class ContactFormz extends FormzInput<String, ContactFormzValidationError> {
  const ContactFormz.dirty([super.value = '']) : super.dirty();
  const ContactFormz.pure() : super.pure('');

  @override
  ContactFormzValidationError? validator(String value) {
    final result = value.trim();
    return result.isNotEmpty && result.isValidContact()
        ? null
        : ContactFormzValidationError.empty;
  }
}

enum ContactFormzValidationErrors { empty, invalid }

class ContactOSFormz extends FormzInput<String, ContactFormzValidationErrors> {
  const ContactOSFormz.pure() : super.pure('');
  const ContactOSFormz.dirty([super.value = '']) : super.dirty();

  @override
  ContactFormzValidationErrors? validator(String value) {
    final result = value.trim();

    // Vérifie si le champ est vide
    if (result.isEmpty) {
      return ContactFormzValidationErrors.empty;
    }

    // Vérifie si ça commence par "07" et que c'est un numéro valide
    final phoneRegex = RegExp(r'^07\d{8}$'); // 07 suivi de 8 chiffres

    if (!phoneRegex.hasMatch(result)) {
      return ContactFormzValidationErrors.invalid;
    }

    return null;
  }
}

extension ContactValidator on String {
  bool isValidContacts() {
    final cleaned = replaceAll(RegExp(r'\s+'), ''); // Enlève les espaces
    final phoneRegex =
        RegExp(r'^0\d{9}$'); // Commence par 0 + 9 chiffres = 10 chiffres
    return phoneRegex.hasMatch(cleaned);
  }
}

enum ContactFormzValidationssError { empty }

class ContactsFormz extends FormzInput<String, ContactFormzValidationError> {
  const ContactsFormz.dirty([super.value = '']) : super.dirty();
  const ContactsFormz.pure() : super.pure('');

  @override
  ContactFormzValidationError? validator(String value) {
    final result = value.trim();
    return result.isNotEmpty && result.isValidContacts()
        ? null
        : ContactFormzValidationError.empty;
  }
}
