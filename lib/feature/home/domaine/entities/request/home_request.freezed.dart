// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestCreateTask {

 String get title; String get date; String get time; bool get recurring; String get content; String get status; String get id;
/// Create a copy of RequestCreateTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestCreateTaskCopyWith<RequestCreateTask> get copyWith => _$RequestCreateTaskCopyWithImpl<RequestCreateTask>(this as RequestCreateTask, _$identity);

  /// Serializes this RequestCreateTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestCreateTask&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status,id);

@override
String toString() {
  return 'RequestCreateTask(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status, id: $id)';
}


}

/// @nodoc
abstract mixin class $RequestCreateTaskCopyWith<$Res>  {
  factory $RequestCreateTaskCopyWith(RequestCreateTask value, $Res Function(RequestCreateTask) _then) = _$RequestCreateTaskCopyWithImpl;
@useResult
$Res call({
 String title, String date, String time, bool recurring, String content, String status, String id
});




}
/// @nodoc
class _$RequestCreateTaskCopyWithImpl<$Res>
    implements $RequestCreateTaskCopyWith<$Res> {
  _$RequestCreateTaskCopyWithImpl(this._self, this._then);

  final RequestCreateTask _self;
  final $Res Function(RequestCreateTask) _then;

/// Create a copy of RequestCreateTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? status = null,Object? id = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestCreateTask].
extension RequestCreateTaskPatterns on RequestCreateTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestCreateTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestCreateTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestCreateTask value)  $default,){
final _that = this;
switch (_that) {
case _RequestCreateTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestCreateTask value)?  $default,){
final _that = this;
switch (_that) {
case _RequestCreateTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestCreateTask() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String id)  $default,) {final _that = this;
switch (_that) {
case _RequestCreateTask():
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String date,  String time,  bool recurring,  String content,  String status,  String id)?  $default,) {final _that = this;
switch (_that) {
case _RequestCreateTask() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestCreateTask implements RequestCreateTask {
   _RequestCreateTask({required this.title, required this.date, required this.time, required this.recurring, required this.content, required this.status, this.id = ""});
  factory _RequestCreateTask.fromJson(Map<String, dynamic> json) => _$RequestCreateTaskFromJson(json);

@override final  String title;
@override final  String date;
@override final  String time;
@override final  bool recurring;
@override final  String content;
@override final  String status;
@override@JsonKey() final  String id;

/// Create a copy of RequestCreateTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestCreateTaskCopyWith<_RequestCreateTask> get copyWith => __$RequestCreateTaskCopyWithImpl<_RequestCreateTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestCreateTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestCreateTask&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status,id);

@override
String toString() {
  return 'RequestCreateTask(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status, id: $id)';
}


}

/// @nodoc
abstract mixin class _$RequestCreateTaskCopyWith<$Res> implements $RequestCreateTaskCopyWith<$Res> {
  factory _$RequestCreateTaskCopyWith(_RequestCreateTask value, $Res Function(_RequestCreateTask) _then) = __$RequestCreateTaskCopyWithImpl;
@override @useResult
$Res call({
 String title, String date, String time, bool recurring, String content, String status, String id
});




}
/// @nodoc
class __$RequestCreateTaskCopyWithImpl<$Res>
    implements _$RequestCreateTaskCopyWith<$Res> {
  __$RequestCreateTaskCopyWithImpl(this._self, this._then);

  final _RequestCreateTask _self;
  final $Res Function(_RequestCreateTask) _then;

/// Create a copy of RequestCreateTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? status = null,Object? id = null,}) {
  return _then(_RequestCreateTask(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RequestTaskUpdateKey {

 String get taskId;
/// Create a copy of RequestTaskUpdateKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestTaskUpdateKeyCopyWith<RequestTaskUpdateKey> get copyWith => _$RequestTaskUpdateKeyCopyWithImpl<RequestTaskUpdateKey>(this as RequestTaskUpdateKey, _$identity);

  /// Serializes this RequestTaskUpdateKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTaskUpdateKey&&(identical(other.taskId, taskId) || other.taskId == taskId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'RequestTaskUpdateKey(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class $RequestTaskUpdateKeyCopyWith<$Res>  {
  factory $RequestTaskUpdateKeyCopyWith(RequestTaskUpdateKey value, $Res Function(RequestTaskUpdateKey) _then) = _$RequestTaskUpdateKeyCopyWithImpl;
@useResult
$Res call({
 String taskId
});




}
/// @nodoc
class _$RequestTaskUpdateKeyCopyWithImpl<$Res>
    implements $RequestTaskUpdateKeyCopyWith<$Res> {
  _$RequestTaskUpdateKeyCopyWithImpl(this._self, this._then);

  final RequestTaskUpdateKey _self;
  final $Res Function(RequestTaskUpdateKey) _then;

/// Create a copy of RequestTaskUpdateKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskId = null,}) {
  return _then(_self.copyWith(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestTaskUpdateKey].
extension RequestTaskUpdateKeyPatterns on RequestTaskUpdateKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestTaskUpdateKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestTaskUpdateKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestTaskUpdateKey value)  $default,){
final _that = this;
switch (_that) {
case _RequestTaskUpdateKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestTaskUpdateKey value)?  $default,){
final _that = this;
switch (_that) {
case _RequestTaskUpdateKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestTaskUpdateKey() when $default != null:
return $default(_that.taskId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskId)  $default,) {final _that = this;
switch (_that) {
case _RequestTaskUpdateKey():
return $default(_that.taskId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskId)?  $default,) {final _that = this;
switch (_that) {
case _RequestTaskUpdateKey() when $default != null:
return $default(_that.taskId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestTaskUpdateKey implements RequestTaskUpdateKey {
   _RequestTaskUpdateKey({required this.taskId});
  factory _RequestTaskUpdateKey.fromJson(Map<String, dynamic> json) => _$RequestTaskUpdateKeyFromJson(json);

@override final  String taskId;

/// Create a copy of RequestTaskUpdateKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestTaskUpdateKeyCopyWith<_RequestTaskUpdateKey> get copyWith => __$RequestTaskUpdateKeyCopyWithImpl<_RequestTaskUpdateKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestTaskUpdateKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestTaskUpdateKey&&(identical(other.taskId, taskId) || other.taskId == taskId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'RequestTaskUpdateKey(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class _$RequestTaskUpdateKeyCopyWith<$Res> implements $RequestTaskUpdateKeyCopyWith<$Res> {
  factory _$RequestTaskUpdateKeyCopyWith(_RequestTaskUpdateKey value, $Res Function(_RequestTaskUpdateKey) _then) = __$RequestTaskUpdateKeyCopyWithImpl;
@override @useResult
$Res call({
 String taskId
});




}
/// @nodoc
class __$RequestTaskUpdateKeyCopyWithImpl<$Res>
    implements _$RequestTaskUpdateKeyCopyWith<$Res> {
  __$RequestTaskUpdateKeyCopyWithImpl(this._self, this._then);

  final _RequestTaskUpdateKey _self;
  final $Res Function(_RequestTaskUpdateKey) _then;

/// Create a copy of RequestTaskUpdateKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskId = null,}) {
  return _then(_RequestTaskUpdateKey(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
