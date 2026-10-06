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
    required String content,
    required String status,
    @Default("") String taskId,
    @Default("") String createAt,
    @Default("") String userId,
    @Default(0) int recordtime,
  }) = _TaskResponse;

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
}
