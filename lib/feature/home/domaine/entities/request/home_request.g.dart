// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestCreateTask _$RequestCreateTaskFromJson(Map<String, dynamic> json) =>
    _RequestCreateTask(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      recurring: json['recurring'] as bool,
      content: json['content'] as String,
      status: json['status'] as String,
      userId: json['userId'] as String? ?? "",
    );

Map<String, dynamic> _$RequestCreateTaskToJson(_RequestCreateTask instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'recurring': instance.recurring,
      'content': instance.content,
      'status': instance.status,
      'userId': instance.userId,
    };

_RequestTaskUpdateKey _$RequestTaskUpdateKeyFromJson(
  Map<String, dynamic> json,
) => _RequestTaskUpdateKey(taskId: json['taskId'] as String);

Map<String, dynamic> _$RequestTaskUpdateKeyToJson(
  _RequestTaskUpdateKey instance,
) => <String, dynamic>{'taskId': instance.taskId};
