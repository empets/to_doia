// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_responses_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskResponseModel _$TaskResponseModelFromJson(Map<String, dynamic> json) =>
    _TaskResponseModel(
      title: json['title'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      recurring: json['recurring'] as bool? ?? false,
      content: json['content'] as String?,
      status: json['status'] as String?,
      createAt: json['createAt'] as String? ?? "",
      taskId: json['taskId'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      recordtime: (json['recordtime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TaskResponseModelToJson(_TaskResponseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'recurring': instance.recurring,
      'content': instance.content,
      'status': instance.status,
      'createAt': instance.createAt,
      'taskId': instance.taskId,
      'userId': instance.userId,
      'recordtime': instance.recordtime,
    };
