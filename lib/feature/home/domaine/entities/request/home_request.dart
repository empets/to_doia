import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_request.freezed.dart';
part 'home_request.g.dart';

@freezed
abstract class RequestCreateTask with _$RequestCreateTask {
  factory RequestCreateTask({
    required String title,
    required String date,
    required String time,
    required bool recurring,
    required String content,
    required String status,
    @Default("") String id,


  }) = _RequestCreateTask;

  factory RequestCreateTask.fromJson(Map<String, dynamic> json) =>
      _$RequestCreateTaskFromJson(json);
}


@freezed
abstract class RequestTaskUpdateKey
    with _$RequestTaskUpdateKey {
  factory RequestTaskUpdateKey({required String taskId}) =
      // menberId
      _RequestTaskUpdateKey;

  factory RequestTaskUpdateKey.fromJson(Map<String, dynamic> json) =>
      _$RequestTaskUpdateKeyFromJson(json);
}