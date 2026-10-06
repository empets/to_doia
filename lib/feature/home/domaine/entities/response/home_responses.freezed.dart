// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskResponse {

 String get title; String get date; String get time; bool get recurring; String get content; String get status; String get taskId; String get createAt; String get userId; int get recordtime;
/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<TaskResponse> get copyWith => _$TaskResponseCopyWithImpl<TaskResponse>(this as TaskResponse, _$identity);

  /// Serializes this TaskResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResponse&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.createAt, createAt) || other.createAt == createAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.recordtime, recordtime) || other.recordtime == recordtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status,taskId,createAt,userId,recordtime);

@override
String toString() {
  return 'TaskResponse(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status, taskId: $taskId, createAt: $createAt, userId: $userId, recordtime: $recordtime)';
}


}

/// @nodoc
abstract mixin class $TaskResponseCopyWith<$Res>  {
  factory $TaskResponseCopyWith(TaskResponse value, $Res Function(TaskResponse) _then) = _$TaskResponseCopyWithImpl;
@useResult
$Res call({
 String title, String date, String time, bool recurring, String content, String status, String taskId, String createAt, String userId, int recordtime
});




}
/// @nodoc
class _$TaskResponseCopyWithImpl<$Res>
    implements $TaskResponseCopyWith<$Res> {
  _$TaskResponseCopyWithImpl(this._self, this._then);

  final TaskResponse _self;
  final $Res Function(TaskResponse) _then;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? status = null,Object? taskId = null,Object? createAt = null,Object? userId = null,Object? recordtime = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,createAt: null == createAt ? _self.createAt : createAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,recordtime: null == recordtime ? _self.recordtime : recordtime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskResponse].
extension TaskResponsePatterns on TaskResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskResponse value)  $default,){
final _that = this;
switch (_that) {
case _TaskResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TaskResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String taskId,  String createAt,  String userId,  int recordtime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskResponse() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.taskId,_that.createAt,_that.userId,_that.recordtime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String taskId,  String createAt,  String userId,  int recordtime)  $default,) {final _that = this;
switch (_that) {
case _TaskResponse():
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.taskId,_that.createAt,_that.userId,_that.recordtime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String taskId,  String createAt,  String userId,  int recordtime)?  $default,) {final _that = this;
switch (_that) {
case _TaskResponse() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.taskId,_that.createAt,_that.userId,_that.recordtime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskResponse implements TaskResponse {
  const _TaskResponse({required this.title, required this.date, required this.time, required this.recurring, required this.content, required this.status, this.taskId = "", this.createAt = "", this.userId = "", this.recordtime = 0});
  factory _TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

@override final  String title;
@override final  String date;
@override final  String time;
@override final  bool recurring;
@override final  String content;
@override final  String status;
@override@JsonKey() final  String taskId;
@override@JsonKey() final  String createAt;
@override@JsonKey() final  String userId;
@override@JsonKey() final  int recordtime;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskResponseCopyWith<_TaskResponse> get copyWith => __$TaskResponseCopyWithImpl<_TaskResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskResponse&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.createAt, createAt) || other.createAt == createAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.recordtime, recordtime) || other.recordtime == recordtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status,taskId,createAt,userId,recordtime);

@override
String toString() {
  return 'TaskResponse(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status, taskId: $taskId, createAt: $createAt, userId: $userId, recordtime: $recordtime)';
}


}

/// @nodoc
abstract mixin class _$TaskResponseCopyWith<$Res> implements $TaskResponseCopyWith<$Res> {
  factory _$TaskResponseCopyWith(_TaskResponse value, $Res Function(_TaskResponse) _then) = __$TaskResponseCopyWithImpl;
@override @useResult
$Res call({
 String title, String date, String time, bool recurring, String content, String status, String taskId, String createAt, String userId, int recordtime
});




}
/// @nodoc
class __$TaskResponseCopyWithImpl<$Res>
    implements _$TaskResponseCopyWith<$Res> {
  __$TaskResponseCopyWithImpl(this._self, this._then);

  final _TaskResponse _self;
  final $Res Function(_TaskResponse) _then;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? status = null,Object? taskId = null,Object? createAt = null,Object? userId = null,Object? recordtime = null,}) {
  return _then(_TaskResponse(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,createAt: null == createAt ? _self.createAt : createAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,recordtime: null == recordtime ? _self.recordtime : recordtime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
