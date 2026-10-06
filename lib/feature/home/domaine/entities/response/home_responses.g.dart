// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) =>
    _TaskResponse(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      recurring: json['recurring'] as bool,
      content: json['content'] as String,
      status: json['status'] as String,
      taskId: json['taskId'] as String? ?? "",
      createAt: json['createAt'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      recordtime: (json['recordtime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TaskResponseToJson(_TaskResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'recurring': instance.recurring,
      'content': instance.content,
      'status': instance.status,
      'taskId': instance.taskId,
      'createAt': instance.createAt,
      'userId': instance.userId,
      'recordtime': instance.recordtime,
    };
