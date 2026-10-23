import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';

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

// --- Modèles ---
class SharaAction {
  final String? type; // navigate | create_task | none
  final String? destination;
  final TaskResponseModel? task;

  const SharaAction({required this.type, this.destination, this.task});

  bool get isNavigate => type == 'navigate' && destination != null;
  bool get isCreateTask => type == 'create_task' && task != null;
}

// class SharaResponse {
//   final String message;
//   final SharaAction action;
//   final String? transcript;

//   const SharaResponse({
//     required this.message,
//     required this.action,
//     this.transcript,
//   });
// }

@freezed
abstract class SharaResponse with _$SharaResponse {
  const factory SharaResponse({
    required String message,
    required SharaAction action,
    @Default('') String transcript,
  }) = _SharaResponse;
}
