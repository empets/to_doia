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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ApiState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiState<$T>()';
  }
}

/// @nodoc
class $ApiStateCopyWith<T, $Res> {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FailedState<T> value)? failed,
    TResult Function(SuccessState<T> value)? success,
    TResult Function(LoadState<T> value)? load,
    TResult Function(InitialState<T> value)? initial,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FailedState() when failed != null:
        return failed(_that);
      case SuccessState() when success != null:
        return success(_that);
      case LoadState() when load != null:
        return load(_that);
      case InitialState() when initial != null:
        return initial(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FailedState<T> value) failed,
    required TResult Function(SuccessState<T> value) success,
    required TResult Function(LoadState<T> value) load,
    required TResult Function(InitialState<T> value) initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedState():
        return failed(_that);
      case SuccessState():
        return success(_that);
      case LoadState():
        return load(_that);
      case InitialState():
        return initial(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FailedState<T> value)? failed,
    TResult? Function(SuccessState<T> value)? success,
    TResult? Function(LoadState<T> value)? load,
    TResult? Function(InitialState<T> value)? initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedState() when failed != null:
        return failed(_that);
      case SuccessState() when success != null:
        return success(_that);
      case LoadState() when load != null:
        return load(_that);
      case InitialState() when initial != null:
        return initial(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, Failure? errorType)? failed,
    TResult Function(T data, bool? refresh, bool hasReachedMax, int page,
            FormzSubmissionStatus? status, String? error)?
        success,
    TResult Function()? load,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FailedState() when failed != null:
        return failed(_that.message, _that.errorType);
      case SuccessState() when success != null:
        return success(_that.data, _that.refresh, _that.hasReachedMax,
            _that.page, _that.status, _that.error);
      case LoadState() when load != null:
        return load();
      case InitialState() when initial != null:
        return initial();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, Failure? errorType) failed,
    required TResult Function(T data, bool? refresh, bool hasReachedMax,
            int page, FormzSubmissionStatus? status, String? error)
        success,
    required TResult Function() load,
    required TResult Function() initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedState():
        return failed(_that.message, _that.errorType);
      case SuccessState():
        return success(_that.data, _that.refresh, _that.hasReachedMax,
            _that.page, _that.status, _that.error);
      case LoadState():
        return load();
      case InitialState():
        return initial();
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, Failure? errorType)? failed,
    TResult? Function(T data, bool? refresh, bool hasReachedMax, int page,
            FormzSubmissionStatus? status, String? error)?
        success,
    TResult? Function()? load,
    TResult? Function()? initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedState() when failed != null:
        return failed(_that.message, _that.errorType);
      case SuccessState() when success != null:
        return success(_that.data, _that.refresh, _that.hasReachedMax,
            _that.page, _that.status, _that.error);
      case LoadState() when load != null:
        return load();
      case InitialState() when initial != null:
        return initial();
      case _:
        return null;
    }
  }
}

/// @nodoc

class FailedState<T> implements ApiState<T> {
  const FailedState([this.message, this.errorType]);

  final String? message;
  final Failure? errorType;

  /// Create a copy of ApiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FailedStateCopyWith<T, FailedState<T>> get copyWith =>
      _$FailedStateCopyWithImpl<T, FailedState<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FailedState<T> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorType);

  @override
  String toString() {
    return 'ApiState<$T>.failed(message: $message, errorType: $errorType)';
  }
}

/// @nodoc
abstract mixin class $FailedStateCopyWith<T, $Res>
    implements $ApiStateCopyWith<T, $Res> {
  factory $FailedStateCopyWith(
          FailedState<T> value, $Res Function(FailedState<T>) _then) =
      _$FailedStateCopyWithImpl;
  @useResult
  $Res call({String? message, Failure? errorType});
}

/// @nodoc
class _$FailedStateCopyWithImpl<T, $Res>
    implements $FailedStateCopyWith<T, $Res> {
  _$FailedStateCopyWithImpl(this._self, this._then);

  final FailedState<T> _self;
  final $Res Function(FailedState<T>) _then;

  /// Create a copy of ApiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? errorType = freezed,
  }) {
    return _then(FailedState<T>(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == errorType
          ? _self.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class SuccessState<T> implements ApiState<T> {
  const SuccessState(this.data,
      {this.refresh,
      this.hasReachedMax = true,
      this.page = 0,
      this.status,
      this.error});

  final T data;
  final bool? refresh;
  @JsonKey()
  final bool hasReachedMax;
  @JsonKey()
  final int page;
//count
  final FormzSubmissionStatus? status;
  final String? error;

  /// Create a copy of ApiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessStateCopyWith<T, SuccessState<T>> get copyWith =>
      _$SuccessStateCopyWithImpl<T, SuccessState<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuccessState<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      refresh,
      hasReachedMax,
      page,
      status,
      error);

  @override
  String toString() {
    return 'ApiState<$T>.success(data: $data, refresh: $refresh, hasReachedMax: $hasReachedMax, page: $page, status: $status, error: $error)';
  }
}

/// @nodoc
abstract mixin class $SuccessStateCopyWith<T, $Res>
    implements $ApiStateCopyWith<T, $Res> {
  factory $SuccessStateCopyWith(
          SuccessState<T> value, $Res Function(SuccessState<T>) _then) =
      _$SuccessStateCopyWithImpl;
  @useResult
  $Res call(
      {T data,
      bool? refresh,
      bool hasReachedMax,
      int page,
      FormzSubmissionStatus? status,
      String? error});
}

/// @nodoc
class _$SuccessStateCopyWithImpl<T, $Res>
    implements $SuccessStateCopyWith<T, $Res> {
  _$SuccessStateCopyWithImpl(this._self, this._then);

  final SuccessState<T> _self;
  final $Res Function(SuccessState<T>) _then;

  /// Create a copy of ApiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? refresh = freezed,
    Object? hasReachedMax = null,
    Object? page = null,
    Object? status = freezed,
    Object? error = freezed,
  }) {
    return _then(SuccessState<T>(
      freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      refresh: freezed == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasReachedMax: null == hasReachedMax
          ? _self.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class LoadState<T> implements ApiState<T> {
  const LoadState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadState<T>);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InitialState<T>);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ApiStateOther<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiStateOther<$T>()';
  }
}

/// @nodoc
class $ApiStateOtherCopyWith<T, $Res> {
  $ApiStateOtherCopyWith(
      ApiStateOther<T> _, $Res Function(ApiStateOther<T>) __);
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FailedStateOther<T> value)? failed,
    TResult Function(SuccessStateOther<T> value)? success,
    TResult Function(LoadStateOther<T> value)? load,
    TResult Function(InitialStateOther<T> value)? initial,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther() when failed != null:
        return failed(_that);
      case SuccessStateOther() when success != null:
        return success(_that);
      case LoadStateOther() when load != null:
        return load(_that);
      case InitialStateOther() when initial != null:
        return initial(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FailedStateOther<T> value) failed,
    required TResult Function(SuccessStateOther<T> value) success,
    required TResult Function(LoadStateOther<T> value) load,
    required TResult Function(InitialStateOther<T> value) initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther():
        return failed(_that);
      case SuccessStateOther():
        return success(_that);
      case LoadStateOther():
        return load(_that);
      case InitialStateOther():
        return initial(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FailedStateOther<T> value)? failed,
    TResult? Function(SuccessStateOther<T> value)? success,
    TResult? Function(LoadStateOther<T> value)? load,
    TResult? Function(InitialStateOther<T> value)? initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther() when failed != null:
        return failed(_that);
      case SuccessStateOther() when success != null:
        return success(_that);
      case LoadStateOther() when load != null:
        return load(_that);
      case InitialStateOther() when initial != null:
        return initial(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, Failure? errorType)? failed,
    TResult Function(T data, bool? refresh, FormzSubmissionStatus? status,
            String? error)?
        success,
    TResult Function()? load,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther() when failed != null:
        return failed(_that.message, _that.errorType);
      case SuccessStateOther() when success != null:
        return success(_that.data, _that.refresh, _that.status, _that.error);
      case LoadStateOther() when load != null:
        return load();
      case InitialStateOther() when initial != null:
        return initial();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, Failure? errorType) failed,
    required TResult Function(
            T data, bool? refresh, FormzSubmissionStatus? status, String? error)
        success,
    required TResult Function() load,
    required TResult Function() initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther():
        return failed(_that.message, _that.errorType);
      case SuccessStateOther():
        return success(_that.data, _that.refresh, _that.status, _that.error);
      case LoadStateOther():
        return load();
      case InitialStateOther():
        return initial();
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, Failure? errorType)? failed,
    TResult? Function(T data, bool? refresh, FormzSubmissionStatus? status,
            String? error)?
        success,
    TResult? Function()? load,
    TResult? Function()? initial,
  }) {
    final _that = this;
    switch (_that) {
      case FailedStateOther() when failed != null:
        return failed(_that.message, _that.errorType);
      case SuccessStateOther() when success != null:
        return success(_that.data, _that.refresh, _that.status, _that.error);
      case LoadStateOther() when load != null:
        return load();
      case InitialStateOther() when initial != null:
        return initial();
      case _:
        return null;
    }
  }
}

/// @nodoc

class FailedStateOther<T> implements ApiStateOther<T> {
  const FailedStateOther([this.message, this.errorType]);

  final String? message;
  final Failure? errorType;

  /// Create a copy of ApiStateOther
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FailedStateOtherCopyWith<T, FailedStateOther<T>> get copyWith =>
      _$FailedStateOtherCopyWithImpl<T, FailedStateOther<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FailedStateOther<T> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorType);

  @override
  String toString() {
    return 'ApiStateOther<$T>.failed(message: $message, errorType: $errorType)';
  }
}

/// @nodoc
abstract mixin class $FailedStateOtherCopyWith<T, $Res>
    implements $ApiStateOtherCopyWith<T, $Res> {
  factory $FailedStateOtherCopyWith(
          FailedStateOther<T> value, $Res Function(FailedStateOther<T>) _then) =
      _$FailedStateOtherCopyWithImpl;
  @useResult
  $Res call({String? message, Failure? errorType});
}

/// @nodoc
class _$FailedStateOtherCopyWithImpl<T, $Res>
    implements $FailedStateOtherCopyWith<T, $Res> {
  _$FailedStateOtherCopyWithImpl(this._self, this._then);

  final FailedStateOther<T> _self;
  final $Res Function(FailedStateOther<T>) _then;

  /// Create a copy of ApiStateOther
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? errorType = freezed,
  }) {
    return _then(FailedStateOther<T>(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == errorType
          ? _self.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class SuccessStateOther<T> implements ApiStateOther<T> {
  const SuccessStateOther(this.data, {this.refresh, this.status, this.error});

  final T data;
  final bool? refresh;
  final FormzSubmissionStatus? status;
  final String? error;

  /// Create a copy of ApiStateOther
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessStateOtherCopyWith<T, SuccessStateOther<T>> get copyWith =>
      _$SuccessStateOtherCopyWithImpl<T, SuccessStateOther<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuccessStateOther<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), refresh, status, error);

  @override
  String toString() {
    return 'ApiStateOther<$T>.success(data: $data, refresh: $refresh, status: $status, error: $error)';
  }
}

/// @nodoc
abstract mixin class $SuccessStateOtherCopyWith<T, $Res>
    implements $ApiStateOtherCopyWith<T, $Res> {
  factory $SuccessStateOtherCopyWith(SuccessStateOther<T> value,
          $Res Function(SuccessStateOther<T>) _then) =
      _$SuccessStateOtherCopyWithImpl;
  @useResult
  $Res call(
      {T data, bool? refresh, FormzSubmissionStatus? status, String? error});
}

/// @nodoc
class _$SuccessStateOtherCopyWithImpl<T, $Res>
    implements $SuccessStateOtherCopyWith<T, $Res> {
  _$SuccessStateOtherCopyWithImpl(this._self, this._then);

  final SuccessStateOther<T> _self;
  final $Res Function(SuccessStateOther<T>) _then;

  /// Create a copy of ApiStateOther
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? refresh = freezed,
    Object? status = freezed,
    Object? error = freezed,
  }) {
    return _then(SuccessStateOther<T>(
      freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      refresh: freezed == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class LoadStateOther<T> implements ApiStateOther<T> {
  const LoadStateOther();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadStateOther<T>);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InitialStateOther<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiStateOther<$T>.initial()';
  }
}

/// @nodoc
mixin _$ApiEvent {
  String? get nd;
  bool? get refresh;

  /// Create a copy of ApiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiEventCopyWith<ApiEvent> get copyWith =>
      _$ApiEventCopyWithImpl<ApiEvent>(this as ApiEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiEvent &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, refresh);

  @override
  String toString() {
    return 'ApiEvent(nd: $nd, refresh: $refresh)';
  }
}

/// @nodoc
abstract mixin class $ApiEventCopyWith<$Res> {
  factory $ApiEventCopyWith(ApiEvent value, $Res Function(ApiEvent) _then) =
      _$ApiEventCopyWithImpl;
  @useResult
  $Res call({String? nd, bool? refresh});
}

/// @nodoc
class _$ApiEventCopyWithImpl<$Res> implements $ApiEventCopyWith<$Res> {
  _$ApiEventCopyWithImpl(this._self, this._then);

  final ApiEvent _self;
  final $Res Function(ApiEvent) _then;

  /// Create a copy of ApiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nd = freezed,
    Object? refresh = freezed,
  }) {
    return _then(_self.copyWith(
      nd: freezed == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String?,
      refresh: freezed == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ApiEvent].
extension ApiEventPatterns on ApiEvent {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchApiEvent value)? fetch,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent() when fetch != null:
        return fetch(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchApiEvent value) fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent():
        return fetch(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchApiEvent value)? fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent() when fetch != null:
        return fetch(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? nd, bool? refresh)? fetch,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent() when fetch != null:
        return fetch(_that.nd, _that.refresh);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? nd, bool? refresh) fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent():
        return fetch(_that.nd, _that.refresh);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? nd, bool? refresh)? fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEvent() when fetch != null:
        return fetch(_that.nd, _that.refresh);
      case _:
        return null;
    }
  }
}

/// @nodoc

class FetchApiEvent implements ApiEvent {
  const FetchApiEvent([this.nd, this.refresh]);

  @override
  final String? nd;
  @override
  final bool? refresh;

  /// Create a copy of ApiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FetchApiEventCopyWith<FetchApiEvent> get copyWith =>
      _$FetchApiEventCopyWithImpl<FetchApiEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FetchApiEvent &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, refresh);

  @override
  String toString() {
    return 'ApiEvent.fetch(nd: $nd, refresh: $refresh)';
  }
}

/// @nodoc
abstract mixin class $FetchApiEventCopyWith<$Res>
    implements $ApiEventCopyWith<$Res> {
  factory $FetchApiEventCopyWith(
          FetchApiEvent value, $Res Function(FetchApiEvent) _then) =
      _$FetchApiEventCopyWithImpl;
  @override
  @useResult
  $Res call({String? nd, bool? refresh});
}

/// @nodoc
class _$FetchApiEventCopyWithImpl<$Res>
    implements $FetchApiEventCopyWith<$Res> {
  _$FetchApiEventCopyWithImpl(this._self, this._then);

  final FetchApiEvent _self;
  final $Res Function(FetchApiEvent) _then;

  /// Create a copy of ApiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = freezed,
    Object? refresh = freezed,
  }) {
    return _then(FetchApiEvent(
      freezed == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$ApiEventHistoryDebit {
  String get nd;
  String get source;
  bool get refresh;

  /// Create a copy of ApiEventHistoryDebit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiEventHistoryDebitCopyWith<ApiEventHistoryDebit> get copyWith =>
      _$ApiEventHistoryDebitCopyWithImpl<ApiEventHistoryDebit>(
          this as ApiEventHistoryDebit, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiEventHistoryDebit &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, source, refresh);

  @override
  String toString() {
    return 'ApiEventHistoryDebit(nd: $nd, source: $source, refresh: $refresh)';
  }
}

/// @nodoc
abstract mixin class $ApiEventHistoryDebitCopyWith<$Res> {
  factory $ApiEventHistoryDebitCopyWith(ApiEventHistoryDebit value,
          $Res Function(ApiEventHistoryDebit) _then) =
      _$ApiEventHistoryDebitCopyWithImpl;
  @useResult
  $Res call({String nd, String source, bool refresh});
}

/// @nodoc
class _$ApiEventHistoryDebitCopyWithImpl<$Res>
    implements $ApiEventHistoryDebitCopyWith<$Res> {
  _$ApiEventHistoryDebitCopyWithImpl(this._self, this._then);

  final ApiEventHistoryDebit _self;
  final $Res Function(ApiEventHistoryDebit) _then;

  /// Create a copy of ApiEventHistoryDebit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nd = null,
    Object? source = null,
    Object? refresh = null,
  }) {
    return _then(_self.copyWith(
      nd: null == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      refresh: null == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ApiEventHistoryDebit].
extension ApiEventHistoryDebitPatterns on ApiEventHistoryDebit {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchApiEventHistoryDebit value)? fetch,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit() when fetch != null:
        return fetch(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchApiEventHistoryDebit value) fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit():
        return fetch(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchApiEventHistoryDebit value)? fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit() when fetch != null:
        return fetch(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nd, String source, bool refresh)? fetch,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit() when fetch != null:
        return fetch(_that.nd, _that.source, _that.refresh);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nd, String source, bool refresh) fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit():
        return fetch(_that.nd, _that.source, _that.refresh);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nd, String source, bool refresh)? fetch,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventHistoryDebit() when fetch != null:
        return fetch(_that.nd, _that.source, _that.refresh);
      case _:
        return null;
    }
  }
}

/// @nodoc

class FetchApiEventHistoryDebit implements ApiEventHistoryDebit {
  const FetchApiEventHistoryDebit(this.nd, this.source, this.refresh);

  @override
  final String nd;
  @override
  final String source;
  @override
  final bool refresh;

  /// Create a copy of ApiEventHistoryDebit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FetchApiEventHistoryDebitCopyWith<FetchApiEventHistoryDebit> get copyWith =>
      _$FetchApiEventHistoryDebitCopyWithImpl<FetchApiEventHistoryDebit>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FetchApiEventHistoryDebit &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, source, refresh);

  @override
  String toString() {
    return 'ApiEventHistoryDebit.fetch(nd: $nd, source: $source, refresh: $refresh)';
  }
}

/// @nodoc
abstract mixin class $FetchApiEventHistoryDebitCopyWith<$Res>
    implements $ApiEventHistoryDebitCopyWith<$Res> {
  factory $FetchApiEventHistoryDebitCopyWith(FetchApiEventHistoryDebit value,
          $Res Function(FetchApiEventHistoryDebit) _then) =
      _$FetchApiEventHistoryDebitCopyWithImpl;
  @override
  @useResult
  $Res call({String nd, String source, bool refresh});
}

/// @nodoc
class _$FetchApiEventHistoryDebitCopyWithImpl<$Res>
    implements $FetchApiEventHistoryDebitCopyWith<$Res> {
  _$FetchApiEventHistoryDebitCopyWithImpl(this._self, this._then);

  final FetchApiEventHistoryDebit _self;
  final $Res Function(FetchApiEventHistoryDebit) _then;

  /// Create a copy of ApiEventHistoryDebit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = null,
    Object? source = null,
    Object? refresh = null,
  }) {
    return _then(FetchApiEventHistoryDebit(
      null == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String,
      null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      null == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ApiEventTest {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ApiEventTest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventTest()';
  }
}

/// @nodoc
class $ApiEventTestCopyWith<$Res> {
  $ApiEventTestCopyWith(ApiEventTest _, $Res Function(ApiEventTest) __);
}

/// Adds pattern-matching-related methods to [ApiEventTest].
extension ApiEventTestPatterns on ApiEventTest {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchApiEventTest value)? fetch,
    TResult Function(CreateApiEventTest value)? create,
    TResult Function(AddNewTestApiEventTest value)? addNewTest,
    TResult Function(HTestDebitCreateApiEventTest value)? hTestDebitCreate,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest() when fetch != null:
        return fetch(_that);
      case CreateApiEventTest() when create != null:
        return create(_that);
      case AddNewTestApiEventTest() when addNewTest != null:
        return addNewTest(_that);
      case HTestDebitCreateApiEventTest() when hTestDebitCreate != null:
        return hTestDebitCreate(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchApiEventTest value) fetch,
    required TResult Function(CreateApiEventTest value) create,
    required TResult Function(AddNewTestApiEventTest value) addNewTest,
    required TResult Function(HTestDebitCreateApiEventTest value)
        hTestDebitCreate,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest():
        return fetch(_that);
      case CreateApiEventTest():
        return create(_that);
      case AddNewTestApiEventTest():
        return addNewTest(_that);
      case HTestDebitCreateApiEventTest():
        return hTestDebitCreate(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchApiEventTest value)? fetch,
    TResult? Function(CreateApiEventTest value)? create,
    TResult? Function(AddNewTestApiEventTest value)? addNewTest,
    TResult? Function(HTestDebitCreateApiEventTest value)? hTestDebitCreate,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest() when fetch != null:
        return fetch(_that);
      case CreateApiEventTest() when create != null:
        return create(_that);
      case AddNewTestApiEventTest() when addNewTest != null:
        return addNewTest(_that);
      case HTestDebitCreateApiEventTest() when hTestDebitCreate != null:
        return hTestDebitCreate(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? nd, bool? refresh)? fetch,
    TResult Function(String nd)? create,
    TResult Function(String nd)? addNewTest,
    TResult Function(LastDebitResponse item)? hTestDebitCreate,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest() when fetch != null:
        return fetch(_that.nd, _that.refresh);
      case CreateApiEventTest() when create != null:
        return create(_that.nd);
      case AddNewTestApiEventTest() when addNewTest != null:
        return addNewTest(_that.nd);
      case HTestDebitCreateApiEventTest() when hTestDebitCreate != null:
        return hTestDebitCreate(_that.item);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? nd, bool? refresh) fetch,
    required TResult Function(String nd) create,
    required TResult Function(String nd) addNewTest,
    required TResult Function(LastDebitResponse item) hTestDebitCreate,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest():
        return fetch(_that.nd, _that.refresh);
      case CreateApiEventTest():
        return create(_that.nd);
      case AddNewTestApiEventTest():
        return addNewTest(_that.nd);
      case HTestDebitCreateApiEventTest():
        return hTestDebitCreate(_that.item);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? nd, bool? refresh)? fetch,
    TResult? Function(String nd)? create,
    TResult? Function(String nd)? addNewTest,
    TResult? Function(LastDebitResponse item)? hTestDebitCreate,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventTest() when fetch != null:
        return fetch(_that.nd, _that.refresh);
      case CreateApiEventTest() when create != null:
        return create(_that.nd);
      case AddNewTestApiEventTest() when addNewTest != null:
        return addNewTest(_that.nd);
      case HTestDebitCreateApiEventTest() when hTestDebitCreate != null:
        return hTestDebitCreate(_that.item);
      case _:
        return null;
    }
  }
}

/// @nodoc

class FetchApiEventTest implements ApiEventTest {
  const FetchApiEventTest([this.nd, this.refresh]);

  final String? nd;
  final bool? refresh;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FetchApiEventTestCopyWith<FetchApiEventTest> get copyWith =>
      _$FetchApiEventTestCopyWithImpl<FetchApiEventTest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FetchApiEventTest &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, refresh);

  @override
  String toString() {
    return 'ApiEventTest.fetch(nd: $nd, refresh: $refresh)';
  }
}

/// @nodoc
abstract mixin class $FetchApiEventTestCopyWith<$Res>
    implements $ApiEventTestCopyWith<$Res> {
  factory $FetchApiEventTestCopyWith(
          FetchApiEventTest value, $Res Function(FetchApiEventTest) _then) =
      _$FetchApiEventTestCopyWithImpl;
  @useResult
  $Res call({String? nd, bool? refresh});
}

/// @nodoc
class _$FetchApiEventTestCopyWithImpl<$Res>
    implements $FetchApiEventTestCopyWith<$Res> {
  _$FetchApiEventTestCopyWithImpl(this._self, this._then);

  final FetchApiEventTest _self;
  final $Res Function(FetchApiEventTest) _then;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = freezed,
    Object? refresh = freezed,
  }) {
    return _then(FetchApiEventTest(
      freezed == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == refresh
          ? _self.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class CreateApiEventTest implements ApiEventTest {
  const CreateApiEventTest(this.nd);

  final String nd;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateApiEventTestCopyWith<CreateApiEventTest> get copyWith =>
      _$CreateApiEventTestCopyWithImpl<CreateApiEventTest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateApiEventTest &&
            (identical(other.nd, nd) || other.nd == nd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd);

  @override
  String toString() {
    return 'ApiEventTest.create(nd: $nd)';
  }
}

/// @nodoc
abstract mixin class $CreateApiEventTestCopyWith<$Res>
    implements $ApiEventTestCopyWith<$Res> {
  factory $CreateApiEventTestCopyWith(
          CreateApiEventTest value, $Res Function(CreateApiEventTest) _then) =
      _$CreateApiEventTestCopyWithImpl;
  @useResult
  $Res call({String nd});
}

/// @nodoc
class _$CreateApiEventTestCopyWithImpl<$Res>
    implements $CreateApiEventTestCopyWith<$Res> {
  _$CreateApiEventTestCopyWithImpl(this._self, this._then);

  final CreateApiEventTest _self;
  final $Res Function(CreateApiEventTest) _then;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = null,
  }) {
    return _then(CreateApiEventTest(
      null == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AddNewTestApiEventTest implements ApiEventTest {
  const AddNewTestApiEventTest(this.nd);

  final String nd;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddNewTestApiEventTestCopyWith<AddNewTestApiEventTest> get copyWith =>
      _$AddNewTestApiEventTestCopyWithImpl<AddNewTestApiEventTest>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddNewTestApiEventTest &&
            (identical(other.nd, nd) || other.nd == nd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd);

  @override
  String toString() {
    return 'ApiEventTest.addNewTest(nd: $nd)';
  }
}

/// @nodoc
abstract mixin class $AddNewTestApiEventTestCopyWith<$Res>
    implements $ApiEventTestCopyWith<$Res> {
  factory $AddNewTestApiEventTestCopyWith(AddNewTestApiEventTest value,
          $Res Function(AddNewTestApiEventTest) _then) =
      _$AddNewTestApiEventTestCopyWithImpl;
  @useResult
  $Res call({String nd});
}

/// @nodoc
class _$AddNewTestApiEventTestCopyWithImpl<$Res>
    implements $AddNewTestApiEventTestCopyWith<$Res> {
  _$AddNewTestApiEventTestCopyWithImpl(this._self, this._then);

  final AddNewTestApiEventTest _self;
  final $Res Function(AddNewTestApiEventTest) _then;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = null,
  }) {
    return _then(AddNewTestApiEventTest(
      null == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class HTestDebitCreateApiEventTest implements ApiEventTest {
  const HTestDebitCreateApiEventTest(this.item);

  final LastDebitResponse item;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HTestDebitCreateApiEventTestCopyWith<HTestDebitCreateApiEventTest>
      get copyWith => _$HTestDebitCreateApiEventTestCopyWithImpl<
          HTestDebitCreateApiEventTest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HTestDebitCreateApiEventTest &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @override
  String toString() {
    return 'ApiEventTest.hTestDebitCreate(item: $item)';
  }
}

/// @nodoc
abstract mixin class $HTestDebitCreateApiEventTestCopyWith<$Res>
    implements $ApiEventTestCopyWith<$Res> {
  factory $HTestDebitCreateApiEventTestCopyWith(
          HTestDebitCreateApiEventTest value,
          $Res Function(HTestDebitCreateApiEventTest) _then) =
      _$HTestDebitCreateApiEventTestCopyWithImpl;
  @useResult
  $Res call({LastDebitResponse item});

  $LastDebitResponseCopyWith<$Res> get item;
}

/// @nodoc
class _$HTestDebitCreateApiEventTestCopyWithImpl<$Res>
    implements $HTestDebitCreateApiEventTestCopyWith<$Res> {
  _$HTestDebitCreateApiEventTestCopyWithImpl(this._self, this._then);

  final HTestDebitCreateApiEventTest _self;
  final $Res Function(HTestDebitCreateApiEventTest) _then;

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = null,
  }) {
    return _then(HTestDebitCreateApiEventTest(
      null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as LastDebitResponse,
    ));
  }

  /// Create a copy of ApiEventTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastDebitResponseCopyWith<$Res> get item {
    return $LastDebitResponseCopyWith<$Res>(_self.item, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// @nodoc
mixin _$ApiEventCrud<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ApiEventCrud<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventCrud<$T>()';
  }
}

/// @nodoc
class $ApiEventCrudCopyWith<T, $Res> {
  $ApiEventCrudCopyWith(ApiEventCrud<T> _, $Res Function(ApiEventCrud<T>) __);
}

/// Adds pattern-matching-related methods to [ApiEventCrud].
extension ApiEventCrudPatterns<T> on ApiEventCrud<T> {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchApiEventCrud<T> value)? fetch,
    TResult Function(GetAllApiEventCrud<T> value)? getAll,
    TResult Function(ToggleApiEventCrud<T> value)? toggle,
    TResult Function(SubmitApiEventCrud<T> value)? submit,
    TResult Function(CreateApiEventCrud<T> value)? create,
    TResult Function(UpdateApiEventCrud<T> value)? update,
    TResult Function(DeleteApiEventCrud<T> value)? delete,
    TResult Function(SelectedApiEventCrud<T> value)? selected,
    TResult Function(PinpadAddKeyEvent<T> value)? addKey,
    TResult Function(PinpadDeleteKeyEvent<T> value)? deleteKey,
    TResult Function(PinpadClearEvent<T> value)? clear,
    TResult Function(PinpadSubmitPinEvent<T> value)? submitPin,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud() when fetch != null:
        return fetch(_that);
      case GetAllApiEventCrud() when getAll != null:
        return getAll(_that);
      case ToggleApiEventCrud() when toggle != null:
        return toggle(_that);
      case SubmitApiEventCrud() when submit != null:
        return submit(_that);
      case CreateApiEventCrud() when create != null:
        return create(_that);
      case UpdateApiEventCrud() when update != null:
        return update(_that);
      case DeleteApiEventCrud() when delete != null:
        return delete(_that);
      case SelectedApiEventCrud() when selected != null:
        return selected(_that);
      case PinpadAddKeyEvent() when addKey != null:
        return addKey(_that);
      case PinpadDeleteKeyEvent() when deleteKey != null:
        return deleteKey(_that);
      case PinpadClearEvent() when clear != null:
        return clear(_that);
      case PinpadSubmitPinEvent() when submitPin != null:
        return submitPin(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchApiEventCrud<T> value) fetch,
    required TResult Function(GetAllApiEventCrud<T> value) getAll,
    required TResult Function(ToggleApiEventCrud<T> value) toggle,
    required TResult Function(SubmitApiEventCrud<T> value) submit,
    required TResult Function(CreateApiEventCrud<T> value) create,
    required TResult Function(UpdateApiEventCrud<T> value) update,
    required TResult Function(DeleteApiEventCrud<T> value) delete,
    required TResult Function(SelectedApiEventCrud<T> value) selected,
    required TResult Function(PinpadAddKeyEvent<T> value) addKey,
    required TResult Function(PinpadDeleteKeyEvent<T> value) deleteKey,
    required TResult Function(PinpadClearEvent<T> value) clear,
    required TResult Function(PinpadSubmitPinEvent<T> value) submitPin,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud():
        return fetch(_that);
      case GetAllApiEventCrud():
        return getAll(_that);
      case ToggleApiEventCrud():
        return toggle(_that);
      case SubmitApiEventCrud():
        return submit(_that);
      case CreateApiEventCrud():
        return create(_that);
      case UpdateApiEventCrud():
        return update(_that);
      case DeleteApiEventCrud():
        return delete(_that);
      case SelectedApiEventCrud():
        return selected(_that);
      case PinpadAddKeyEvent():
        return addKey(_that);
      case PinpadDeleteKeyEvent():
        return deleteKey(_that);
      case PinpadClearEvent():
        return clear(_that);
      case PinpadSubmitPinEvent():
        return submitPin(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchApiEventCrud<T> value)? fetch,
    TResult? Function(GetAllApiEventCrud<T> value)? getAll,
    TResult? Function(ToggleApiEventCrud<T> value)? toggle,
    TResult? Function(SubmitApiEventCrud<T> value)? submit,
    TResult? Function(CreateApiEventCrud<T> value)? create,
    TResult? Function(UpdateApiEventCrud<T> value)? update,
    TResult? Function(DeleteApiEventCrud<T> value)? delete,
    TResult? Function(SelectedApiEventCrud<T> value)? selected,
    TResult? Function(PinpadAddKeyEvent<T> value)? addKey,
    TResult? Function(PinpadDeleteKeyEvent<T> value)? deleteKey,
    TResult? Function(PinpadClearEvent<T> value)? clear,
    TResult? Function(PinpadSubmitPinEvent<T> value)? submitPin,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud() when fetch != null:
        return fetch(_that);
      case GetAllApiEventCrud() when getAll != null:
        return getAll(_that);
      case ToggleApiEventCrud() when toggle != null:
        return toggle(_that);
      case SubmitApiEventCrud() when submit != null:
        return submit(_that);
      case CreateApiEventCrud() when create != null:
        return create(_that);
      case UpdateApiEventCrud() when update != null:
        return update(_that);
      case DeleteApiEventCrud() when delete != null:
        return delete(_that);
      case SelectedApiEventCrud() when selected != null:
        return selected(_that);
      case PinpadAddKeyEvent() when addKey != null:
        return addKey(_that);
      case PinpadDeleteKeyEvent() when deleteKey != null:
        return deleteKey(_that);
      case PinpadClearEvent() when clear != null:
        return clear(_that);
      case PinpadSubmitPinEvent() when submitPin != null:
        return submitPin(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? nd, String? code)? fetch,
    TResult Function(dynamic params)? getAll,
    TResult Function(dynamic params)? toggle,
    TResult Function()? submit,
    TResult Function(T data)? create,
    TResult Function(T? item, dynamic param)? update,
    TResult Function(dynamic id)? delete,
    TResult Function(int id, String? codeIntervention)? selected,
    TResult Function(String key)? addKey,
    TResult Function()? deleteKey,
    TResult Function()? clear,
    TResult Function()? submitPin,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud() when fetch != null:
        return fetch(_that.nd, _that.code);
      case GetAllApiEventCrud() when getAll != null:
        return getAll(_that.params);
      case ToggleApiEventCrud() when toggle != null:
        return toggle(_that.params);
      case SubmitApiEventCrud() when submit != null:
        return submit();
      case CreateApiEventCrud() when create != null:
        return create(_that.data);
      case UpdateApiEventCrud() when update != null:
        return update(_that.item, _that.param);
      case DeleteApiEventCrud() when delete != null:
        return delete(_that.id);
      case SelectedApiEventCrud() when selected != null:
        return selected(_that.id, _that.codeIntervention);
      case PinpadAddKeyEvent() when addKey != null:
        return addKey(_that.key);
      case PinpadDeleteKeyEvent() when deleteKey != null:
        return deleteKey();
      case PinpadClearEvent() when clear != null:
        return clear();
      case PinpadSubmitPinEvent() when submitPin != null:
        return submitPin();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? nd, String? code) fetch,
    required TResult Function(dynamic params) getAll,
    required TResult Function(dynamic params) toggle,
    required TResult Function() submit,
    required TResult Function(T data) create,
    required TResult Function(T? item, dynamic param) update,
    required TResult Function(dynamic id) delete,
    required TResult Function(int id, String? codeIntervention) selected,
    required TResult Function(String key) addKey,
    required TResult Function() deleteKey,
    required TResult Function() clear,
    required TResult Function() submitPin,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud():
        return fetch(_that.nd, _that.code);
      case GetAllApiEventCrud():
        return getAll(_that.params);
      case ToggleApiEventCrud():
        return toggle(_that.params);
      case SubmitApiEventCrud():
        return submit();
      case CreateApiEventCrud():
        return create(_that.data);
      case UpdateApiEventCrud():
        return update(_that.item, _that.param);
      case DeleteApiEventCrud():
        return delete(_that.id);
      case SelectedApiEventCrud():
        return selected(_that.id, _that.codeIntervention);
      case PinpadAddKeyEvent():
        return addKey(_that.key);
      case PinpadDeleteKeyEvent():
        return deleteKey();
      case PinpadClearEvent():
        return clear();
      case PinpadSubmitPinEvent():
        return submitPin();
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? nd, String? code)? fetch,
    TResult? Function(dynamic params)? getAll,
    TResult? Function(dynamic params)? toggle,
    TResult? Function()? submit,
    TResult? Function(T data)? create,
    TResult? Function(T? item, dynamic param)? update,
    TResult? Function(dynamic id)? delete,
    TResult? Function(int id, String? codeIntervention)? selected,
    TResult? Function(String key)? addKey,
    TResult? Function()? deleteKey,
    TResult? Function()? clear,
    TResult? Function()? submitPin,
  }) {
    final _that = this;
    switch (_that) {
      case FetchApiEventCrud() when fetch != null:
        return fetch(_that.nd, _that.code);
      case GetAllApiEventCrud() when getAll != null:
        return getAll(_that.params);
      case ToggleApiEventCrud() when toggle != null:
        return toggle(_that.params);
      case SubmitApiEventCrud() when submit != null:
        return submit();
      case CreateApiEventCrud() when create != null:
        return create(_that.data);
      case UpdateApiEventCrud() when update != null:
        return update(_that.item, _that.param);
      case DeleteApiEventCrud() when delete != null:
        return delete(_that.id);
      case SelectedApiEventCrud() when selected != null:
        return selected(_that.id, _that.codeIntervention);
      case PinpadAddKeyEvent() when addKey != null:
        return addKey(_that.key);
      case PinpadDeleteKeyEvent() when deleteKey != null:
        return deleteKey();
      case PinpadClearEvent() when clear != null:
        return clear();
      case PinpadSubmitPinEvent() when submitPin != null:
        return submitPin();
      case _:
        return null;
    }
  }
}

/// @nodoc

class FetchApiEventCrud<T> implements ApiEventCrud<T> {
  const FetchApiEventCrud([this.nd, this.code]);

  final String? nd;
  final String? code;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FetchApiEventCrudCopyWith<T, FetchApiEventCrud<T>> get copyWith =>
      _$FetchApiEventCrudCopyWithImpl<T, FetchApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FetchApiEventCrud<T> &&
            (identical(other.nd, nd) || other.nd == nd) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nd, code);

  @override
  String toString() {
    return 'ApiEventCrud<$T>.fetch(nd: $nd, code: $code)';
  }
}

/// @nodoc
abstract mixin class $FetchApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $FetchApiEventCrudCopyWith(FetchApiEventCrud<T> value,
          $Res Function(FetchApiEventCrud<T>) _then) =
      _$FetchApiEventCrudCopyWithImpl;
  @useResult
  $Res call({String? nd, String? code});
}

/// @nodoc
class _$FetchApiEventCrudCopyWithImpl<T, $Res>
    implements $FetchApiEventCrudCopyWith<T, $Res> {
  _$FetchApiEventCrudCopyWithImpl(this._self, this._then);

  final FetchApiEventCrud<T> _self;
  final $Res Function(FetchApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nd = freezed,
    Object? code = freezed,
  }) {
    return _then(FetchApiEventCrud<T>(
      freezed == nd
          ? _self.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class GetAllApiEventCrud<T> implements ApiEventCrud<T> {
  const GetAllApiEventCrud(this.params);

  final dynamic params;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetAllApiEventCrudCopyWith<T, GetAllApiEventCrud<T>> get copyWith =>
      _$GetAllApiEventCrudCopyWithImpl<T, GetAllApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetAllApiEventCrud<T> &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(params));

  @override
  String toString() {
    return 'ApiEventCrud<$T>.getAll(params: $params)';
  }
}

/// @nodoc
abstract mixin class $GetAllApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $GetAllApiEventCrudCopyWith(GetAllApiEventCrud<T> value,
          $Res Function(GetAllApiEventCrud<T>) _then) =
      _$GetAllApiEventCrudCopyWithImpl;
  @useResult
  $Res call({dynamic params});
}

/// @nodoc
class _$GetAllApiEventCrudCopyWithImpl<T, $Res>
    implements $GetAllApiEventCrudCopyWith<T, $Res> {
  _$GetAllApiEventCrudCopyWithImpl(this._self, this._then);

  final GetAllApiEventCrud<T> _self;
  final $Res Function(GetAllApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? params = freezed,
  }) {
    return _then(GetAllApiEventCrud<T>(
      freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class ToggleApiEventCrud<T> implements ApiEventCrud<T> {
  const ToggleApiEventCrud(this.params);

  final dynamic params;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToggleApiEventCrudCopyWith<T, ToggleApiEventCrud<T>> get copyWith =>
      _$ToggleApiEventCrudCopyWithImpl<T, ToggleApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToggleApiEventCrud<T> &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(params));

  @override
  String toString() {
    return 'ApiEventCrud<$T>.toggle(params: $params)';
  }
}

/// @nodoc
abstract mixin class $ToggleApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $ToggleApiEventCrudCopyWith(ToggleApiEventCrud<T> value,
          $Res Function(ToggleApiEventCrud<T>) _then) =
      _$ToggleApiEventCrudCopyWithImpl;
  @useResult
  $Res call({dynamic params});
}

/// @nodoc
class _$ToggleApiEventCrudCopyWithImpl<T, $Res>
    implements $ToggleApiEventCrudCopyWith<T, $Res> {
  _$ToggleApiEventCrudCopyWithImpl(this._self, this._then);

  final ToggleApiEventCrud<T> _self;
  final $Res Function(ToggleApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? params = freezed,
  }) {
    return _then(ToggleApiEventCrud<T>(
      freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class SubmitApiEventCrud<T> implements ApiEventCrud<T> {
  const SubmitApiEventCrud();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SubmitApiEventCrud<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventCrud<$T>.submit()';
  }
}

/// @nodoc

class CreateApiEventCrud<T> implements ApiEventCrud<T> {
  const CreateApiEventCrud(this.data);

  final T data;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateApiEventCrudCopyWith<T, CreateApiEventCrud<T>> get copyWith =>
      _$CreateApiEventCrudCopyWithImpl<T, CreateApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateApiEventCrud<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'ApiEventCrud<$T>.create(data: $data)';
  }
}

/// @nodoc
abstract mixin class $CreateApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $CreateApiEventCrudCopyWith(CreateApiEventCrud<T> value,
          $Res Function(CreateApiEventCrud<T>) _then) =
      _$CreateApiEventCrudCopyWithImpl;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$CreateApiEventCrudCopyWithImpl<T, $Res>
    implements $CreateApiEventCrudCopyWith<T, $Res> {
  _$CreateApiEventCrudCopyWithImpl(this._self, this._then);

  final CreateApiEventCrud<T> _self;
  final $Res Function(CreateApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(CreateApiEventCrud<T>(
      freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class UpdateApiEventCrud<T> implements ApiEventCrud<T> {
  const UpdateApiEventCrud({required this.item, required this.param});

  final T? item;
  final dynamic param;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateApiEventCrudCopyWith<T, UpdateApiEventCrud<T>> get copyWith =>
      _$UpdateApiEventCrudCopyWithImpl<T, UpdateApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateApiEventCrud<T> &&
            const DeepCollectionEquality().equals(other.item, item) &&
            const DeepCollectionEquality().equals(other.param, param));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(item),
      const DeepCollectionEquality().hash(param));

  @override
  String toString() {
    return 'ApiEventCrud<$T>.update(item: $item, param: $param)';
  }
}

/// @nodoc
abstract mixin class $UpdateApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $UpdateApiEventCrudCopyWith(UpdateApiEventCrud<T> value,
          $Res Function(UpdateApiEventCrud<T>) _then) =
      _$UpdateApiEventCrudCopyWithImpl;
  @useResult
  $Res call({T? item, dynamic param});
}

/// @nodoc
class _$UpdateApiEventCrudCopyWithImpl<T, $Res>
    implements $UpdateApiEventCrudCopyWith<T, $Res> {
  _$UpdateApiEventCrudCopyWithImpl(this._self, this._then);

  final UpdateApiEventCrud<T> _self;
  final $Res Function(UpdateApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = freezed,
    Object? param = freezed,
  }) {
    return _then(UpdateApiEventCrud<T>(
      item: freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as T?,
      param: freezed == param
          ? _self.param
          : param // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class DeleteApiEventCrud<T> implements ApiEventCrud<T> {
  const DeleteApiEventCrud(this.id);

  final dynamic id;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeleteApiEventCrudCopyWith<T, DeleteApiEventCrud<T>> get copyWith =>
      _$DeleteApiEventCrudCopyWithImpl<T, DeleteApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeleteApiEventCrud<T> &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @override
  String toString() {
    return 'ApiEventCrud<$T>.delete(id: $id)';
  }
}

/// @nodoc
abstract mixin class $DeleteApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $DeleteApiEventCrudCopyWith(DeleteApiEventCrud<T> value,
          $Res Function(DeleteApiEventCrud<T>) _then) =
      _$DeleteApiEventCrudCopyWithImpl;
  @useResult
  $Res call({dynamic id});
}

/// @nodoc
class _$DeleteApiEventCrudCopyWithImpl<T, $Res>
    implements $DeleteApiEventCrudCopyWith<T, $Res> {
  _$DeleteApiEventCrudCopyWithImpl(this._self, this._then);

  final DeleteApiEventCrud<T> _self;
  final $Res Function(DeleteApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
  }) {
    return _then(DeleteApiEventCrud<T>(
      freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class SelectedApiEventCrud<T> implements ApiEventCrud<T> {
  const SelectedApiEventCrud(this.id, this.codeIntervention);

  final int id;
  final String? codeIntervention;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectedApiEventCrudCopyWith<T, SelectedApiEventCrud<T>> get copyWith =>
      _$SelectedApiEventCrudCopyWithImpl<T, SelectedApiEventCrud<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectedApiEventCrud<T> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.codeIntervention, codeIntervention) ||
                other.codeIntervention == codeIntervention));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, codeIntervention);

  @override
  String toString() {
    return 'ApiEventCrud<$T>.selected(id: $id, codeIntervention: $codeIntervention)';
  }
}

/// @nodoc
abstract mixin class $SelectedApiEventCrudCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $SelectedApiEventCrudCopyWith(SelectedApiEventCrud<T> value,
          $Res Function(SelectedApiEventCrud<T>) _then) =
      _$SelectedApiEventCrudCopyWithImpl;
  @useResult
  $Res call({int id, String? codeIntervention});
}

/// @nodoc
class _$SelectedApiEventCrudCopyWithImpl<T, $Res>
    implements $SelectedApiEventCrudCopyWith<T, $Res> {
  _$SelectedApiEventCrudCopyWithImpl(this._self, this._then);

  final SelectedApiEventCrud<T> _self;
  final $Res Function(SelectedApiEventCrud<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? codeIntervention = freezed,
  }) {
    return _then(SelectedApiEventCrud<T>(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == codeIntervention
          ? _self.codeIntervention
          : codeIntervention // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class PinpadAddKeyEvent<T> implements ApiEventCrud<T> {
  const PinpadAddKeyEvent(this.key);

  final String key;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PinpadAddKeyEventCopyWith<T, PinpadAddKeyEvent<T>> get copyWith =>
      _$PinpadAddKeyEventCopyWithImpl<T, PinpadAddKeyEvent<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PinpadAddKeyEvent<T> &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'ApiEventCrud<$T>.addKey(key: $key)';
  }
}

/// @nodoc
abstract mixin class $PinpadAddKeyEventCopyWith<T, $Res>
    implements $ApiEventCrudCopyWith<T, $Res> {
  factory $PinpadAddKeyEventCopyWith(PinpadAddKeyEvent<T> value,
          $Res Function(PinpadAddKeyEvent<T>) _then) =
      _$PinpadAddKeyEventCopyWithImpl;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$PinpadAddKeyEventCopyWithImpl<T, $Res>
    implements $PinpadAddKeyEventCopyWith<T, $Res> {
  _$PinpadAddKeyEventCopyWithImpl(this._self, this._then);

  final PinpadAddKeyEvent<T> _self;
  final $Res Function(PinpadAddKeyEvent<T>) _then;

  /// Create a copy of ApiEventCrud
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(PinpadAddKeyEvent<T>(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class PinpadDeleteKeyEvent<T> implements ApiEventCrud<T> {
  const PinpadDeleteKeyEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PinpadDeleteKeyEvent<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventCrud<$T>.deleteKey()';
  }
}

/// @nodoc

class PinpadClearEvent<T> implements ApiEventCrud<T> {
  const PinpadClearEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PinpadClearEvent<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventCrud<$T>.clear()';
  }
}

/// @nodoc

class PinpadSubmitPinEvent<T> implements ApiEventCrud<T> {
  const PinpadSubmitPinEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PinpadSubmitPinEvent<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiEventCrud<$T>.submitPin()';
  }
}

// dart format on
