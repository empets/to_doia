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

@freezed
abstract class GraceResponse with _$GraceResponse {
  const factory GraceResponse({
    required String message,
    required GraceAction action,
  }) = _GraceResponse;

  factory GraceResponse.fromJson(Map<String, dynamic> json) =>
      _$GraceResponseFromJson(json);
}

@freezed
abstract class GraceAction with _$GraceAction {
  const GraceAction._();

  const factory GraceAction({required String type, String? destination}) =
      _GraceAction;

  bool get shouldNavigate => type == 'navigate';

  factory GraceAction.fromJson(Map<String, dynamic> json) =>
      _$GraceActionFromJson(json);
}
