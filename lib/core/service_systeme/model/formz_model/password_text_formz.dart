import 'package:formz/formz.dart';
import 'package:to_doia/core/extention/app_extention.dart';

enum PasswordTextFormzValidationError { empty }

// isValidPassword

class PasswordTextFormz
    extends FormzInput<String, PasswordTextFormzValidationError> {
  const PasswordTextFormz.dirty([super.value = '']) : super.dirty();
  const PasswordTextFormz.pure() : super.pure('');

  @override
  PasswordTextFormzValidationError? validator(String value) {
    final result = value.trim();

    return result.isNotEmpty && result.isValidPassword()
        ? null
        : PasswordTextFormzValidationError.empty;
  }
}
