// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiState<$T>()';
}


}

/// @nodoc
class $ApiStateCopyWith<T,$Res>  {
$ApiStateCopyWith(ApiState<T> _, $Res Function(ApiState<T>) __);
}


/// Adds pattern-matching-related methods to [ApiState].
extension ApiStatePatterns<T> on ApiState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FailedState<T> value)?  failed,TResult Function( SuccessState<T> value)?  success,TResult Function( LoadState<T> value)?  load,TResult Function( InitialState<T> value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FailedState() when failed != null:
return failed(_that);case SuccessState() when success != null:
return success(_that);case LoadState() when load != null:
return load(_that);case InitialState() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FailedState<T> value)  failed,required TResult Function( SuccessState<T> value)  success,required TResult Function( LoadState<T> value)  load,required TResult Function( InitialState<T> value)  initial,}){
final _that = this;
switch (_that) {
case FailedState():
return failed(_that);case SuccessState():
return success(_that);case LoadState():
return load(_that);case InitialState():
return initial(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FailedState<T> value)?  failed,TResult? Function( SuccessState<T> value)?  success,TResult? Function( LoadState<T> value)?  load,TResult? Function( InitialState<T> value)?  initial,}){
final _that = this;
switch (_that) {
case FailedState() when failed != null:
return failed(_that);case SuccessState() when success != null:
return success(_that);case LoadState() when load != null:
return load(_that);case InitialState() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message,  Failure? errorType)?  failed,TResult Function( T data,  bool? refresh,  bool hasReachedMax,  int page,  FormzSubmissionStatus? status,  String? error)?  success,TResult Function()?  load,TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FailedState() when failed != null:
return failed(_that.message,_that.errorType);case SuccessState() when success != null:
return success(_that.data,_that.refresh,_that.hasReachedMax,_that.page,_that.status,_that.error);case LoadState() when load != null:
return load();case InitialState() when initial != null:
return initial();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message,  Failure? errorType)  failed,required TResult Function( T data,  bool? refresh,  bool hasReachedMax,  int page,  FormzSubmissionStatus? status,  String? error)  success,required TResult Function()  load,required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case FailedState():
return failed(_that.message,_that.errorType);case SuccessState():
return success(_that.data,_that.refresh,_that.hasReachedMax,_that.page,_that.status,_that.error);case LoadState():
return load();case InitialState():
return initial();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message,  Failure? errorType)?  failed,TResult? Function( T data,  bool? refresh,  bool hasReachedMax,  int page,  FormzSubmissionStatus? status,  String? error)?  success,TResult? Function()?  load,TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case FailedState() when failed != null:
return failed(_that.message,_that.errorType);case SuccessState() when success != null:
return success(_that.data,_that.refresh,_that.hasReachedMax,_that.page,_that.status,_that.error);case LoadState() when load != null:
return load();case InitialState() when initial != null:
return initial();case _:
  return null;

}
}

}

/// @nodoc


class FailedState<T> implements ApiState<T> {
  const FailedState([this.message, this.errorType]);
  

 final  String? message;
 final  Failure? errorType;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedStateCopyWith<T, FailedState<T>> get copyWith => _$FailedStateCopyWithImpl<T, FailedState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailedState<T>&&(identical(other.message, message) || other.message == message)&&(identical(other.errorType, errorType) || other.errorType == errorType));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorType);

@override
String toString() {
  return 'ApiState<$T>.failed(message: $message, errorType: $errorType)';
}


}

/// @nodoc
abstract mixin class $FailedStateCopyWith<T,$Res> implements $ApiStateCopyWith<T, $Res> {
  factory $FailedStateCopyWith(FailedState<T> value, $Res Function(FailedState<T>) _then) = _$FailedStateCopyWithImpl;
@useResult
$Res call({
 String? message, Failure? errorType
});




}
/// @nodoc
class _$FailedStateCopyWithImpl<T,$Res>
    implements $FailedStateCopyWith<T, $Res> {
  _$FailedStateCopyWithImpl(this._self, this._then);

  final FailedState<T> _self;
  final $Res Function(FailedState<T>) _then;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errorType = freezed,}) {
  return _then(FailedState<T>(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

/// @nodoc


class SuccessState<T> implements ApiState<T> {
  const SuccessState(this.data, {this.refresh, this.hasReachedMax = true, this.page = 0, this.status, this.error});
  

 final  T data;
 final  bool? refresh;
@JsonKey() final  bool hasReachedMax;
@JsonKey() final  int page;
//count
 final  FormzSubmissionStatus? status;
 final  String? error;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStateCopyWith<T, SuccessState<T>> get copyWith => _$SuccessStateCopyWithImpl<T, SuccessState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessState<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.page, page) || other.page == page)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),refresh,hasReachedMax,page,status,error);

@override
String toString() {
  return 'ApiState<$T>.success(data: $data, refresh: $refresh, hasReachedMax: $hasReachedMax, page: $page, status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $SuccessStateCopyWith<T,$Res> implements $ApiStateCopyWith<T, $Res> {
  factory $SuccessStateCopyWith(SuccessState<T> value, $Res Function(SuccessState<T>) _then) = _$SuccessStateCopyWithImpl;
@useResult
$Res call({
 T data, bool? refresh, bool hasReachedMax, int page, FormzSubmissionStatus? status, String? error
});




}
/// @nodoc
class _$SuccessStateCopyWithImpl<T,$Res>
    implements $SuccessStateCopyWith<T, $Res> {
  _$SuccessStateCopyWithImpl(this._self, this._then);

  final SuccessState<T> _self;
  final $Res Function(SuccessState<T>) _then;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? refresh = freezed,Object? hasReachedMax = null,Object? page = null,Object? status = freezed,Object? error = freezed,}) {
  return _then(SuccessState<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as bool?,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class LoadState<T> implements ApiState<T> {
  const LoadState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiState<$T>.load()';
}


}




/// @nodoc


class InitialState<T> implements ApiState<T> {
  const InitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiState<$T>.initial()';
}


}




/// @nodoc
mixin _$ApiStateOther<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiStateOther<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiStateOther<$T>()';
}


}

/// @nodoc
class $ApiStateOtherCopyWith<T,$Res>  {
$ApiStateOtherCopyWith(ApiStateOther<T> _, $Res Function(ApiStateOther<T>) __);
}


/// Adds pattern-matching-related methods to [ApiStateOther].
extension ApiStateOtherPatterns<T> on ApiStateOther<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FailedStateOther<T> value)?  failed,TResult Function( SuccessStateOther<T> value)?  success,TResult Function( LoadStateOther<T> value)?  load,TResult Function( InitialStateOther<T> value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FailedStateOther() when failed != null:
return failed(_that);case SuccessStateOther() when success != null:
return success(_that);case LoadStateOther() when load != null:
return load(_that);case InitialStateOther() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FailedStateOther<T> value)  failed,required TResult Function( SuccessStateOther<T> value)  success,required TResult Function( LoadStateOther<T> value)  load,required TResult Function( InitialStateOther<T> value)  initial,}){
final _that = this;
switch (_that) {
case FailedStateOther():
return failed(_that);case SuccessStateOther():
return success(_that);case LoadStateOther():
return load(_that);case InitialStateOther():
return initial(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FailedStateOther<T> value)?  failed,TResult? Function( SuccessStateOther<T> value)?  success,TResult? Function( LoadStateOther<T> value)?  load,TResult? Function( InitialStateOther<T> value)?  initial,}){
final _that = this;
switch (_that) {
case FailedStateOther() when failed != null:
return failed(_that);case SuccessStateOther() when success != null:
return success(_that);case LoadStateOther() when load != null:
return load(_that);case InitialStateOther() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message,  Failure? errorType)?  failed,TResult Function( T data,  bool? refresh,  FormzSubmissionStatus? status,  String? error)?  success,TResult Function()?  load,TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FailedStateOther() when failed != null:
return failed(_that.message,_that.errorType);case SuccessStateOther() when success != null:
return success(_that.data,_that.refresh,_that.status,_that.error);case LoadStateOther() when load != null:
return load();case InitialStateOther() when initial != null:
return initial();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message,  Failure? errorType)  failed,required TResult Function( T data,  bool? refresh,  FormzSubmissionStatus? status,  String? error)  success,required TResult Function()  load,required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case FailedStateOther():
return failed(_that.message,_that.errorType);case SuccessStateOther():
return success(_that.data,_that.refresh,_that.status,_that.error);case LoadStateOther():
return load();case InitialStateOther():
return initial();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message,  Failure? errorType)?  failed,TResult? Function( T data,  bool? refresh,  FormzSubmissionStatus? status,  String? error)?  success,TResult? Function()?  load,TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case FailedStateOther() when failed != null:
return failed(_that.message,_that.errorType);case SuccessStateOther() when success != null:
return success(_that.data,_that.refresh,_that.status,_that.error);case LoadStateOther() when load != null:
return load();case InitialStateOther() when initial != null:
return initial();case _:
  return null;

}
}

}

/// @nodoc


class FailedStateOther<T> implements ApiStateOther<T> {
  const FailedStateOther([this.message, this.errorType]);
  

 final  String? message;
 final  Failure? errorType;

/// Create a copy of ApiStateOther
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedStateOtherCopyWith<T, FailedStateOther<T>> get copyWith => _$FailedStateOtherCopyWithImpl<T, FailedStateOther<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailedStateOther<T>&&(identical(other.message, message) || other.message == message)&&(identical(other.errorType, errorType) || other.errorType == errorType));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorType);

@override
String toString() {
  return 'ApiStateOther<$T>.failed(message: $message, errorType: $errorType)';
}


}

/// @nodoc
abstract mixin class $FailedStateOtherCopyWith<T,$Res> implements $ApiStateOtherCopyWith<T, $Res> {
  factory $FailedStateOtherCopyWith(FailedStateOther<T> value, $Res Function(FailedStateOther<T>) _then) = _$FailedStateOtherCopyWithImpl;
@useResult
$Res call({
 String? message, Failure? errorType
});




}
/// @nodoc
class _$FailedStateOtherCopyWithImpl<T,$Res>
    implements $FailedStateOtherCopyWith<T, $Res> {
  _$FailedStateOtherCopyWithImpl(this._self, this._then);

  final FailedStateOther<T> _self;
  final $Res Function(FailedStateOther<T>) _then;

/// Create a copy of ApiStateOther
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errorType = freezed,}) {
  return _then(FailedStateOther<T>(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

/// @nodoc


class SuccessStateOther<T> implements ApiStateOther<T> {
  const SuccessStateOther(this.data, {this.refresh, this.status, this.error});
  

 final  T data;
 final  bool? refresh;
 final  FormzSubmissionStatus? status;
 final  String? error;

/// Create a copy of ApiStateOther
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStateOtherCopyWith<T, SuccessStateOther<T>> get copyWith => _$SuccessStateOtherCopyWithImpl<T, SuccessStateOther<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStateOther<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),refresh,status,error);

@override
String toString() {
  return 'ApiStateOther<$T>.success(data: $data, refresh: $refresh, status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $SuccessStateOtherCopyWith<T,$Res> implements $ApiStateOtherCopyWith<T, $Res> {
  factory $SuccessStateOtherCopyWith(SuccessStateOther<T> value, $Res Function(SuccessStateOther<T>) _then) = _$SuccessStateOtherCopyWithImpl;
@useResult
$Res call({
 T data, bool? refresh, FormzSubmissionStatus? status, String? error
});




}
/// @nodoc
class _$SuccessStateOtherCopyWithImpl<T,$Res>
    implements $SuccessStateOtherCopyWith<T, $Res> {
  _$SuccessStateOtherCopyWithImpl(this._self, this._then);

  final SuccessStateOther<T> _self;
  final $Res Function(SuccessStateOther<T>) _then;

/// Create a copy of ApiStateOther
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? refresh = freezed,Object? status = freezed,Object? error = freezed,}) {
  return _then(SuccessStateOther<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class LoadStateOther<T> implements ApiStateOther<T> {
  const LoadStateOther();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadStateOther<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiStateOther<$T>.load()';
}


}




/// @nodoc


class InitialStateOther<T> implements ApiStateOther<T> {
  const InitialStateOther();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialStateOther<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiStateOther<$T>.initial()';
}


}




// dart format on
