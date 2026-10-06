import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
part 'home_responses_models.freezed.dart';
part 'home_responses_models.g.dart';

@freezed
abstract class TaskResponseModel with _$TaskResponseModel {
  const factory TaskResponseModel({
    required String? title,
    required String? date,
    required String? time,
    @Default(false) bool recurring,
    required String? content,
    required String? status,
    @Default("") String? createAt,
    @Default("") String taskId,
    @Default("") String userId,
    @Default(0) int recordtime,
  }) = _TaskResponseModel;

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseModelFromJson(json);

  static TaskResponse toDomain(TaskResponseModel model) {
    return TaskResponse(
      title: model.title.getOrEmpty(),
      date: model.date.getOrEmpty(),
      time: model.time.getOrEmpty(),
      recurring: model.recurring.getOrEmpty(),
      content: model.content.getOrEmpty(),
      status: model.status.getOrEmpty(),
      createAt: model.createAt.getOrEmpty(),
      taskId: model.taskId.getOrEmpty(),
      userId: model.userId.getOrEmpty(),
      recordtime: model.recordtime.getOrEmpty(),
    );
  }
}
