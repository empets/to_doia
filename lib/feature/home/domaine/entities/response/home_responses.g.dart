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
    );

Map<String, dynamic> _$TaskResponseToJson(_TaskResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'recurring': instance.recurring,
    };
