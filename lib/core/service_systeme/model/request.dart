import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

@freezed
abstract class Request<T> with _$Request<T> {
  factory Request({
    required dynamic data,
    String? user,
    String? deviceId,
    required String serviceLibelle,
  }) = _Request<T>;

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}

@freezed
abstract class RequestPaginate<T> with _$RequestPaginate<T> {
  factory RequestPaginate({
    required int size,
    required int index,
    required dynamic data,
    required String user,
    required String serviceLibelle,
  }) = _RequestPaginate<T>;

  factory RequestPaginate.fromJson(Map<String, dynamic> json) =>
      _$RequestPaginateFromJson(json);
}

@freezed
abstract class RequestWithoutUser<T> with _$RequestWithoutUser<T> {
  factory RequestWithoutUser({
    required dynamic data,
    required String serviceLibelle,
  }) = _RequestWithoutUser<T>;

  factory RequestWithoutUser.fromJson(Map<String, dynamic> json) =>
      _$RequestWithoutUserFromJson(json);
}

@freezed
abstract class RequestWrapper<T> with _$RequestWrapper<T> {
  factory RequestWrapper({
    required dynamic data,
    required String user,
    required String serviceLibelle,
  }) = _RequestWrapper<T>;

  factory RequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$RequestWrapperFromJson(json);
}

@freezed
abstract class RequestDatas<T> with _$RequestDatas<T> {
  factory RequestDatas({
    required dynamic datas,
    required String user,
    required String serviceLibelle,
  }) = _RequestDatas<T>;

  factory RequestDatas.fromJson(Map<String, dynamic> json) =>
      _$RequestDatasFromJson(json);
}

@freezed
abstract class RequestDatasWithoutUser<T> with _$RequestDatasWithoutUser<T> {
  factory RequestDatasWithoutUser({
    required String? user,
    required dynamic datas,
    required String serviceLibelle,
  }) = _RequestDatasWithoutUser<T>;

  factory RequestDatasWithoutUser.fromJson(Map<String, dynamic> json) =>
      _$RequestDatasWithoutUserFromJson(json);
}

@freezed
abstract class RequestAuth<T> with _$RequestAuth<T> {
  factory RequestAuth({
    required String? user,
    required dynamic data,
    required String serviceLibelle,
    @Default('11234567896587452365879654123698') String key,
  }) = _RequestAuth<T>;

  factory RequestAuth.fromJson(Map<String, dynamic> json) =>
      _$RequestAuthFromJson(json);
}
