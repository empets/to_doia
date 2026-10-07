import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_tast_event.freezed.dart';

@freezed
abstract class CreateTaskEvent with _$CreateTaskEvent {
  factory CreateTaskEvent.changeTitle(String title) =
      ChangeTitleCreateTaskEvent;

  factory CreateTaskEvent.changeDate(String date) = ChangeDateCreateTaskEvent;

  factory CreateTaskEvent.changeTime(String time) = ChangeTimeCreateTaskEvent;

  factory CreateTaskEvent.changeRecurring(bool recurring) =
      ChangeRecurringCreateTaskEvent;

  factory CreateTaskEvent.changeContent(String content) =
      ChangeContentCreateTaskEvent;

  factory CreateTaskEvent.changeStatus(String status) =
      ChangeStatusCreateTaskEvent;

  factory CreateTaskEvent.changeTaskId(String taskId) =
      ChangeTaskIdCreateTaskEvent;

  factory CreateTaskEvent.actionType(String actionType) =
      ActionTypeInfoCreateTaskEvent;

  factory CreateTaskEvent.submit() = SubmitCreateTaskEvent;
}
