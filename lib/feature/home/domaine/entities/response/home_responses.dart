import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_responses.freezed.dart';
part 'home_responses.g.dart';

@freezed
abstract class TaskResponse with _$TaskResponse {
  const factory TaskResponse({
    required String title,
    required String date,
    required String time,
    required bool recurring,
  }) = _TaskResponse;

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
}
