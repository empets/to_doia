// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_tast_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTaskEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTaskEvent()';
}


}

/// @nodoc
class $CreateTaskEventCopyWith<$Res>  {
$CreateTaskEventCopyWith(CreateTaskEvent _, $Res Function(CreateTaskEvent) __);
}


/// Adds pattern-matching-related methods to [CreateTaskEvent].
extension CreateTaskEventPatterns on CreateTaskEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChangeTitleCreateTaskEvent value)?  changeTitle,TResult Function( ChangeDateCreateTaskEvent value)?  changeDate,TResult Function( ChangeTimeCreateTaskEvent value)?  changeTime,TResult Function( ChangeRecurringCreateTaskEvent value)?  changeRecurring,TResult Function( ChangeContentCreateTaskEvent value)?  changeContent,TResult Function( ChangeStatusCreateTaskEvent value)?  changeStatus,TResult Function( ChangeTaskIdCreateTaskEvent value)?  changeTaskId,TResult Function( ActionTypeInfoCreateTaskEvent value)?  actionType,TResult Function( SubmitCreateTaskEvent value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent() when changeTitle != null:
return changeTitle(_that);case ChangeDateCreateTaskEvent() when changeDate != null:
return changeDate(_that);case ChangeTimeCreateTaskEvent() when changeTime != null:
return changeTime(_that);case ChangeRecurringCreateTaskEvent() when changeRecurring != null:
return changeRecurring(_that);case ChangeContentCreateTaskEvent() when changeContent != null:
return changeContent(_that);case ChangeStatusCreateTaskEvent() when changeStatus != null:
return changeStatus(_that);case ChangeTaskIdCreateTaskEvent() when changeTaskId != null:
return changeTaskId(_that);case ActionTypeInfoCreateTaskEvent() when actionType != null:
return actionType(_that);case SubmitCreateTaskEvent() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChangeTitleCreateTaskEvent value)  changeTitle,required TResult Function( ChangeDateCreateTaskEvent value)  changeDate,required TResult Function( ChangeTimeCreateTaskEvent value)  changeTime,required TResult Function( ChangeRecurringCreateTaskEvent value)  changeRecurring,required TResult Function( ChangeContentCreateTaskEvent value)  changeContent,required TResult Function( ChangeStatusCreateTaskEvent value)  changeStatus,required TResult Function( ChangeTaskIdCreateTaskEvent value)  changeTaskId,required TResult Function( ActionTypeInfoCreateTaskEvent value)  actionType,required TResult Function( SubmitCreateTaskEvent value)  submit,}){
final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent():
return changeTitle(_that);case ChangeDateCreateTaskEvent():
return changeDate(_that);case ChangeTimeCreateTaskEvent():
return changeTime(_that);case ChangeRecurringCreateTaskEvent():
return changeRecurring(_that);case ChangeContentCreateTaskEvent():
return changeContent(_that);case ChangeStatusCreateTaskEvent():
return changeStatus(_that);case ChangeTaskIdCreateTaskEvent():
return changeTaskId(_that);case ActionTypeInfoCreateTaskEvent():
return actionType(_that);case SubmitCreateTaskEvent():
return submit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChangeTitleCreateTaskEvent value)?  changeTitle,TResult? Function( ChangeDateCreateTaskEvent value)?  changeDate,TResult? Function( ChangeTimeCreateTaskEvent value)?  changeTime,TResult? Function( ChangeRecurringCreateTaskEvent value)?  changeRecurring,TResult? Function( ChangeContentCreateTaskEvent value)?  changeContent,TResult? Function( ChangeStatusCreateTaskEvent value)?  changeStatus,TResult? Function( ChangeTaskIdCreateTaskEvent value)?  changeTaskId,TResult? Function( ActionTypeInfoCreateTaskEvent value)?  actionType,TResult? Function( SubmitCreateTaskEvent value)?  submit,}){
final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent() when changeTitle != null:
return changeTitle(_that);case ChangeDateCreateTaskEvent() when changeDate != null:
return changeDate(_that);case ChangeTimeCreateTaskEvent() when changeTime != null:
return changeTime(_that);case ChangeRecurringCreateTaskEvent() when changeRecurring != null:
return changeRecurring(_that);case ChangeContentCreateTaskEvent() when changeContent != null:
return changeContent(_that);case ChangeStatusCreateTaskEvent() when changeStatus != null:
return changeStatus(_that);case ChangeTaskIdCreateTaskEvent() when changeTaskId != null:
return changeTaskId(_that);case ActionTypeInfoCreateTaskEvent() when actionType != null:
return actionType(_that);case SubmitCreateTaskEvent() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String title)?  changeTitle,TResult Function( String date)?  changeDate,TResult Function( String time)?  changeTime,TResult Function( bool recurring)?  changeRecurring,TResult Function( String content)?  changeContent,TResult Function( String status)?  changeStatus,TResult Function( String taskId)?  changeTaskId,TResult Function( String actionType)?  actionType,TResult Function()?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent() when changeTitle != null:
return changeTitle(_that.title);case ChangeDateCreateTaskEvent() when changeDate != null:
return changeDate(_that.date);case ChangeTimeCreateTaskEvent() when changeTime != null:
return changeTime(_that.time);case ChangeRecurringCreateTaskEvent() when changeRecurring != null:
return changeRecurring(_that.recurring);case ChangeContentCreateTaskEvent() when changeContent != null:
return changeContent(_that.content);case ChangeStatusCreateTaskEvent() when changeStatus != null:
return changeStatus(_that.status);case ChangeTaskIdCreateTaskEvent() when changeTaskId != null:
return changeTaskId(_that.taskId);case ActionTypeInfoCreateTaskEvent() when actionType != null:
return actionType(_that.actionType);case SubmitCreateTaskEvent() when submit != null:
return submit();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String title)  changeTitle,required TResult Function( String date)  changeDate,required TResult Function( String time)  changeTime,required TResult Function( bool recurring)  changeRecurring,required TResult Function( String content)  changeContent,required TResult Function( String status)  changeStatus,required TResult Function( String taskId)  changeTaskId,required TResult Function( String actionType)  actionType,required TResult Function()  submit,}) {final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent():
return changeTitle(_that.title);case ChangeDateCreateTaskEvent():
return changeDate(_that.date);case ChangeTimeCreateTaskEvent():
return changeTime(_that.time);case ChangeRecurringCreateTaskEvent():
return changeRecurring(_that.recurring);case ChangeContentCreateTaskEvent():
return changeContent(_that.content);case ChangeStatusCreateTaskEvent():
return changeStatus(_that.status);case ChangeTaskIdCreateTaskEvent():
return changeTaskId(_that.taskId);case ActionTypeInfoCreateTaskEvent():
return actionType(_that.actionType);case SubmitCreateTaskEvent():
return submit();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String title)?  changeTitle,TResult? Function( String date)?  changeDate,TResult? Function( String time)?  changeTime,TResult? Function( bool recurring)?  changeRecurring,TResult? Function( String content)?  changeContent,TResult? Function( String status)?  changeStatus,TResult? Function( String taskId)?  changeTaskId,TResult? Function( String actionType)?  actionType,TResult? Function()?  submit,}) {final _that = this;
switch (_that) {
case ChangeTitleCreateTaskEvent() when changeTitle != null:
return changeTitle(_that.title);case ChangeDateCreateTaskEvent() when changeDate != null:
return changeDate(_that.date);case ChangeTimeCreateTaskEvent() when changeTime != null:
return changeTime(_that.time);case ChangeRecurringCreateTaskEvent() when changeRecurring != null:
return changeRecurring(_that.recurring);case ChangeContentCreateTaskEvent() when changeContent != null:
return changeContent(_that.content);case ChangeStatusCreateTaskEvent() when changeStatus != null:
return changeStatus(_that.status);case ChangeTaskIdCreateTaskEvent() when changeTaskId != null:
return changeTaskId(_that.taskId);case ActionTypeInfoCreateTaskEvent() when actionType != null:
return actionType(_that.actionType);case SubmitCreateTaskEvent() when submit != null:
return submit();case _:
  return null;

}
}

}

/// @nodoc


class ChangeTitleCreateTaskEvent implements CreateTaskEvent {
   ChangeTitleCreateTaskEvent(this.title);
  

 final  String title;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeTitleCreateTaskEventCopyWith<ChangeTitleCreateTaskEvent> get copyWith => _$ChangeTitleCreateTaskEventCopyWithImpl<ChangeTitleCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeTitleCreateTaskEvent&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'CreateTaskEvent.changeTitle(title: $title)';
}


}

/// @nodoc
abstract mixin class $ChangeTitleCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeTitleCreateTaskEventCopyWith(ChangeTitleCreateTaskEvent value, $Res Function(ChangeTitleCreateTaskEvent) _then) = _$ChangeTitleCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$ChangeTitleCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeTitleCreateTaskEventCopyWith<$Res> {
  _$ChangeTitleCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeTitleCreateTaskEvent _self;
  final $Res Function(ChangeTitleCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(ChangeTitleCreateTaskEvent(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeDateCreateTaskEvent implements CreateTaskEvent {
   ChangeDateCreateTaskEvent(this.date);
  

 final  String date;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeDateCreateTaskEventCopyWith<ChangeDateCreateTaskEvent> get copyWith => _$ChangeDateCreateTaskEventCopyWithImpl<ChangeDateCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeDateCreateTaskEvent&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'CreateTaskEvent.changeDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $ChangeDateCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeDateCreateTaskEventCopyWith(ChangeDateCreateTaskEvent value, $Res Function(ChangeDateCreateTaskEvent) _then) = _$ChangeDateCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String date
});




}
/// @nodoc
class _$ChangeDateCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeDateCreateTaskEventCopyWith<$Res> {
  _$ChangeDateCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeDateCreateTaskEvent _self;
  final $Res Function(ChangeDateCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(ChangeDateCreateTaskEvent(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeTimeCreateTaskEvent implements CreateTaskEvent {
   ChangeTimeCreateTaskEvent(this.time);
  

 final  String time;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeTimeCreateTaskEventCopyWith<ChangeTimeCreateTaskEvent> get copyWith => _$ChangeTimeCreateTaskEventCopyWithImpl<ChangeTimeCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeTimeCreateTaskEvent&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'CreateTaskEvent.changeTime(time: $time)';
}


}

/// @nodoc
abstract mixin class $ChangeTimeCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeTimeCreateTaskEventCopyWith(ChangeTimeCreateTaskEvent value, $Res Function(ChangeTimeCreateTaskEvent) _then) = _$ChangeTimeCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String time
});




}
/// @nodoc
class _$ChangeTimeCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeTimeCreateTaskEventCopyWith<$Res> {
  _$ChangeTimeCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeTimeCreateTaskEvent _self;
  final $Res Function(ChangeTimeCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = null,}) {
  return _then(ChangeTimeCreateTaskEvent(
null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeRecurringCreateTaskEvent implements CreateTaskEvent {
   ChangeRecurringCreateTaskEvent(this.recurring);
  

 final  bool recurring;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeRecurringCreateTaskEventCopyWith<ChangeRecurringCreateTaskEvent> get copyWith => _$ChangeRecurringCreateTaskEventCopyWithImpl<ChangeRecurringCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeRecurringCreateTaskEvent&&(identical(other.recurring, recurring) || other.recurring == recurring));
}


@override
int get hashCode => Object.hash(runtimeType,recurring);

@override
String toString() {
  return 'CreateTaskEvent.changeRecurring(recurring: $recurring)';
}


}

/// @nodoc
abstract mixin class $ChangeRecurringCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeRecurringCreateTaskEventCopyWith(ChangeRecurringCreateTaskEvent value, $Res Function(ChangeRecurringCreateTaskEvent) _then) = _$ChangeRecurringCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 bool recurring
});




}
/// @nodoc
class _$ChangeRecurringCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeRecurringCreateTaskEventCopyWith<$Res> {
  _$ChangeRecurringCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeRecurringCreateTaskEvent _self;
  final $Res Function(ChangeRecurringCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recurring = null,}) {
  return _then(ChangeRecurringCreateTaskEvent(
null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChangeContentCreateTaskEvent implements CreateTaskEvent {
   ChangeContentCreateTaskEvent(this.content);
  

 final  String content;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeContentCreateTaskEventCopyWith<ChangeContentCreateTaskEvent> get copyWith => _$ChangeContentCreateTaskEventCopyWithImpl<ChangeContentCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeContentCreateTaskEvent&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'CreateTaskEvent.changeContent(content: $content)';
}


}

/// @nodoc
abstract mixin class $ChangeContentCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeContentCreateTaskEventCopyWith(ChangeContentCreateTaskEvent value, $Res Function(ChangeContentCreateTaskEvent) _then) = _$ChangeContentCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String content
});




}
/// @nodoc
class _$ChangeContentCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeContentCreateTaskEventCopyWith<$Res> {
  _$ChangeContentCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeContentCreateTaskEvent _self;
  final $Res Function(ChangeContentCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(ChangeContentCreateTaskEvent(
null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeStatusCreateTaskEvent implements CreateTaskEvent {
   ChangeStatusCreateTaskEvent(this.status);
  

 final  String status;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeStatusCreateTaskEventCopyWith<ChangeStatusCreateTaskEvent> get copyWith => _$ChangeStatusCreateTaskEventCopyWithImpl<ChangeStatusCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeStatusCreateTaskEvent&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'CreateTaskEvent.changeStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class $ChangeStatusCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeStatusCreateTaskEventCopyWith(ChangeStatusCreateTaskEvent value, $Res Function(ChangeStatusCreateTaskEvent) _then) = _$ChangeStatusCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$ChangeStatusCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeStatusCreateTaskEventCopyWith<$Res> {
  _$ChangeStatusCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeStatusCreateTaskEvent _self;
  final $Res Function(ChangeStatusCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(ChangeStatusCreateTaskEvent(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeTaskIdCreateTaskEvent implements CreateTaskEvent {
   ChangeTaskIdCreateTaskEvent(this.taskId);
  

 final  String taskId;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeTaskIdCreateTaskEventCopyWith<ChangeTaskIdCreateTaskEvent> get copyWith => _$ChangeTaskIdCreateTaskEventCopyWithImpl<ChangeTaskIdCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeTaskIdCreateTaskEvent&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'CreateTaskEvent.changeTaskId(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class $ChangeTaskIdCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ChangeTaskIdCreateTaskEventCopyWith(ChangeTaskIdCreateTaskEvent value, $Res Function(ChangeTaskIdCreateTaskEvent) _then) = _$ChangeTaskIdCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String taskId
});




}
/// @nodoc
class _$ChangeTaskIdCreateTaskEventCopyWithImpl<$Res>
    implements $ChangeTaskIdCreateTaskEventCopyWith<$Res> {
  _$ChangeTaskIdCreateTaskEventCopyWithImpl(this._self, this._then);

  final ChangeTaskIdCreateTaskEvent _self;
  final $Res Function(ChangeTaskIdCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,}) {
  return _then(ChangeTaskIdCreateTaskEvent(
null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ActionTypeInfoCreateTaskEvent implements CreateTaskEvent {
   ActionTypeInfoCreateTaskEvent(this.actionType);
  

 final  String actionType;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionTypeInfoCreateTaskEventCopyWith<ActionTypeInfoCreateTaskEvent> get copyWith => _$ActionTypeInfoCreateTaskEventCopyWithImpl<ActionTypeInfoCreateTaskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionTypeInfoCreateTaskEvent&&(identical(other.actionType, actionType) || other.actionType == actionType));
}


@override
int get hashCode => Object.hash(runtimeType,actionType);

@override
String toString() {
  return 'CreateTaskEvent.actionType(actionType: $actionType)';
}


}

/// @nodoc
abstract mixin class $ActionTypeInfoCreateTaskEventCopyWith<$Res> implements $CreateTaskEventCopyWith<$Res> {
  factory $ActionTypeInfoCreateTaskEventCopyWith(ActionTypeInfoCreateTaskEvent value, $Res Function(ActionTypeInfoCreateTaskEvent) _then) = _$ActionTypeInfoCreateTaskEventCopyWithImpl;
@useResult
$Res call({
 String actionType
});




}
/// @nodoc
class _$ActionTypeInfoCreateTaskEventCopyWithImpl<$Res>
    implements $ActionTypeInfoCreateTaskEventCopyWith<$Res> {
  _$ActionTypeInfoCreateTaskEventCopyWithImpl(this._self, this._then);

  final ActionTypeInfoCreateTaskEvent _self;
  final $Res Function(ActionTypeInfoCreateTaskEvent) _then;

/// Create a copy of CreateTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? actionType = null,}) {
  return _then(ActionTypeInfoCreateTaskEvent(
null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SubmitCreateTaskEvent implements CreateTaskEvent {
   SubmitCreateTaskEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitCreateTaskEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTaskEvent.submit()';
}


}




// dart format on
