// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_tast_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTastState {

 TextFormz get title; TextFormz get date; TextFormz get time; bool get recurring; TextFormz get content; TextFormz get eventStatus; String get taskId; TextFormz get actionType; FormzSubmissionStatus get status; String get errorMessage; bool get isValide;
/// Create a copy of CreateTastState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTastStateCopyWith<CreateTastState> get copyWith => _$CreateTastStateCopyWithImpl<CreateTastState>(this as CreateTastState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTastState&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.eventStatus, eventStatus) || other.eventStatus == eventStatus)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide));
}


@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,eventStatus,taskId,actionType,status,errorMessage,isValide);

@override
String toString() {
  return 'CreateTastState(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, eventStatus: $eventStatus, taskId: $taskId, actionType: $actionType, status: $status, errorMessage: $errorMessage, isValide: $isValide)';
}


}

/// @nodoc
abstract mixin class $CreateTastStateCopyWith<$Res>  {
  factory $CreateTastStateCopyWith(CreateTastState value, $Res Function(CreateTastState) _then) = _$CreateTastStateCopyWithImpl;
@useResult
$Res call({
 TextFormz title, TextFormz date, TextFormz time, bool recurring, TextFormz content, TextFormz eventStatus, String taskId, TextFormz actionType, FormzSubmissionStatus status, String errorMessage, bool isValide
});




}
/// @nodoc
class _$CreateTastStateCopyWithImpl<$Res>
    implements $CreateTastStateCopyWith<$Res> {
  _$CreateTastStateCopyWithImpl(this._self, this._then);

  final CreateTastState _self;
  final $Res Function(CreateTastState) _then;

/// Create a copy of CreateTastState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? eventStatus = null,Object? taskId = null,Object? actionType = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TextFormz,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as TextFormz,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TextFormz,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as TextFormz,eventStatus: null == eventStatus ? _self.eventStatus : eventStatus // ignore: cast_nullable_to_non_nullable
as TextFormz,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as TextFormz,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTastState].
extension CreateTastStatePatterns on CreateTastState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTastState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTastState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTastState value)  $default,){
final _that = this;
switch (_that) {
case _CreateTastState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTastState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTastState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextFormz title,  TextFormz date,  TextFormz time,  bool recurring,  TextFormz content,  TextFormz eventStatus,  String taskId,  TextFormz actionType,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTastState() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.eventStatus,_that.taskId,_that.actionType,_that.status,_that.errorMessage,_that.isValide);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextFormz title,  TextFormz date,  TextFormz time,  bool recurring,  TextFormz content,  TextFormz eventStatus,  String taskId,  TextFormz actionType,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)  $default,) {final _that = this;
switch (_that) {
case _CreateTastState():
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.eventStatus,_that.taskId,_that.actionType,_that.status,_that.errorMessage,_that.isValide);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextFormz title,  TextFormz date,  TextFormz time,  bool recurring,  TextFormz content,  TextFormz eventStatus,  String taskId,  TextFormz actionType,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)?  $default,) {final _that = this;
switch (_that) {
case _CreateTastState() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.eventStatus,_that.taskId,_that.actionType,_that.status,_that.errorMessage,_that.isValide);case _:
  return null;

}
}

}

/// @nodoc


class _CreateTastState implements CreateTastState {
   _CreateTastState({required this.title, required this.date, required this.time, required this.recurring, required this.content, required this.eventStatus, required this.taskId, required this.actionType, required this.status, required this.errorMessage, required this.isValide});
  

@override final  TextFormz title;
@override final  TextFormz date;
@override final  TextFormz time;
@override final  bool recurring;
@override final  TextFormz content;
@override final  TextFormz eventStatus;
@override final  String taskId;
@override final  TextFormz actionType;
@override final  FormzSubmissionStatus status;
@override final  String errorMessage;
@override final  bool isValide;

/// Create a copy of CreateTastState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTastStateCopyWith<_CreateTastState> get copyWith => __$CreateTastStateCopyWithImpl<_CreateTastState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTastState&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.eventStatus, eventStatus) || other.eventStatus == eventStatus)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide));
}


@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,eventStatus,taskId,actionType,status,errorMessage,isValide);

@override
String toString() {
  return 'CreateTastState(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, eventStatus: $eventStatus, taskId: $taskId, actionType: $actionType, status: $status, errorMessage: $errorMessage, isValide: $isValide)';
}


}

/// @nodoc
abstract mixin class _$CreateTastStateCopyWith<$Res> implements $CreateTastStateCopyWith<$Res> {
  factory _$CreateTastStateCopyWith(_CreateTastState value, $Res Function(_CreateTastState) _then) = __$CreateTastStateCopyWithImpl;
@override @useResult
$Res call({
 TextFormz title, TextFormz date, TextFormz time, bool recurring, TextFormz content, TextFormz eventStatus, String taskId, TextFormz actionType, FormzSubmissionStatus status, String errorMessage, bool isValide
});




}
/// @nodoc
class __$CreateTastStateCopyWithImpl<$Res>
    implements _$CreateTastStateCopyWith<$Res> {
  __$CreateTastStateCopyWithImpl(this._self, this._then);

  final _CreateTastState _self;
  final $Res Function(_CreateTastState) _then;

/// Create a copy of CreateTastState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? time = null,Object? recurring = null,Object? content = null,Object? eventStatus = null,Object? taskId = null,Object? actionType = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,}) {
  return _then(_CreateTastState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TextFormz,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as TextFormz,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TextFormz,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as TextFormz,eventStatus: null == eventStatus ? _self.eventStatus : eventStatus // ignore: cast_nullable_to_non_nullable
as TextFormz,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as TextFormz,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
