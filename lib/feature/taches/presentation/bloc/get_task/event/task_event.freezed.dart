// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskSectionEvent {

 String? get id;
/// Create a copy of TaskSectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSectionEventCopyWith<TaskSectionEvent> get copyWith => _$TaskSectionEventCopyWithImpl<TaskSectionEvent>(this as TaskSectionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSectionEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskSectionEvent(id: $id)';
}


}

/// @nodoc
abstract mixin class $TaskSectionEventCopyWith<$Res>  {
  factory $TaskSectionEventCopyWith(TaskSectionEvent value, $Res Function(TaskSectionEvent) _then) = _$TaskSectionEventCopyWithImpl;
@useResult
$Res call({
 String? id
});




}
/// @nodoc
class _$TaskSectionEventCopyWithImpl<$Res>
    implements $TaskSectionEventCopyWith<$Res> {
  _$TaskSectionEventCopyWithImpl(this._self, this._then);

  final TaskSectionEvent _self;
  final $Res Function(TaskSectionEvent) _then;

/// Create a copy of TaskSectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSectionEvent].
extension TaskSectionEventPatterns on TaskSectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTaskSectionEvent value)?  fetch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTaskSectionEvent() when fetch != null:
return fetch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTaskSectionEvent value)  fetch,}){
final _that = this;
switch (_that) {
case FetchTaskSectionEvent():
return fetch(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTaskSectionEvent value)?  fetch,}){
final _that = this;
switch (_that) {
case FetchTaskSectionEvent() when fetch != null:
return fetch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? id)?  fetch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTaskSectionEvent() when fetch != null:
return fetch(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? id)  fetch,}) {final _that = this;
switch (_that) {
case FetchTaskSectionEvent():
return fetch(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? id)?  fetch,}) {final _that = this;
switch (_that) {
case FetchTaskSectionEvent() when fetch != null:
return fetch(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class FetchTaskSectionEvent implements TaskSectionEvent {
   FetchTaskSectionEvent(this.id);
  

@override final  String? id;

/// Create a copy of TaskSectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchTaskSectionEventCopyWith<FetchTaskSectionEvent> get copyWith => _$FetchTaskSectionEventCopyWithImpl<FetchTaskSectionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTaskSectionEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskSectionEvent.fetch(id: $id)';
}


}

/// @nodoc
abstract mixin class $FetchTaskSectionEventCopyWith<$Res> implements $TaskSectionEventCopyWith<$Res> {
  factory $FetchTaskSectionEventCopyWith(FetchTaskSectionEvent value, $Res Function(FetchTaskSectionEvent) _then) = _$FetchTaskSectionEventCopyWithImpl;
@override @useResult
$Res call({
 String? id
});




}
/// @nodoc
class _$FetchTaskSectionEventCopyWithImpl<$Res>
    implements $FetchTaskSectionEventCopyWith<$Res> {
  _$FetchTaskSectionEventCopyWithImpl(this._self, this._then);

  final FetchTaskSectionEvent _self;
  final $Res Function(FetchTaskSectionEvent) _then;

/// Create a copy of TaskSectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(FetchTaskSectionEvent(
freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
