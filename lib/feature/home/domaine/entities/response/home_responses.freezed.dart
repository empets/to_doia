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


/// @nodoc
mixin _$GraceResponse {

 String get message; GraceAction get action;
/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GraceResponseCopyWith<GraceResponse> get copyWith => _$GraceResponseCopyWithImpl<GraceResponse>(this as GraceResponse, _$identity);

  /// Serializes this GraceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GraceResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,action);

@override
String toString() {
  return 'GraceResponse(message: $message, action: $action)';
}


}

/// @nodoc
abstract mixin class $GraceResponseCopyWith<$Res>  {
  factory $GraceResponseCopyWith(GraceResponse value, $Res Function(GraceResponse) _then) = _$GraceResponseCopyWithImpl;
@useResult
$Res call({
 String message, GraceAction action
});


$GraceActionCopyWith<$Res> get action;

}
/// @nodoc
class _$GraceResponseCopyWithImpl<$Res>
    implements $GraceResponseCopyWith<$Res> {
  _$GraceResponseCopyWithImpl(this._self, this._then);

  final GraceResponse _self;
  final $Res Function(GraceResponse) _then;

/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? action = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as GraceAction,
  ));
}
/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GraceActionCopyWith<$Res> get action {
  
  return $GraceActionCopyWith<$Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}


/// Adds pattern-matching-related methods to [GraceResponse].
extension GraceResponsePatterns on GraceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GraceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GraceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GraceResponse value)  $default,){
final _that = this;
switch (_that) {
case _GraceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GraceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GraceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  GraceAction action)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GraceResponse() when $default != null:
return $default(_that.message,_that.action);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  GraceAction action)  $default,) {final _that = this;
switch (_that) {
case _GraceResponse():
return $default(_that.message,_that.action);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  GraceAction action)?  $default,) {final _that = this;
switch (_that) {
case _GraceResponse() when $default != null:
return $default(_that.message,_that.action);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GraceResponse implements GraceResponse {
  const _GraceResponse({required this.message, required this.action});
  factory _GraceResponse.fromJson(Map<String, dynamic> json) => _$GraceResponseFromJson(json);

@override final  String message;
@override final  GraceAction action;

/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GraceResponseCopyWith<_GraceResponse> get copyWith => __$GraceResponseCopyWithImpl<_GraceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GraceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GraceResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,action);

@override
String toString() {
  return 'GraceResponse(message: $message, action: $action)';
}


}

/// @nodoc
abstract mixin class _$GraceResponseCopyWith<$Res> implements $GraceResponseCopyWith<$Res> {
  factory _$GraceResponseCopyWith(_GraceResponse value, $Res Function(_GraceResponse) _then) = __$GraceResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, GraceAction action
});


@override $GraceActionCopyWith<$Res> get action;

}
/// @nodoc
class __$GraceResponseCopyWithImpl<$Res>
    implements _$GraceResponseCopyWith<$Res> {
  __$GraceResponseCopyWithImpl(this._self, this._then);

  final _GraceResponse _self;
  final $Res Function(_GraceResponse) _then;

/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? action = null,}) {
  return _then(_GraceResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as GraceAction,
  ));
}

/// Create a copy of GraceResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GraceActionCopyWith<$Res> get action {
  
  return $GraceActionCopyWith<$Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}


/// @nodoc
mixin _$GraceAction {

 String get type; String? get destination;
/// Create a copy of GraceAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GraceActionCopyWith<GraceAction> get copyWith => _$GraceActionCopyWithImpl<GraceAction>(this as GraceAction, _$identity);

  /// Serializes this GraceAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GraceAction&&(identical(other.type, type) || other.type == type)&&(identical(other.destination, destination) || other.destination == destination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,destination);

@override
String toString() {
  return 'GraceAction(type: $type, destination: $destination)';
}


}

/// @nodoc
abstract mixin class $GraceActionCopyWith<$Res>  {
  factory $GraceActionCopyWith(GraceAction value, $Res Function(GraceAction) _then) = _$GraceActionCopyWithImpl;
@useResult
$Res call({
 String type, String? destination
});




}
/// @nodoc
class _$GraceActionCopyWithImpl<$Res>
    implements $GraceActionCopyWith<$Res> {
  _$GraceActionCopyWithImpl(this._self, this._then);

  final GraceAction _self;
  final $Res Function(GraceAction) _then;

/// Create a copy of GraceAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? destination = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GraceAction].
extension GraceActionPatterns on GraceAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GraceAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GraceAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GraceAction value)  $default,){
final _that = this;
switch (_that) {
case _GraceAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GraceAction value)?  $default,){
final _that = this;
switch (_that) {
case _GraceAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String? destination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GraceAction() when $default != null:
return $default(_that.type,_that.destination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String? destination)  $default,) {final _that = this;
switch (_that) {
case _GraceAction():
return $default(_that.type,_that.destination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String? destination)?  $default,) {final _that = this;
switch (_that) {
case _GraceAction() when $default != null:
return $default(_that.type,_that.destination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GraceAction extends GraceAction {
  const _GraceAction({required this.type, this.destination}): super._();
  factory _GraceAction.fromJson(Map<String, dynamic> json) => _$GraceActionFromJson(json);

@override final  String type;
@override final  String? destination;

/// Create a copy of GraceAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GraceActionCopyWith<_GraceAction> get copyWith => __$GraceActionCopyWithImpl<_GraceAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GraceActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GraceAction&&(identical(other.type, type) || other.type == type)&&(identical(other.destination, destination) || other.destination == destination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,destination);

@override
String toString() {
  return 'GraceAction(type: $type, destination: $destination)';
}


}

/// @nodoc
abstract mixin class _$GraceActionCopyWith<$Res> implements $GraceActionCopyWith<$Res> {
  factory _$GraceActionCopyWith(_GraceAction value, $Res Function(_GraceAction) _then) = __$GraceActionCopyWithImpl;
@override @useResult
$Res call({
 String type, String? destination
});




}
/// @nodoc
class __$GraceActionCopyWithImpl<$Res>
    implements _$GraceActionCopyWith<$Res> {
  __$GraceActionCopyWithImpl(this._self, this._then);

  final _GraceAction _self;
  final $Res Function(_GraceAction) _then;

/// Create a copy of GraceAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? destination = freezed,}) {
  return _then(_GraceAction(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
