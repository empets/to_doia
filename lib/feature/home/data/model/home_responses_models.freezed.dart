// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_responses_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskResponseModel {

 String? get title; String? get date; String? get time; bool get recurring; String? get content; String? get status;
/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResponseModelCopyWith<TaskResponseModel> get copyWith => _$TaskResponseModelCopyWithImpl<TaskResponseModel>(this as TaskResponseModel, _$identity);

  /// Serializes this TaskResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResponseModel&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status);

@override
String toString() {
  return 'TaskResponseModel(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status)';
}


}

/// @nodoc
abstract mixin class $TaskResponseModelCopyWith<$Res>  {
  factory $TaskResponseModelCopyWith(TaskResponseModel value, $Res Function(TaskResponseModel) _then) = _$TaskResponseModelCopyWithImpl;
@useResult
$Res call({
 String? title, String? date, String? time, bool recurring, String? content, String? status
});




}
/// @nodoc
class _$TaskResponseModelCopyWithImpl<$Res>
    implements $TaskResponseModelCopyWith<$Res> {
  _$TaskResponseModelCopyWithImpl(this._self, this._then);

  final TaskResponseModel _self;
  final $Res Function(TaskResponseModel) _then;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? date = freezed,Object? time = freezed,Object? recurring = null,Object? content = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskResponseModel].
extension TaskResponseModelPatterns on TaskResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? date,  String? time,  bool recurring,  String? content,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? date,  String? time,  bool recurring,  String? content,  String? status)  $default,) {final _that = this;
switch (_that) {
case _TaskResponseModel():
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? date,  String? time,  bool recurring,  String? content,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
return $default(_that.title,_that.date,_that.time,_that.recurring,_that.content,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskResponseModel implements TaskResponseModel {
  const _TaskResponseModel({required this.title, required this.date, required this.time, this.recurring = false, required this.content, required this.status});
  factory _TaskResponseModel.fromJson(Map<String, dynamic> json) => _$TaskResponseModelFromJson(json);

@override final  String? title;
@override final  String? date;
@override final  String? time;
@override@JsonKey() final  bool recurring;
@override final  String? content;
@override final  String? status;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskResponseModelCopyWith<_TaskResponseModel> get copyWith => __$TaskResponseModelCopyWithImpl<_TaskResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskResponseModel&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,time,recurring,content,status);

@override
String toString() {
  return 'TaskResponseModel(title: $title, date: $date, time: $time, recurring: $recurring, content: $content, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TaskResponseModelCopyWith<$Res> implements $TaskResponseModelCopyWith<$Res> {
  factory _$TaskResponseModelCopyWith(_TaskResponseModel value, $Res Function(_TaskResponseModel) _then) = __$TaskResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? date, String? time, bool recurring, String? content, String? status
});




}
/// @nodoc
class __$TaskResponseModelCopyWithImpl<$Res>
    implements _$TaskResponseModelCopyWith<$Res> {
  __$TaskResponseModelCopyWithImpl(this._self, this._then);

  final _TaskResponseModel _self;
  final $Res Function(_TaskResponseModel) _then;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? date = freezed,Object? time = freezed,Object? recurring = null,Object? content = freezed,Object? status = freezed,}) {
  return _then(_TaskResponseModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
