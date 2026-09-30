import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
abstract class ApiError with _$ApiError {
  factory ApiError({
    @IntOrStringConverter() required String? code,
    required String? message,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}


class IntOrStringConverter implements JsonConverter<String?, dynamic> {
  const IntOrStringConverter();

  @override
  String? fromJson(dynamic value) {
    if (value == null) return null;

    if (value is int) return value.toString();
    if (value is double) return value.toString();

    // Si le backend envoie un string : "15000.50"
    if (value is String) return value;

    throw Exception('Type non supporté pour sommeFacture: $value');
  }

  @override
  dynamic toJson(String? value) => value;
}
