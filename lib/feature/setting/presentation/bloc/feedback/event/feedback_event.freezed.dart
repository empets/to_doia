// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedbackEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent()';
}


}

/// @nodoc
class $FeedbackEventCopyWith<$Res>  {
$FeedbackEventCopyWith(FeedbackEvent _, $Res Function(FeedbackEvent) __);
}


/// Adds pattern-matching-related methods to [FeedbackEvent].
extension FeedbackEventPatterns on FeedbackEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MessageChangedFeedbackEvent value)?  messageChanged,TResult Function( EmailChangedFeedbackEvent value)?  emailChanged,TResult Function( TypeChangedFeedbackEvent value)?  typeChanged,TResult Function( SubmittedFeedbackEvent value)?  submitted,TResult Function( ReinitialiseFeedbackEvent value)?  reinitialise,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent() when messageChanged != null:
return messageChanged(_that);case EmailChangedFeedbackEvent() when emailChanged != null:
return emailChanged(_that);case TypeChangedFeedbackEvent() when typeChanged != null:
return typeChanged(_that);case SubmittedFeedbackEvent() when submitted != null:
return submitted(_that);case ReinitialiseFeedbackEvent() when reinitialise != null:
return reinitialise(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MessageChangedFeedbackEvent value)  messageChanged,required TResult Function( EmailChangedFeedbackEvent value)  emailChanged,required TResult Function( TypeChangedFeedbackEvent value)  typeChanged,required TResult Function( SubmittedFeedbackEvent value)  submitted,required TResult Function( ReinitialiseFeedbackEvent value)  reinitialise,}){
final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent():
return messageChanged(_that);case EmailChangedFeedbackEvent():
return emailChanged(_that);case TypeChangedFeedbackEvent():
return typeChanged(_that);case SubmittedFeedbackEvent():
return submitted(_that);case ReinitialiseFeedbackEvent():
return reinitialise(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MessageChangedFeedbackEvent value)?  messageChanged,TResult? Function( EmailChangedFeedbackEvent value)?  emailChanged,TResult? Function( TypeChangedFeedbackEvent value)?  typeChanged,TResult? Function( SubmittedFeedbackEvent value)?  submitted,TResult? Function( ReinitialiseFeedbackEvent value)?  reinitialise,}){
final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent() when messageChanged != null:
return messageChanged(_that);case EmailChangedFeedbackEvent() when emailChanged != null:
return emailChanged(_that);case TypeChangedFeedbackEvent() when typeChanged != null:
return typeChanged(_that);case SubmittedFeedbackEvent() when submitted != null:
return submitted(_that);case ReinitialiseFeedbackEvent() when reinitialise != null:
return reinitialise(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  messageChanged,TResult Function( String email)?  emailChanged,TResult Function( TypeFeedback type)?  typeChanged,TResult Function()?  submitted,TResult Function()?  reinitialise,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent() when messageChanged != null:
return messageChanged(_that.message);case EmailChangedFeedbackEvent() when emailChanged != null:
return emailChanged(_that.email);case TypeChangedFeedbackEvent() when typeChanged != null:
return typeChanged(_that.type);case SubmittedFeedbackEvent() when submitted != null:
return submitted();case ReinitialiseFeedbackEvent() when reinitialise != null:
return reinitialise();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  messageChanged,required TResult Function( String email)  emailChanged,required TResult Function( TypeFeedback type)  typeChanged,required TResult Function()  submitted,required TResult Function()  reinitialise,}) {final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent():
return messageChanged(_that.message);case EmailChangedFeedbackEvent():
return emailChanged(_that.email);case TypeChangedFeedbackEvent():
return typeChanged(_that.type);case SubmittedFeedbackEvent():
return submitted();case ReinitialiseFeedbackEvent():
return reinitialise();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  messageChanged,TResult? Function( String email)?  emailChanged,TResult? Function( TypeFeedback type)?  typeChanged,TResult? Function()?  submitted,TResult? Function()?  reinitialise,}) {final _that = this;
switch (_that) {
case MessageChangedFeedbackEvent() when messageChanged != null:
return messageChanged(_that.message);case EmailChangedFeedbackEvent() when emailChanged != null:
return emailChanged(_that.email);case TypeChangedFeedbackEvent() when typeChanged != null:
return typeChanged(_that.type);case SubmittedFeedbackEvent() when submitted != null:
return submitted();case ReinitialiseFeedbackEvent() when reinitialise != null:
return reinitialise();case _:
  return null;

}
}

}

/// @nodoc


class MessageChangedFeedbackEvent implements FeedbackEvent {
   MessageChangedFeedbackEvent(this.message);
  

 final  String message;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageChangedFeedbackEventCopyWith<MessageChangedFeedbackEvent> get copyWith => _$MessageChangedFeedbackEventCopyWithImpl<MessageChangedFeedbackEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageChangedFeedbackEvent&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedbackEvent.messageChanged(message: $message)';
}


}

/// @nodoc
abstract mixin class $MessageChangedFeedbackEventCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $MessageChangedFeedbackEventCopyWith(MessageChangedFeedbackEvent value, $Res Function(MessageChangedFeedbackEvent) _then) = _$MessageChangedFeedbackEventCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MessageChangedFeedbackEventCopyWithImpl<$Res>
    implements $MessageChangedFeedbackEventCopyWith<$Res> {
  _$MessageChangedFeedbackEventCopyWithImpl(this._self, this._then);

  final MessageChangedFeedbackEvent _self;
  final $Res Function(MessageChangedFeedbackEvent) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MessageChangedFeedbackEvent(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailChangedFeedbackEvent implements FeedbackEvent {
   EmailChangedFeedbackEvent(this.email);
  

 final  String email;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailChangedFeedbackEventCopyWith<EmailChangedFeedbackEvent> get copyWith => _$EmailChangedFeedbackEventCopyWithImpl<EmailChangedFeedbackEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailChangedFeedbackEvent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'FeedbackEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $EmailChangedFeedbackEventCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $EmailChangedFeedbackEventCopyWith(EmailChangedFeedbackEvent value, $Res Function(EmailChangedFeedbackEvent) _then) = _$EmailChangedFeedbackEventCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$EmailChangedFeedbackEventCopyWithImpl<$Res>
    implements $EmailChangedFeedbackEventCopyWith<$Res> {
  _$EmailChangedFeedbackEventCopyWithImpl(this._self, this._then);

  final EmailChangedFeedbackEvent _self;
  final $Res Function(EmailChangedFeedbackEvent) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(EmailChangedFeedbackEvent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TypeChangedFeedbackEvent implements FeedbackEvent {
   TypeChangedFeedbackEvent(this.type);
  

 final  TypeFeedback type;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypeChangedFeedbackEventCopyWith<TypeChangedFeedbackEvent> get copyWith => _$TypeChangedFeedbackEventCopyWithImpl<TypeChangedFeedbackEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypeChangedFeedbackEvent&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'FeedbackEvent.typeChanged(type: $type)';
}


}

/// @nodoc
abstract mixin class $TypeChangedFeedbackEventCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $TypeChangedFeedbackEventCopyWith(TypeChangedFeedbackEvent value, $Res Function(TypeChangedFeedbackEvent) _then) = _$TypeChangedFeedbackEventCopyWithImpl;
@useResult
$Res call({
 TypeFeedback type
});




}
/// @nodoc
class _$TypeChangedFeedbackEventCopyWithImpl<$Res>
    implements $TypeChangedFeedbackEventCopyWith<$Res> {
  _$TypeChangedFeedbackEventCopyWithImpl(this._self, this._then);

  final TypeChangedFeedbackEvent _self;
  final $Res Function(TypeChangedFeedbackEvent) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(TypeChangedFeedbackEvent(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TypeFeedback,
  ));
}


}

/// @nodoc


class SubmittedFeedbackEvent implements FeedbackEvent {
   SubmittedFeedbackEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittedFeedbackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent.submitted()';
}


}




/// @nodoc


class ReinitialiseFeedbackEvent implements FeedbackEvent {
   ReinitialiseFeedbackEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReinitialiseFeedbackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent.reinitialise()';
}


}




// dart format on
