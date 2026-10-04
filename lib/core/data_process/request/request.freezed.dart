// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Request<T> {

 Map<dynamic, dynamic> get data; String get user; String get serviceLibelle;
/// Create a copy of Request
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestCopyWith<T, Request<T>> get copyWith => _$RequestCopyWithImpl<T, Request<T>>(this as Request<T>, _$identity);

  /// Serializes this Request to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Request<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.user, user) || other.user == user)&&(identical(other.serviceLibelle, serviceLibelle) || other.serviceLibelle == serviceLibelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),user,serviceLibelle);

@override
String toString() {
  return 'Request<$T>(data: $data, user: $user, serviceLibelle: $serviceLibelle)';
}


}

/// @nodoc
abstract mixin class $RequestCopyWith<T,$Res>  {
  factory $RequestCopyWith(Request<T> value, $Res Function(Request<T>) _then) = _$RequestCopyWithImpl;
@useResult
$Res call({
 Map<dynamic, dynamic> data, String user, String serviceLibelle
});




}
/// @nodoc
class _$RequestCopyWithImpl<T,$Res>
    implements $RequestCopyWith<T, $Res> {
  _$RequestCopyWithImpl(this._self, this._then);

  final Request<T> _self;
  final $Res Function(Request<T>) _then;

/// Create a copy of Request
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? user = null,Object? serviceLibelle = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<dynamic, dynamic>,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String,serviceLibelle: null == serviceLibelle ? _self.serviceLibelle : serviceLibelle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Request].
extension RequestPatterns<T> on Request<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Request<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Request() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Request<T> value)  $default,){
final _that = this;
switch (_that) {
case _Request():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Request<T> value)?  $default,){
final _that = this;
switch (_that) {
case _Request() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<dynamic, dynamic> data,  String user,  String serviceLibelle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Request() when $default != null:
return $default(_that.data,_that.user,_that.serviceLibelle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<dynamic, dynamic> data,  String user,  String serviceLibelle)  $default,) {final _that = this;
switch (_that) {
case _Request():
return $default(_that.data,_that.user,_that.serviceLibelle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<dynamic, dynamic> data,  String user,  String serviceLibelle)?  $default,) {final _that = this;
switch (_that) {
case _Request() when $default != null:
return $default(_that.data,_that.user,_that.serviceLibelle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Request<T> implements Request<T> {
   _Request({required final  Map<dynamic, dynamic> data, required this.user, required this.serviceLibelle}): _data = data;
  factory _Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

 final  Map<dynamic, dynamic> _data;
@override Map<dynamic, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override final  String user;
@override final  String serviceLibelle;

/// Create a copy of Request
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestCopyWith<T, _Request<T>> get copyWith => __$RequestCopyWithImpl<T, _Request<T>>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestToJson<T>(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Request<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.user, user) || other.user == user)&&(identical(other.serviceLibelle, serviceLibelle) || other.serviceLibelle == serviceLibelle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),user,serviceLibelle);

@override
String toString() {
  return 'Request<$T>(data: $data, user: $user, serviceLibelle: $serviceLibelle)';
}


}

/// @nodoc
abstract mixin class _$RequestCopyWith<T,$Res> implements $RequestCopyWith<T, $Res> {
  factory _$RequestCopyWith(_Request<T> value, $Res Function(_Request<T>) _then) = __$RequestCopyWithImpl;
@override @useResult
$Res call({
 Map<dynamic, dynamic> data, String user, String serviceLibelle
});




}
/// @nodoc
class __$RequestCopyWithImpl<T,$Res>
    implements _$RequestCopyWith<T, $Res> {
  __$RequestCopyWithImpl(this._self, this._then);

  final _Request<T> _self;
  final $Res Function(_Request<T>) _then;

/// Create a copy of Request
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? user = null,Object? serviceLibelle = null,}) {
  return _then(_Request<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<dynamic, dynamic>,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String,serviceLibelle: null == serviceLibelle ? _self.serviceLibelle : serviceLibelle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
