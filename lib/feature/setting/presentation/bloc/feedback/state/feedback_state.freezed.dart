// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedbackState {

 TextFacultatifFormz get message; EmailFacultatifFormz get email; TypeFeedback get type; FormzSubmissionStatus get status; String get errorMessage; bool get isValide;
/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackStateCopyWith<FeedbackState> get copyWith => _$FeedbackStateCopyWithImpl<FeedbackState>(this as FeedbackState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackState&&(identical(other.message, message) || other.message == message)&&(identical(other.email, email) || other.email == email)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide));
}


@override
int get hashCode => Object.hash(runtimeType,message,email,type,status,errorMessage,isValide);

@override
String toString() {
  return 'FeedbackState(message: $message, email: $email, type: $type, status: $status, errorMessage: $errorMessage, isValide: $isValide)';
}


}

/// @nodoc
abstract mixin class $FeedbackStateCopyWith<$Res>  {
  factory $FeedbackStateCopyWith(FeedbackState value, $Res Function(FeedbackState) _then) = _$FeedbackStateCopyWithImpl;
@useResult
$Res call({
 TextFacultatifFormz message, EmailFacultatifFormz email, TypeFeedback type, FormzSubmissionStatus status, String errorMessage, bool isValide
});




}
/// @nodoc
class _$FeedbackStateCopyWithImpl<$Res>
    implements $FeedbackStateCopyWith<$Res> {
  _$FeedbackStateCopyWithImpl(this._self, this._then);

  final FeedbackState _self;
  final $Res Function(FeedbackState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? email = null,Object? type = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as TextFacultatifFormz,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFacultatifFormz,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TypeFeedback,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackState].
extension FeedbackStatePatterns on FeedbackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackState value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextFacultatifFormz message,  EmailFacultatifFormz email,  TypeFeedback type,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
return $default(_that.message,_that.email,_that.type,_that.status,_that.errorMessage,_that.isValide);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextFacultatifFormz message,  EmailFacultatifFormz email,  TypeFeedback type,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)  $default,) {final _that = this;
switch (_that) {
case _FeedbackState():
return $default(_that.message,_that.email,_that.type,_that.status,_that.errorMessage,_that.isValide);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextFacultatifFormz message,  EmailFacultatifFormz email,  TypeFeedback type,  FormzSubmissionStatus status,  String errorMessage,  bool isValide)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
return $default(_that.message,_that.email,_that.type,_that.status,_that.errorMessage,_that.isValide);case _:
  return null;

}
}

}

/// @nodoc


class _FeedbackState implements FeedbackState {
   _FeedbackState({required this.message, required this.email, required this.type, required this.status, required this.errorMessage, required this.isValide});
  

@override final  TextFacultatifFormz message;
@override final  EmailFacultatifFormz email;
@override final  TypeFeedback type;
@override final  FormzSubmissionStatus status;
@override final  String errorMessage;
@override final  bool isValide;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackStateCopyWith<_FeedbackState> get copyWith => __$FeedbackStateCopyWithImpl<_FeedbackState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackState&&(identical(other.message, message) || other.message == message)&&(identical(other.email, email) || other.email == email)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide));
}


@override
int get hashCode => Object.hash(runtimeType,message,email,type,status,errorMessage,isValide);

@override
String toString() {
  return 'FeedbackState(message: $message, email: $email, type: $type, status: $status, errorMessage: $errorMessage, isValide: $isValide)';
}


}

/// @nodoc
abstract mixin class _$FeedbackStateCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory _$FeedbackStateCopyWith(_FeedbackState value, $Res Function(_FeedbackState) _then) = __$FeedbackStateCopyWithImpl;
@override @useResult
$Res call({
 TextFacultatifFormz message, EmailFacultatifFormz email, TypeFeedback type, FormzSubmissionStatus status, String errorMessage, bool isValide
});




}
/// @nodoc
class __$FeedbackStateCopyWithImpl<$Res>
    implements _$FeedbackStateCopyWith<$Res> {
  __$FeedbackStateCopyWithImpl(this._self, this._then);

  final _FeedbackState _self;
  final $Res Function(_FeedbackState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? email = null,Object? type = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,}) {
  return _then(_FeedbackState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as TextFacultatifFormz,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFacultatifFormz,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TypeFeedback,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
