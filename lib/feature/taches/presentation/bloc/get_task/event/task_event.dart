import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
part 'task_event.freezed.dart';

@freezed
abstract class TaskSectionEvent with _$TaskSectionEvent {
  factory TaskSectionEvent.fetch(String? id) = FetchTaskSectionEvent;
  factory TaskSectionEvent.changeTask(TaskResponse? task) =
      ChangeTaskSectionEvent;
}
