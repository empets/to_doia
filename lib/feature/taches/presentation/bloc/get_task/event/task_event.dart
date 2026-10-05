import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_event.freezed.dart';

@freezed
abstract class TaskSectionEvent with _$TaskSectionEvent {
  factory TaskSectionEvent.fetch(String? id) = FetchTaskSectionEvent;
}
