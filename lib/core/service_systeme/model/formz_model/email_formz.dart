import 'package:formz/formz.dart';
import 'package:to_doia/core/extention/app_extention.dart';

enum EmailFormzValidationError { empty }

class EmailFormz extends FormzInput<String, EmailFormzValidationError> {
  const EmailFormz.dirty([super.value = '']) : super.dirty();
  const EmailFormz.pure() : super.pure('');

  @override
  EmailFormzValidationError? validator(String value) {
    final result = value.trim();
    return result.isNotEmpty && result.contains('@') && result.isValidEmail()
        ? null
        : EmailFormzValidationError.empty;
  }
}
