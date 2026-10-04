import 'package:freezed_annotation/freezed_annotation.dart';
part 'request.freezed.dart';
part 'request.g.dart';

@freezed
abstract class Request<T> with _$Request<T> {
  factory Request({
    required Map<dynamic, dynamic> data,
    required String user,
    required String serviceLibelle,
  }) = _Request<T>;

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}
