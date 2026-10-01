// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Request<T> _$RequestFromJson<T>(Map<String, dynamic> json) => _Request<T>(
  data: json['data'],
  user: json['user'] as String?,
  deviceId: json['deviceId'] as String?,
  serviceLibelle: json['serviceLibelle'] as String,
);

Map<String, dynamic> _$RequestToJson<T>(_Request<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
      'user': instance.user,
      'deviceId': instance.deviceId,
      'serviceLibelle': instance.serviceLibelle,
    };

_RequestPaginate<T> _$RequestPaginateFromJson<T>(Map<String, dynamic> json) =>
    _RequestPaginate<T>(
      size: (json['size'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      data: json['data'],
      user: json['user'] as String,
      serviceLibelle: json['serviceLibelle'] as String,
    );

Map<String, dynamic> _$RequestPaginateToJson<T>(_RequestPaginate<T> instance) =>
    <String, dynamic>{
      'size': instance.size,
      'index': instance.index,
      'data': instance.data,
      'user': instance.user,
      'serviceLibelle': instance.serviceLibelle,
    };

_RequestWithoutUser<T> _$RequestWithoutUserFromJson<T>(
  Map<String, dynamic> json,
) => _RequestWithoutUser<T>(
  data: json['data'],
  serviceLibelle: json['serviceLibelle'] as String,
);

Map<String, dynamic> _$RequestWithoutUserToJson<T>(
  _RequestWithoutUser<T> instance,
) => <String, dynamic>{
  'data': instance.data,
  'serviceLibelle': instance.serviceLibelle,
};

_RequestWrapper<T> _$RequestWrapperFromJson<T>(Map<String, dynamic> json) =>
    _RequestWrapper<T>(
      data: json['data'],
      user: json['user'] as String,
      serviceLibelle: json['serviceLibelle'] as String,
    );

Map<String, dynamic> _$RequestWrapperToJson<T>(_RequestWrapper<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
      'user': instance.user,
      'serviceLibelle': instance.serviceLibelle,
    };

_RequestDatas<T> _$RequestDatasFromJson<T>(Map<String, dynamic> json) =>
    _RequestDatas<T>(
      datas: json['datas'],
      user: json['user'] as String,
      serviceLibelle: json['serviceLibelle'] as String,
    );

Map<String, dynamic> _$RequestDatasToJson<T>(_RequestDatas<T> instance) =>
    <String, dynamic>{
      'datas': instance.datas,
      'user': instance.user,
      'serviceLibelle': instance.serviceLibelle,
    };

_RequestDatasWithoutUser<T> _$RequestDatasWithoutUserFromJson<T>(
  Map<String, dynamic> json,
) => _RequestDatasWithoutUser<T>(
  user: json['user'] as String?,
  datas: json['datas'],
  serviceLibelle: json['serviceLibelle'] as String,
);

Map<String, dynamic> _$RequestDatasWithoutUserToJson<T>(
  _RequestDatasWithoutUser<T> instance,
) => <String, dynamic>{
  'user': instance.user,
  'datas': instance.datas,
  'serviceLibelle': instance.serviceLibelle,
};

_RequestAuth<T> _$RequestAuthFromJson<T>(Map<String, dynamic> json) =>
    _RequestAuth<T>(
      user: json['user'] as String?,
      data: json['data'],
      serviceLibelle: json['serviceLibelle'] as String,
      key: json['key'] as String? ?? '11234567896587452365879654123698',
    );

Map<String, dynamic> _$RequestAuthToJson<T>(_RequestAuth<T> instance) =>
    <String, dynamic>{
      'user': instance.user,
      'data': instance.data,
      'serviceLibelle': instance.serviceLibelle,
      'key': instance.key,
    };
