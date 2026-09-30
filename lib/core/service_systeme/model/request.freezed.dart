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
  dynamic get data;
  String? get user;
  String? get deviceId;
  String get serviceLibelle;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestCopyWith<T, Request<T>> get copyWith =>
      _$RequestCopyWithImpl<T, Request<T>>(this as Request<T>, _$identity);

  /// Serializes this Request to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Request<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      user,
      deviceId,
      serviceLibelle);

  @override
  String toString() {
    return 'Request<$T>(data: $data, user: $user, deviceId: $deviceId, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestCopyWith<T, $Res> {
  factory $RequestCopyWith(Request<T> value, $Res Function(Request<T>) _then) =
      _$RequestCopyWithImpl;
  @useResult
  $Res call(
      {dynamic data, String? user, String? deviceId, String serviceLibelle});
}

/// @nodoc
class _$RequestCopyWithImpl<T, $Res> implements $RequestCopyWith<T, $Res> {
  _$RequestCopyWithImpl(this._self, this._then);

  final Request<T> _self;
  final $Res Function(Request<T>) _then;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? user = freezed,
    Object? deviceId = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Request<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Request() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_Request<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Request():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Request<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Request() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(dynamic data, String? user, String? deviceId,
            String serviceLibelle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Request() when $default != null:
        return $default(
            _that.data, _that.user, _that.deviceId, _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            dynamic data, String? user, String? deviceId, String serviceLibelle)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Request():
        return $default(
            _that.data, _that.user, _that.deviceId, _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(dynamic data, String? user, String? deviceId,
            String serviceLibelle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Request() when $default != null:
        return $default(
            _that.data, _that.user, _that.deviceId, _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Request<T> implements Request<T> {
  _Request(
      {required this.data,
      this.user,
      this.deviceId,
      required this.serviceLibelle});
  factory _Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  @override
  final dynamic data;
  @override
  final String? user;
  @override
  final String? deviceId;
  @override
  final String serviceLibelle;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestCopyWith<T, _Request<T>> get copyWith =>
      __$RequestCopyWithImpl<T, _Request<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Request<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      user,
      deviceId,
      serviceLibelle);

  @override
  String toString() {
    return 'Request<$T>(data: $data, user: $user, deviceId: $deviceId, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestCopyWith<T, $Res>
    implements $RequestCopyWith<T, $Res> {
  factory _$RequestCopyWith(
          _Request<T> value, $Res Function(_Request<T>) _then) =
      __$RequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {dynamic data, String? user, String? deviceId, String serviceLibelle});
}

/// @nodoc
class __$RequestCopyWithImpl<T, $Res> implements _$RequestCopyWith<T, $Res> {
  __$RequestCopyWithImpl(this._self, this._then);

  final _Request<T> _self;
  final $Res Function(_Request<T>) _then;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? user = freezed,
    Object? deviceId = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_Request<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestPaginate<T> {
  int get size;
  int get index;
  dynamic get data;
  String get user;
  String get serviceLibelle;

  /// Create a copy of RequestPaginate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestPaginateCopyWith<T, RequestPaginate<T>> get copyWith =>
      _$RequestPaginateCopyWithImpl<T, RequestPaginate<T>>(
          this as RequestPaginate<T>, _$identity);

  /// Serializes this RequestPaginate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestPaginate<T> &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, size, index,
      const DeepCollectionEquality().hash(data), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestPaginate<$T>(size: $size, index: $index, data: $data, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestPaginateCopyWith<T, $Res> {
  factory $RequestPaginateCopyWith(
          RequestPaginate<T> value, $Res Function(RequestPaginate<T>) _then) =
      _$RequestPaginateCopyWithImpl;
  @useResult
  $Res call(
      {int size, int index, dynamic data, String user, String serviceLibelle});
}

/// @nodoc
class _$RequestPaginateCopyWithImpl<T, $Res>
    implements $RequestPaginateCopyWith<T, $Res> {
  _$RequestPaginateCopyWithImpl(this._self, this._then);

  final RequestPaginate<T> _self;
  final $Res Function(RequestPaginate<T>) _then;

  /// Create a copy of RequestPaginate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? index = null,
    Object? data = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestPaginate].
extension RequestPaginatePatterns<T> on RequestPaginate<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestPaginate<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestPaginate<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestPaginate<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int size, int index, dynamic data, String user,
            String serviceLibelle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate() when $default != null:
        return $default(_that.size, _that.index, _that.data, _that.user,
            _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(int size, int index, dynamic data, String user,
            String serviceLibelle)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate():
        return $default(_that.size, _that.index, _that.data, _that.user,
            _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int size, int index, dynamic data, String user,
            String serviceLibelle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestPaginate() when $default != null:
        return $default(_that.size, _that.index, _that.data, _that.user,
            _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestPaginate<T> implements RequestPaginate<T> {
  _RequestPaginate(
      {required this.size,
      required this.index,
      required this.data,
      required this.user,
      required this.serviceLibelle});
  factory _RequestPaginate.fromJson(Map<String, dynamic> json) =>
      _$RequestPaginateFromJson(json);

  @override
  final int size;
  @override
  final int index;
  @override
  final dynamic data;
  @override
  final String user;
  @override
  final String serviceLibelle;

  /// Create a copy of RequestPaginate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestPaginateCopyWith<T, _RequestPaginate<T>> get copyWith =>
      __$RequestPaginateCopyWithImpl<T, _RequestPaginate<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestPaginateToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestPaginate<T> &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, size, index,
      const DeepCollectionEquality().hash(data), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestPaginate<$T>(size: $size, index: $index, data: $data, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestPaginateCopyWith<T, $Res>
    implements $RequestPaginateCopyWith<T, $Res> {
  factory _$RequestPaginateCopyWith(
          _RequestPaginate<T> value, $Res Function(_RequestPaginate<T>) _then) =
      __$RequestPaginateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int size, int index, dynamic data, String user, String serviceLibelle});
}

/// @nodoc
class __$RequestPaginateCopyWithImpl<T, $Res>
    implements _$RequestPaginateCopyWith<T, $Res> {
  __$RequestPaginateCopyWithImpl(this._self, this._then);

  final _RequestPaginate<T> _self;
  final $Res Function(_RequestPaginate<T>) _then;

  /// Create a copy of RequestPaginate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? size = null,
    Object? index = null,
    Object? data = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_RequestPaginate<T>(
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestWithoutUser<T> {
  dynamic get data;
  String get serviceLibelle;

  /// Create a copy of RequestWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestWithoutUserCopyWith<T, RequestWithoutUser<T>> get copyWith =>
      _$RequestWithoutUserCopyWithImpl<T, RequestWithoutUser<T>>(
          this as RequestWithoutUser<T>, _$identity);

  /// Serializes this RequestWithoutUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestWithoutUser<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), serviceLibelle);

  @override
  String toString() {
    return 'RequestWithoutUser<$T>(data: $data, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestWithoutUserCopyWith<T, $Res> {
  factory $RequestWithoutUserCopyWith(RequestWithoutUser<T> value,
          $Res Function(RequestWithoutUser<T>) _then) =
      _$RequestWithoutUserCopyWithImpl;
  @useResult
  $Res call({dynamic data, String serviceLibelle});
}

/// @nodoc
class _$RequestWithoutUserCopyWithImpl<T, $Res>
    implements $RequestWithoutUserCopyWith<T, $Res> {
  _$RequestWithoutUserCopyWithImpl(this._self, this._then);

  final RequestWithoutUser<T> _self;
  final $Res Function(RequestWithoutUser<T>) _then;

  /// Create a copy of RequestWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestWithoutUser].
extension RequestWithoutUserPatterns<T> on RequestWithoutUser<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestWithoutUser<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestWithoutUser<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestWithoutUser<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(dynamic data, String serviceLibelle)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser() when $default != null:
        return $default(_that.data, _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(dynamic data, String serviceLibelle) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser():
        return $default(_that.data, _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(dynamic data, String serviceLibelle)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWithoutUser() when $default != null:
        return $default(_that.data, _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestWithoutUser<T> implements RequestWithoutUser<T> {
  _RequestWithoutUser({required this.data, required this.serviceLibelle});
  factory _RequestWithoutUser.fromJson(Map<String, dynamic> json) =>
      _$RequestWithoutUserFromJson(json);

  @override
  final dynamic data;
  @override
  final String serviceLibelle;

  /// Create a copy of RequestWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestWithoutUserCopyWith<T, _RequestWithoutUser<T>> get copyWith =>
      __$RequestWithoutUserCopyWithImpl<T, _RequestWithoutUser<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestWithoutUserToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestWithoutUser<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), serviceLibelle);

  @override
  String toString() {
    return 'RequestWithoutUser<$T>(data: $data, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestWithoutUserCopyWith<T, $Res>
    implements $RequestWithoutUserCopyWith<T, $Res> {
  factory _$RequestWithoutUserCopyWith(_RequestWithoutUser<T> value,
          $Res Function(_RequestWithoutUser<T>) _then) =
      __$RequestWithoutUserCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic data, String serviceLibelle});
}

/// @nodoc
class __$RequestWithoutUserCopyWithImpl<T, $Res>
    implements _$RequestWithoutUserCopyWith<T, $Res> {
  __$RequestWithoutUserCopyWithImpl(this._self, this._then);

  final _RequestWithoutUser<T> _self;
  final $Res Function(_RequestWithoutUser<T>) _then;

  /// Create a copy of RequestWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_RequestWithoutUser<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestWrapper<T> {
  dynamic get data;
  String get user;
  String get serviceLibelle;

  /// Create a copy of RequestWrapper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestWrapperCopyWith<T, RequestWrapper<T>> get copyWith =>
      _$RequestWrapperCopyWithImpl<T, RequestWrapper<T>>(
          this as RequestWrapper<T>, _$identity);

  /// Serializes this RequestWrapper to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestWrapper<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestWrapper<$T>(data: $data, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestWrapperCopyWith<T, $Res> {
  factory $RequestWrapperCopyWith(
          RequestWrapper<T> value, $Res Function(RequestWrapper<T>) _then) =
      _$RequestWrapperCopyWithImpl;
  @useResult
  $Res call({dynamic data, String user, String serviceLibelle});
}

/// @nodoc
class _$RequestWrapperCopyWithImpl<T, $Res>
    implements $RequestWrapperCopyWith<T, $Res> {
  _$RequestWrapperCopyWithImpl(this._self, this._then);

  final RequestWrapper<T> _self;
  final $Res Function(RequestWrapper<T>) _then;

  /// Create a copy of RequestWrapper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestWrapper].
extension RequestWrapperPatterns<T> on RequestWrapper<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestWrapper<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestWrapper<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestWrapper<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(dynamic data, String user, String serviceLibelle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper() when $default != null:
        return $default(_that.data, _that.user, _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(dynamic data, String user, String serviceLibelle) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper():
        return $default(_that.data, _that.user, _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(dynamic data, String user, String serviceLibelle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestWrapper() when $default != null:
        return $default(_that.data, _that.user, _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestWrapper<T> implements RequestWrapper<T> {
  _RequestWrapper(
      {required this.data, required this.user, required this.serviceLibelle});
  factory _RequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$RequestWrapperFromJson(json);

  @override
  final dynamic data;
  @override
  final String user;
  @override
  final String serviceLibelle;

  /// Create a copy of RequestWrapper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestWrapperCopyWith<T, _RequestWrapper<T>> get copyWith =>
      __$RequestWrapperCopyWithImpl<T, _RequestWrapper<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestWrapperToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestWrapper<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestWrapper<$T>(data: $data, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestWrapperCopyWith<T, $Res>
    implements $RequestWrapperCopyWith<T, $Res> {
  factory _$RequestWrapperCopyWith(
          _RequestWrapper<T> value, $Res Function(_RequestWrapper<T>) _then) =
      __$RequestWrapperCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic data, String user, String serviceLibelle});
}

/// @nodoc
class __$RequestWrapperCopyWithImpl<T, $Res>
    implements _$RequestWrapperCopyWith<T, $Res> {
  __$RequestWrapperCopyWithImpl(this._self, this._then);

  final _RequestWrapper<T> _self;
  final $Res Function(_RequestWrapper<T>) _then;

  /// Create a copy of RequestWrapper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_RequestWrapper<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestDatas<T> {
  dynamic get datas;
  String get user;
  String get serviceLibelle;

  /// Create a copy of RequestDatas
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestDatasCopyWith<T, RequestDatas<T>> get copyWith =>
      _$RequestDatasCopyWithImpl<T, RequestDatas<T>>(
          this as RequestDatas<T>, _$identity);

  /// Serializes this RequestDatas to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestDatas<T> &&
            const DeepCollectionEquality().equals(other.datas, datas) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(datas), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestDatas<$T>(datas: $datas, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestDatasCopyWith<T, $Res> {
  factory $RequestDatasCopyWith(
          RequestDatas<T> value, $Res Function(RequestDatas<T>) _then) =
      _$RequestDatasCopyWithImpl;
  @useResult
  $Res call({dynamic datas, String user, String serviceLibelle});
}

/// @nodoc
class _$RequestDatasCopyWithImpl<T, $Res>
    implements $RequestDatasCopyWith<T, $Res> {
  _$RequestDatasCopyWithImpl(this._self, this._then);

  final RequestDatas<T> _self;
  final $Res Function(RequestDatas<T>) _then;

  /// Create a copy of RequestDatas
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datas = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      datas: freezed == datas
          ? _self.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestDatas].
extension RequestDatasPatterns<T> on RequestDatas<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestDatas<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestDatas() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestDatas<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatas():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestDatas<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatas() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(dynamic datas, String user, String serviceLibelle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestDatas() when $default != null:
        return $default(_that.datas, _that.user, _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(dynamic datas, String user, String serviceLibelle)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatas():
        return $default(_that.datas, _that.user, _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(dynamic datas, String user, String serviceLibelle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatas() when $default != null:
        return $default(_that.datas, _that.user, _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestDatas<T> implements RequestDatas<T> {
  _RequestDatas(
      {required this.datas, required this.user, required this.serviceLibelle});
  factory _RequestDatas.fromJson(Map<String, dynamic> json) =>
      _$RequestDatasFromJson(json);

  @override
  final dynamic datas;
  @override
  final String user;
  @override
  final String serviceLibelle;

  /// Create a copy of RequestDatas
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestDatasCopyWith<T, _RequestDatas<T>> get copyWith =>
      __$RequestDatasCopyWithImpl<T, _RequestDatas<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestDatasToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestDatas<T> &&
            const DeepCollectionEquality().equals(other.datas, datas) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(datas), user, serviceLibelle);

  @override
  String toString() {
    return 'RequestDatas<$T>(datas: $datas, user: $user, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestDatasCopyWith<T, $Res>
    implements $RequestDatasCopyWith<T, $Res> {
  factory _$RequestDatasCopyWith(
          _RequestDatas<T> value, $Res Function(_RequestDatas<T>) _then) =
      __$RequestDatasCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic datas, String user, String serviceLibelle});
}

/// @nodoc
class __$RequestDatasCopyWithImpl<T, $Res>
    implements _$RequestDatasCopyWith<T, $Res> {
  __$RequestDatasCopyWithImpl(this._self, this._then);

  final _RequestDatas<T> _self;
  final $Res Function(_RequestDatas<T>) _then;

  /// Create a copy of RequestDatas
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? datas = freezed,
    Object? user = null,
    Object? serviceLibelle = null,
  }) {
    return _then(_RequestDatas<T>(
      datas: freezed == datas
          ? _self.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestDatasWithoutUser<T> {
  String? get user;
  dynamic get datas;
  String get serviceLibelle;

  /// Create a copy of RequestDatasWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestDatasWithoutUserCopyWith<T, RequestDatasWithoutUser<T>>
      get copyWith =>
          _$RequestDatasWithoutUserCopyWithImpl<T, RequestDatasWithoutUser<T>>(
              this as RequestDatasWithoutUser<T>, _$identity);

  /// Serializes this RequestDatasWithoutUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestDatasWithoutUser<T> &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other.datas, datas) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user,
      const DeepCollectionEquality().hash(datas), serviceLibelle);

  @override
  String toString() {
    return 'RequestDatasWithoutUser<$T>(user: $user, datas: $datas, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class $RequestDatasWithoutUserCopyWith<T, $Res> {
  factory $RequestDatasWithoutUserCopyWith(RequestDatasWithoutUser<T> value,
          $Res Function(RequestDatasWithoutUser<T>) _then) =
      _$RequestDatasWithoutUserCopyWithImpl;
  @useResult
  $Res call({String? user, dynamic datas, String serviceLibelle});
}

/// @nodoc
class _$RequestDatasWithoutUserCopyWithImpl<T, $Res>
    implements $RequestDatasWithoutUserCopyWith<T, $Res> {
  _$RequestDatasWithoutUserCopyWithImpl(this._self, this._then);

  final RequestDatasWithoutUser<T> _self;
  final $Res Function(RequestDatasWithoutUser<T>) _then;

  /// Create a copy of RequestDatasWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? datas = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_self.copyWith(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      datas: freezed == datas
          ? _self.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestDatasWithoutUser].
extension RequestDatasWithoutUserPatterns<T> on RequestDatasWithoutUser<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestDatasWithoutUser<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestDatasWithoutUser<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestDatasWithoutUser<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? user, dynamic datas, String serviceLibelle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser() when $default != null:
        return $default(_that.user, _that.datas, _that.serviceLibelle);
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
  TResult when<TResult extends Object?>(
    TResult Function(String? user, dynamic datas, String serviceLibelle)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser():
        return $default(_that.user, _that.datas, _that.serviceLibelle);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? user, dynamic datas, String serviceLibelle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestDatasWithoutUser() when $default != null:
        return $default(_that.user, _that.datas, _that.serviceLibelle);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestDatasWithoutUser<T> implements RequestDatasWithoutUser<T> {
  _RequestDatasWithoutUser(
      {required this.user, required this.datas, required this.serviceLibelle});
  factory _RequestDatasWithoutUser.fromJson(Map<String, dynamic> json) =>
      _$RequestDatasWithoutUserFromJson(json);

  @override
  final String? user;
  @override
  final dynamic datas;
  @override
  final String serviceLibelle;

  /// Create a copy of RequestDatasWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestDatasWithoutUserCopyWith<T, _RequestDatasWithoutUser<T>>
      get copyWith => __$RequestDatasWithoutUserCopyWithImpl<T,
          _RequestDatasWithoutUser<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestDatasWithoutUserToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestDatasWithoutUser<T> &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other.datas, datas) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user,
      const DeepCollectionEquality().hash(datas), serviceLibelle);

  @override
  String toString() {
    return 'RequestDatasWithoutUser<$T>(user: $user, datas: $datas, serviceLibelle: $serviceLibelle)';
  }
}

/// @nodoc
abstract mixin class _$RequestDatasWithoutUserCopyWith<T, $Res>
    implements $RequestDatasWithoutUserCopyWith<T, $Res> {
  factory _$RequestDatasWithoutUserCopyWith(_RequestDatasWithoutUser<T> value,
          $Res Function(_RequestDatasWithoutUser<T>) _then) =
      __$RequestDatasWithoutUserCopyWithImpl;
  @override
  @useResult
  $Res call({String? user, dynamic datas, String serviceLibelle});
}

/// @nodoc
class __$RequestDatasWithoutUserCopyWithImpl<T, $Res>
    implements _$RequestDatasWithoutUserCopyWith<T, $Res> {
  __$RequestDatasWithoutUserCopyWithImpl(this._self, this._then);

  final _RequestDatasWithoutUser<T> _self;
  final $Res Function(_RequestDatasWithoutUser<T>) _then;

  /// Create a copy of RequestDatasWithoutUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = freezed,
    Object? datas = freezed,
    Object? serviceLibelle = null,
  }) {
    return _then(_RequestDatasWithoutUser<T>(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      datas: freezed == datas
          ? _self.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RequestAuth<T> {
  String? get user;
  dynamic get data;
  String get serviceLibelle;
  String get key;

  /// Create a copy of RequestAuth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestAuthCopyWith<T, RequestAuth<T>> get copyWith =>
      _$RequestAuthCopyWithImpl<T, RequestAuth<T>>(
          this as RequestAuth<T>, _$identity);

  /// Serializes this RequestAuth to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestAuth<T> &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user,
      const DeepCollectionEquality().hash(data), serviceLibelle, key);

  @override
  String toString() {
    return 'RequestAuth<$T>(user: $user, data: $data, serviceLibelle: $serviceLibelle, key: $key)';
  }
}

/// @nodoc
abstract mixin class $RequestAuthCopyWith<T, $Res> {
  factory $RequestAuthCopyWith(
          RequestAuth<T> value, $Res Function(RequestAuth<T>) _then) =
      _$RequestAuthCopyWithImpl;
  @useResult
  $Res call({String? user, dynamic data, String serviceLibelle, String key});
}

/// @nodoc
class _$RequestAuthCopyWithImpl<T, $Res>
    implements $RequestAuthCopyWith<T, $Res> {
  _$RequestAuthCopyWithImpl(this._self, this._then);

  final RequestAuth<T> _self;
  final $Res Function(RequestAuth<T>) _then;

  /// Create a copy of RequestAuth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? data = freezed,
    Object? serviceLibelle = null,
    Object? key = null,
  }) {
    return _then(_self.copyWith(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequestAuth].
extension RequestAuthPatterns<T> on RequestAuth<T> {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RequestAuth<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestAuth() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_RequestAuth<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestAuth():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RequestAuth<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestAuth() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? user, dynamic data, String serviceLibelle, String key)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequestAuth() when $default != null:
        return $default(
            _that.user, _that.data, _that.serviceLibelle, _that.key);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            String? user, dynamic data, String serviceLibelle, String key)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestAuth():
        return $default(
            _that.user, _that.data, _that.serviceLibelle, _that.key);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? user, dynamic data, String serviceLibelle, String key)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequestAuth() when $default != null:
        return $default(
            _that.user, _that.data, _that.serviceLibelle, _that.key);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RequestAuth<T> implements RequestAuth<T> {
  _RequestAuth(
      {required this.user,
      required this.data,
      required this.serviceLibelle,
      this.key = '11234567896587452365879654123698'});
  factory _RequestAuth.fromJson(Map<String, dynamic> json) =>
      _$RequestAuthFromJson(json);

  @override
  final String? user;
  @override
  final dynamic data;
  @override
  final String serviceLibelle;
  @override
  @JsonKey()
  final String key;

  /// Create a copy of RequestAuth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestAuthCopyWith<T, _RequestAuth<T>> get copyWith =>
      __$RequestAuthCopyWithImpl<T, _RequestAuth<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestAuthToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestAuth<T> &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.serviceLibelle, serviceLibelle) ||
                other.serviceLibelle == serviceLibelle) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user,
      const DeepCollectionEquality().hash(data), serviceLibelle, key);

  @override
  String toString() {
    return 'RequestAuth<$T>(user: $user, data: $data, serviceLibelle: $serviceLibelle, key: $key)';
  }
}

/// @nodoc
abstract mixin class _$RequestAuthCopyWith<T, $Res>
    implements $RequestAuthCopyWith<T, $Res> {
  factory _$RequestAuthCopyWith(
          _RequestAuth<T> value, $Res Function(_RequestAuth<T>) _then) =
      __$RequestAuthCopyWithImpl;
  @override
  @useResult
  $Res call({String? user, dynamic data, String serviceLibelle, String key});
}

/// @nodoc
class __$RequestAuthCopyWithImpl<T, $Res>
    implements _$RequestAuthCopyWith<T, $Res> {
  __$RequestAuthCopyWithImpl(this._self, this._then);

  final _RequestAuth<T> _self;
  final $Res Function(_RequestAuth<T>) _then;

  /// Create a copy of RequestAuth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = freezed,
    Object? data = freezed,
    Object? serviceLibelle = null,
    Object? key = null,
  }) {
    return _then(_RequestAuth<T>(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      serviceLibelle: null == serviceLibelle
          ? _self.serviceLibelle
          : serviceLibelle // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
