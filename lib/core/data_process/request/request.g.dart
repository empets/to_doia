// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Request<T> _$RequestFromJson<T>(Map<String, dynamic> json) => _Request<T>(
  data: json['data'] as Map<String, dynamic>,
  user: json['user'] as String,
  serviceLibelle: json['serviceLibelle'] as String,
);

Map<String, dynamic> _$RequestToJson<T>(_Request<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
      'user': instance.user,
      'serviceLibelle': instance.serviceLibelle,
    };
