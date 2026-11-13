// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NomChangedAuthEvent value)?  nomChanged,TResult Function( EmailChangedAuthEvent value)?  emailChanged,TResult Function( MotDePasseChangedAuthEvent value)?  motDePasseChanged,TResult Function( ConfirmationChangedAuthEvent value)?  confirmationChanged,TResult Function( ModeChangedAuthEvent value)?  modeChanged,TResult Function( SessionVerifieeAuthEvent value)?  sessionVerifiee,TResult Function( SoumisAuthEvent value)?  soumis,TResult Function( DeconnexionDemandeeAuthEvent value)?  deconnexionDemandee,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NomChangedAuthEvent() when nomChanged != null:
return nomChanged(_that);case EmailChangedAuthEvent() when emailChanged != null:
return emailChanged(_that);case MotDePasseChangedAuthEvent() when motDePasseChanged != null:
return motDePasseChanged(_that);case ConfirmationChangedAuthEvent() when confirmationChanged != null:
return confirmationChanged(_that);case ModeChangedAuthEvent() when modeChanged != null:
return modeChanged(_that);case SessionVerifieeAuthEvent() when sessionVerifiee != null:
return sessionVerifiee(_that);case SoumisAuthEvent() when soumis != null:
return soumis(_that);case DeconnexionDemandeeAuthEvent() when deconnexionDemandee != null:
return deconnexionDemandee(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NomChangedAuthEvent value)  nomChanged,required TResult Function( EmailChangedAuthEvent value)  emailChanged,required TResult Function( MotDePasseChangedAuthEvent value)  motDePasseChanged,required TResult Function( ConfirmationChangedAuthEvent value)  confirmationChanged,required TResult Function( ModeChangedAuthEvent value)  modeChanged,required TResult Function( SessionVerifieeAuthEvent value)  sessionVerifiee,required TResult Function( SoumisAuthEvent value)  soumis,required TResult Function( DeconnexionDemandeeAuthEvent value)  deconnexionDemandee,}){
final _that = this;
switch (_that) {
case NomChangedAuthEvent():
return nomChanged(_that);case EmailChangedAuthEvent():
return emailChanged(_that);case MotDePasseChangedAuthEvent():
return motDePasseChanged(_that);case ConfirmationChangedAuthEvent():
return confirmationChanged(_that);case ModeChangedAuthEvent():
return modeChanged(_that);case SessionVerifieeAuthEvent():
return sessionVerifiee(_that);case SoumisAuthEvent():
return soumis(_that);case DeconnexionDemandeeAuthEvent():
return deconnexionDemandee(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NomChangedAuthEvent value)?  nomChanged,TResult? Function( EmailChangedAuthEvent value)?  emailChanged,TResult? Function( MotDePasseChangedAuthEvent value)?  motDePasseChanged,TResult? Function( ConfirmationChangedAuthEvent value)?  confirmationChanged,TResult? Function( ModeChangedAuthEvent value)?  modeChanged,TResult? Function( SessionVerifieeAuthEvent value)?  sessionVerifiee,TResult? Function( SoumisAuthEvent value)?  soumis,TResult? Function( DeconnexionDemandeeAuthEvent value)?  deconnexionDemandee,}){
final _that = this;
switch (_that) {
case NomChangedAuthEvent() when nomChanged != null:
return nomChanged(_that);case EmailChangedAuthEvent() when emailChanged != null:
return emailChanged(_that);case MotDePasseChangedAuthEvent() when motDePasseChanged != null:
return motDePasseChanged(_that);case ConfirmationChangedAuthEvent() when confirmationChanged != null:
return confirmationChanged(_that);case ModeChangedAuthEvent() when modeChanged != null:
return modeChanged(_that);case SessionVerifieeAuthEvent() when sessionVerifiee != null:
return sessionVerifiee(_that);case SoumisAuthEvent() when soumis != null:
return soumis(_that);case DeconnexionDemandeeAuthEvent() when deconnexionDemandee != null:
return deconnexionDemandee(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nom)?  nomChanged,TResult Function( String email)?  emailChanged,TResult Function( String motDePasse)?  motDePasseChanged,TResult Function( String confirmation)?  confirmationChanged,TResult Function( ModeAuthentification mode)?  modeChanged,TResult Function()?  sessionVerifiee,TResult Function()?  soumis,TResult Function()?  deconnexionDemandee,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NomChangedAuthEvent() when nomChanged != null:
return nomChanged(_that.nom);case EmailChangedAuthEvent() when emailChanged != null:
return emailChanged(_that.email);case MotDePasseChangedAuthEvent() when motDePasseChanged != null:
return motDePasseChanged(_that.motDePasse);case ConfirmationChangedAuthEvent() when confirmationChanged != null:
return confirmationChanged(_that.confirmation);case ModeChangedAuthEvent() when modeChanged != null:
return modeChanged(_that.mode);case SessionVerifieeAuthEvent() when sessionVerifiee != null:
return sessionVerifiee();case SoumisAuthEvent() when soumis != null:
return soumis();case DeconnexionDemandeeAuthEvent() when deconnexionDemandee != null:
return deconnexionDemandee();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nom)  nomChanged,required TResult Function( String email)  emailChanged,required TResult Function( String motDePasse)  motDePasseChanged,required TResult Function( String confirmation)  confirmationChanged,required TResult Function( ModeAuthentification mode)  modeChanged,required TResult Function()  sessionVerifiee,required TResult Function()  soumis,required TResult Function()  deconnexionDemandee,}) {final _that = this;
switch (_that) {
case NomChangedAuthEvent():
return nomChanged(_that.nom);case EmailChangedAuthEvent():
return emailChanged(_that.email);case MotDePasseChangedAuthEvent():
return motDePasseChanged(_that.motDePasse);case ConfirmationChangedAuthEvent():
return confirmationChanged(_that.confirmation);case ModeChangedAuthEvent():
return modeChanged(_that.mode);case SessionVerifieeAuthEvent():
return sessionVerifiee();case SoumisAuthEvent():
return soumis();case DeconnexionDemandeeAuthEvent():
return deconnexionDemandee();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nom)?  nomChanged,TResult? Function( String email)?  emailChanged,TResult? Function( String motDePasse)?  motDePasseChanged,TResult? Function( String confirmation)?  confirmationChanged,TResult? Function( ModeAuthentification mode)?  modeChanged,TResult? Function()?  sessionVerifiee,TResult? Function()?  soumis,TResult? Function()?  deconnexionDemandee,}) {final _that = this;
switch (_that) {
case NomChangedAuthEvent() when nomChanged != null:
return nomChanged(_that.nom);case EmailChangedAuthEvent() when emailChanged != null:
return emailChanged(_that.email);case MotDePasseChangedAuthEvent() when motDePasseChanged != null:
return motDePasseChanged(_that.motDePasse);case ConfirmationChangedAuthEvent() when confirmationChanged != null:
return confirmationChanged(_that.confirmation);case ModeChangedAuthEvent() when modeChanged != null:
return modeChanged(_that.mode);case SessionVerifieeAuthEvent() when sessionVerifiee != null:
return sessionVerifiee();case SoumisAuthEvent() when soumis != null:
return soumis();case DeconnexionDemandeeAuthEvent() when deconnexionDemandee != null:
return deconnexionDemandee();case _:
  return null;

}
}

}

/// @nodoc


class NomChangedAuthEvent implements AuthEvent {
   NomChangedAuthEvent(this.nom);
  

 final  String nom;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NomChangedAuthEventCopyWith<NomChangedAuthEvent> get copyWith => _$NomChangedAuthEventCopyWithImpl<NomChangedAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NomChangedAuthEvent&&(identical(other.nom, nom) || other.nom == nom));
}


@override
int get hashCode => Object.hash(runtimeType,nom);

@override
String toString() {
  return 'AuthEvent.nomChanged(nom: $nom)';
}


}

/// @nodoc
abstract mixin class $NomChangedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $NomChangedAuthEventCopyWith(NomChangedAuthEvent value, $Res Function(NomChangedAuthEvent) _then) = _$NomChangedAuthEventCopyWithImpl;
@useResult
$Res call({
 String nom
});




}
/// @nodoc
class _$NomChangedAuthEventCopyWithImpl<$Res>
    implements $NomChangedAuthEventCopyWith<$Res> {
  _$NomChangedAuthEventCopyWithImpl(this._self, this._then);

  final NomChangedAuthEvent _self;
  final $Res Function(NomChangedAuthEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nom = null,}) {
  return _then(NomChangedAuthEvent(
null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailChangedAuthEvent implements AuthEvent {
   EmailChangedAuthEvent(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailChangedAuthEventCopyWith<EmailChangedAuthEvent> get copyWith => _$EmailChangedAuthEventCopyWithImpl<EmailChangedAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailChangedAuthEvent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $EmailChangedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $EmailChangedAuthEventCopyWith(EmailChangedAuthEvent value, $Res Function(EmailChangedAuthEvent) _then) = _$EmailChangedAuthEventCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$EmailChangedAuthEventCopyWithImpl<$Res>
    implements $EmailChangedAuthEventCopyWith<$Res> {
  _$EmailChangedAuthEventCopyWithImpl(this._self, this._then);

  final EmailChangedAuthEvent _self;
  final $Res Function(EmailChangedAuthEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(EmailChangedAuthEvent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MotDePasseChangedAuthEvent implements AuthEvent {
   MotDePasseChangedAuthEvent(this.motDePasse);
  

 final  String motDePasse;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotDePasseChangedAuthEventCopyWith<MotDePasseChangedAuthEvent> get copyWith => _$MotDePasseChangedAuthEventCopyWithImpl<MotDePasseChangedAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotDePasseChangedAuthEvent&&(identical(other.motDePasse, motDePasse) || other.motDePasse == motDePasse));
}


@override
int get hashCode => Object.hash(runtimeType,motDePasse);

@override
String toString() {
  return 'AuthEvent.motDePasseChanged(motDePasse: $motDePasse)';
}


}

/// @nodoc
abstract mixin class $MotDePasseChangedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $MotDePasseChangedAuthEventCopyWith(MotDePasseChangedAuthEvent value, $Res Function(MotDePasseChangedAuthEvent) _then) = _$MotDePasseChangedAuthEventCopyWithImpl;
@useResult
$Res call({
 String motDePasse
});




}
/// @nodoc
class _$MotDePasseChangedAuthEventCopyWithImpl<$Res>
    implements $MotDePasseChangedAuthEventCopyWith<$Res> {
  _$MotDePasseChangedAuthEventCopyWithImpl(this._self, this._then);

  final MotDePasseChangedAuthEvent _self;
  final $Res Function(MotDePasseChangedAuthEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? motDePasse = null,}) {
  return _then(MotDePasseChangedAuthEvent(
null == motDePasse ? _self.motDePasse : motDePasse // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ConfirmationChangedAuthEvent implements AuthEvent {
   ConfirmationChangedAuthEvent(this.confirmation);
  

 final  String confirmation;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmationChangedAuthEventCopyWith<ConfirmationChangedAuthEvent> get copyWith => _$ConfirmationChangedAuthEventCopyWithImpl<ConfirmationChangedAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmationChangedAuthEvent&&(identical(other.confirmation, confirmation) || other.confirmation == confirmation));
}


@override
int get hashCode => Object.hash(runtimeType,confirmation);

@override
String toString() {
  return 'AuthEvent.confirmationChanged(confirmation: $confirmation)';
}


}

/// @nodoc
abstract mixin class $ConfirmationChangedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ConfirmationChangedAuthEventCopyWith(ConfirmationChangedAuthEvent value, $Res Function(ConfirmationChangedAuthEvent) _then) = _$ConfirmationChangedAuthEventCopyWithImpl;
@useResult
$Res call({
 String confirmation
});




}
/// @nodoc
class _$ConfirmationChangedAuthEventCopyWithImpl<$Res>
    implements $ConfirmationChangedAuthEventCopyWith<$Res> {
  _$ConfirmationChangedAuthEventCopyWithImpl(this._self, this._then);

  final ConfirmationChangedAuthEvent _self;
  final $Res Function(ConfirmationChangedAuthEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? confirmation = null,}) {
  return _then(ConfirmationChangedAuthEvent(
null == confirmation ? _self.confirmation : confirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ModeChangedAuthEvent implements AuthEvent {
   ModeChangedAuthEvent(this.mode);
  

 final  ModeAuthentification mode;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModeChangedAuthEventCopyWith<ModeChangedAuthEvent> get copyWith => _$ModeChangedAuthEventCopyWithImpl<ModeChangedAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModeChangedAuthEvent&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ModeChangedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ModeChangedAuthEventCopyWith(ModeChangedAuthEvent value, $Res Function(ModeChangedAuthEvent) _then) = _$ModeChangedAuthEventCopyWithImpl;
@useResult
$Res call({
 ModeAuthentification mode
});




}
/// @nodoc
class _$ModeChangedAuthEventCopyWithImpl<$Res>
    implements $ModeChangedAuthEventCopyWith<$Res> {
  _$ModeChangedAuthEventCopyWithImpl(this._self, this._then);

  final ModeChangedAuthEvent _self;
  final $Res Function(ModeChangedAuthEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ModeChangedAuthEvent(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ModeAuthentification,
  ));
}


}

/// @nodoc


class SessionVerifieeAuthEvent implements AuthEvent {
   SessionVerifieeAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionVerifieeAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.sessionVerifiee()';
}


}




/// @nodoc


class SoumisAuthEvent implements AuthEvent {
   SoumisAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoumisAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.soumis()';
}


}




/// @nodoc


class DeconnexionDemandeeAuthEvent implements AuthEvent {
   DeconnexionDemandeeAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeconnexionDemandeeAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.deconnexionDemandee()';
}


}




// dart format on
