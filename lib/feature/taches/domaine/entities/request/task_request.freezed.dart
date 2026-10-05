// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestNotParams {

 String get id;
/// Create a copy of RequestNotParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestNotParamsCopyWith<RequestNotParams> get copyWith => _$RequestNotParamsCopyWithImpl<RequestNotParams>(this as RequestNotParams, _$identity);

  /// Serializes this RequestNotParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestNotParams&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'RequestNotParams(id: $id)';
}


}

/// @nodoc
abstract mixin class $RequestNotParamsCopyWith<$Res>  {
  factory $RequestNotParamsCopyWith(RequestNotParams value, $Res Function(RequestNotParams) _then) = _$RequestNotParamsCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$RequestNotParamsCopyWithImpl<$Res>
    implements $RequestNotParamsCopyWith<$Res> {
  _$RequestNotParamsCopyWithImpl(this._self, this._then);

  final RequestNotParams _self;
  final $Res Function(RequestNotParams) _then;

/// Create a copy of RequestNotParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestNotParams].
extension RequestNotParamsPatterns on RequestNotParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestNotParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestNotParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestNotParams value)  $default,){
final _that = this;
switch (_that) {
case _RequestNotParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestNotParams value)?  $default,){
final _that = this;
switch (_that) {
case _RequestNotParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestNotParams() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _RequestNotParams():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _RequestNotParams() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestNotParams implements RequestNotParams {
   _RequestNotParams({this.id = ""});
  factory _RequestNotParams.fromJson(Map<String, dynamic> json) => _$RequestNotParamsFromJson(json);

@override@JsonKey() final  String id;

/// Create a copy of RequestNotParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestNotParamsCopyWith<_RequestNotParams> get copyWith => __$RequestNotParamsCopyWithImpl<_RequestNotParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestNotParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestNotParams&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'RequestNotParams(id: $id)';
}


}

/// @nodoc
abstract mixin class _$RequestNotParamsCopyWith<$Res> implements $RequestNotParamsCopyWith<$Res> {
  factory _$RequestNotParamsCopyWith(_RequestNotParams value, $Res Function(_RequestNotParams) _then) = __$RequestNotParamsCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$RequestNotParamsCopyWithImpl<$Res>
    implements _$RequestNotParamsCopyWith<$Res> {
  __$RequestNotParamsCopyWithImpl(this._self, this._then);

  final _RequestNotParams _self;
  final $Res Function(_RequestNotParams) _then;

/// Create a copy of RequestNotParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_RequestNotParams(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
