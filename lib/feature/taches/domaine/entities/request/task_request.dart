import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_request.freezed.dart';
part 'task_request.g.dart';

@freezed
abstract class RequestNotParams with _$RequestNotParams {
  factory RequestNotParams({@Default("") String id}) = _RequestNotParams;

  factory RequestNotParams.fromJson(Map<String, dynamic> json) =>
      _$RequestNotParamsFromJson(json);
}
