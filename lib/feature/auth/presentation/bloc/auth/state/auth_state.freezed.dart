// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 TextFormz get nom; EmailFormz get email; PasswordTextFormz get motDePasse; ConfirmationMotDePasseFormz get confirmation; ModeAuthentification get mode; FormzSubmissionStatus get status; String get errorMessage; bool get isValide; UtilisateurEntite? get utilisateur; bool get sessionVerifiee;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.email, email) || other.email == email)&&(identical(other.motDePasse, motDePasse) || other.motDePasse == motDePasse)&&(identical(other.confirmation, confirmation) || other.confirmation == confirmation)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide)&&(identical(other.utilisateur, utilisateur) || other.utilisateur == utilisateur)&&(identical(other.sessionVerifiee, sessionVerifiee) || other.sessionVerifiee == sessionVerifiee));
}


@override
int get hashCode => Object.hash(runtimeType,nom,email,motDePasse,confirmation,mode,status,errorMessage,isValide,utilisateur,sessionVerifiee);

@override
String toString() {
  return 'AuthState(nom: $nom, email: $email, motDePasse: $motDePasse, confirmation: $confirmation, mode: $mode, status: $status, errorMessage: $errorMessage, isValide: $isValide, utilisateur: $utilisateur, sessionVerifiee: $sessionVerifiee)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 TextFormz nom, EmailFormz email, PasswordTextFormz motDePasse, ConfirmationMotDePasseFormz confirmation, ModeAuthentification mode, FormzSubmissionStatus status, String errorMessage, bool isValide, UtilisateurEntite? utilisateur, bool sessionVerifiee
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nom = null,Object? email = null,Object? motDePasse = null,Object? confirmation = null,Object? mode = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,Object? utilisateur = freezed,Object? sessionVerifiee = null,}) {
  return _then(_self.copyWith(
nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as TextFormz,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,motDePasse: null == motDePasse ? _self.motDePasse : motDePasse // ignore: cast_nullable_to_non_nullable
as PasswordTextFormz,confirmation: null == confirmation ? _self.confirmation : confirmation // ignore: cast_nullable_to_non_nullable
as ConfirmationMotDePasseFormz,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ModeAuthentification,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,utilisateur: freezed == utilisateur ? _self.utilisateur : utilisateur // ignore: cast_nullable_to_non_nullable
as UtilisateurEntite?,sessionVerifiee: null == sessionVerifiee ? _self.sessionVerifiee : sessionVerifiee // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextFormz nom,  EmailFormz email,  PasswordTextFormz motDePasse,  ConfirmationMotDePasseFormz confirmation,  ModeAuthentification mode,  FormzSubmissionStatus status,  String errorMessage,  bool isValide,  UtilisateurEntite? utilisateur,  bool sessionVerifiee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.nom,_that.email,_that.motDePasse,_that.confirmation,_that.mode,_that.status,_that.errorMessage,_that.isValide,_that.utilisateur,_that.sessionVerifiee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextFormz nom,  EmailFormz email,  PasswordTextFormz motDePasse,  ConfirmationMotDePasseFormz confirmation,  ModeAuthentification mode,  FormzSubmissionStatus status,  String errorMessage,  bool isValide,  UtilisateurEntite? utilisateur,  bool sessionVerifiee)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.nom,_that.email,_that.motDePasse,_that.confirmation,_that.mode,_that.status,_that.errorMessage,_that.isValide,_that.utilisateur,_that.sessionVerifiee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextFormz nom,  EmailFormz email,  PasswordTextFormz motDePasse,  ConfirmationMotDePasseFormz confirmation,  ModeAuthentification mode,  FormzSubmissionStatus status,  String errorMessage,  bool isValide,  UtilisateurEntite? utilisateur,  bool sessionVerifiee)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.nom,_that.email,_that.motDePasse,_that.confirmation,_that.mode,_that.status,_that.errorMessage,_that.isValide,_that.utilisateur,_that.sessionVerifiee);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
   _AuthState({required this.nom, required this.email, required this.motDePasse, required this.confirmation, required this.mode, required this.status, required this.errorMessage, required this.isValide, required this.utilisateur, required this.sessionVerifiee});
  

@override final  TextFormz nom;
@override final  EmailFormz email;
@override final  PasswordTextFormz motDePasse;
@override final  ConfirmationMotDePasseFormz confirmation;
@override final  ModeAuthentification mode;
@override final  FormzSubmissionStatus status;
@override final  String errorMessage;
@override final  bool isValide;
@override final  UtilisateurEntite? utilisateur;
@override final  bool sessionVerifiee;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.email, email) || other.email == email)&&(identical(other.motDePasse, motDePasse) || other.motDePasse == motDePasse)&&(identical(other.confirmation, confirmation) || other.confirmation == confirmation)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValide, isValide) || other.isValide == isValide)&&(identical(other.utilisateur, utilisateur) || other.utilisateur == utilisateur)&&(identical(other.sessionVerifiee, sessionVerifiee) || other.sessionVerifiee == sessionVerifiee));
}


@override
int get hashCode => Object.hash(runtimeType,nom,email,motDePasse,confirmation,mode,status,errorMessage,isValide,utilisateur,sessionVerifiee);

@override
String toString() {
  return 'AuthState(nom: $nom, email: $email, motDePasse: $motDePasse, confirmation: $confirmation, mode: $mode, status: $status, errorMessage: $errorMessage, isValide: $isValide, utilisateur: $utilisateur, sessionVerifiee: $sessionVerifiee)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 TextFormz nom, EmailFormz email, PasswordTextFormz motDePasse, ConfirmationMotDePasseFormz confirmation, ModeAuthentification mode, FormzSubmissionStatus status, String errorMessage, bool isValide, UtilisateurEntite? utilisateur, bool sessionVerifiee
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nom = null,Object? email = null,Object? motDePasse = null,Object? confirmation = null,Object? mode = null,Object? status = null,Object? errorMessage = null,Object? isValide = null,Object? utilisateur = freezed,Object? sessionVerifiee = null,}) {
  return _then(_AuthState(
nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as TextFormz,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,motDePasse: null == motDePasse ? _self.motDePasse : motDePasse // ignore: cast_nullable_to_non_nullable
as PasswordTextFormz,confirmation: null == confirmation ? _self.confirmation : confirmation // ignore: cast_nullable_to_non_nullable
as ConfirmationMotDePasseFormz,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ModeAuthentification,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValide: null == isValide ? _self.isValide : isValide // ignore: cast_nullable_to_non_nullable
as bool,utilisateur: freezed == utilisateur ? _self.utilisateur : utilisateur // ignore: cast_nullable_to_non_nullable
as UtilisateurEntite?,sessionVerifiee: null == sessionVerifiee ? _self.sessionVerifiee : sessionVerifiee // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
