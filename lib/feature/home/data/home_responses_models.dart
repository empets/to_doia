import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:to_doia/core/extention/app_extention.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';
part 'home_responses_models.freezed.dart';
part 'home_responses_models.g.dart';

@freezed
abstract class TaskResponseModel with _$TaskResponseModel {
  const factory TaskResponseModel({
    required String? title,
    required String? date,
    required String? time,
    required bool recurring,
  }) = _TaskResponseModel;

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseModelFromJson(json);

  static TaskResponse toDomain(TaskResponseModel model) {
    return TaskResponse(
      title: model.title.getOrEmpty(),
      date: model.date.getOrEmpty(),
      time: model.time.getOrEmpty(),
      recurring: model.recurring.getOrEmpty(),
    );
  }
}
