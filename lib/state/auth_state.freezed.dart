// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(CountryWithPhoneCode country) ready,
    required TResult Function(String errorText) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateInitializing value) initializing,
    required TResult Function(_AuthStateReady value) ready,
    required TResult Function(_AuthStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$$_AuthStateInitializingCopyWith<$Res> {
  factory _$$_AuthStateInitializingCopyWith(_$_AuthStateInitializing value,
          $Res Function(_$_AuthStateInitializing) then) =
      __$$_AuthStateInitializingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthStateInitializingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_AuthStateInitializingCopyWith<$Res> {
  __$$_AuthStateInitializingCopyWithImpl(_$_AuthStateInitializing _value,
      $Res Function(_$_AuthStateInitializing) _then)
      : super(_value, (v) => _then(v as _$_AuthStateInitializing));

  @override
  _$_AuthStateInitializing get _value =>
      super._value as _$_AuthStateInitializing;
}

/// @nodoc

class _$_AuthStateInitializing implements _AuthStateInitializing {
  const _$_AuthStateInitializing();

  @override
  String toString() {
    return 'AuthState.initializing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthStateInitializing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(CountryWithPhoneCode country) ready,
    required TResult Function(String errorText) error,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateInitializing value) initializing,
    required TResult Function(_AuthStateReady value) ready,
    required TResult Function(_AuthStateError value) error,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class _AuthStateInitializing implements AuthState {
  const factory _AuthStateInitializing() = _$_AuthStateInitializing;
}

/// @nodoc
abstract class _$$_AuthStateReadyCopyWith<$Res> {
  factory _$$_AuthStateReadyCopyWith(
          _$_AuthStateReady value, $Res Function(_$_AuthStateReady) then) =
      __$$_AuthStateReadyCopyWithImpl<$Res>;
  $Res call({CountryWithPhoneCode country});
}

/// @nodoc
class __$$_AuthStateReadyCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_AuthStateReadyCopyWith<$Res> {
  __$$_AuthStateReadyCopyWithImpl(
      _$_AuthStateReady _value, $Res Function(_$_AuthStateReady) _then)
      : super(_value, (v) => _then(v as _$_AuthStateReady));

  @override
  _$_AuthStateReady get _value => super._value as _$_AuthStateReady;

  @override
  $Res call({
    Object? country = freezed,
  }) {
    return _then(_$_AuthStateReady(
      country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as CountryWithPhoneCode,
    ));
  }
}

/// @nodoc

class _$_AuthStateReady implements _AuthStateReady {
  const _$_AuthStateReady(this.country);

  @override
  final CountryWithPhoneCode country;

  @override
  String toString() {
    return 'AuthState.ready(country: $country)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateReady &&
            const DeepCollectionEquality().equals(other.country, country));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(country));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStateReadyCopyWith<_$_AuthStateReady> get copyWith =>
      __$$_AuthStateReadyCopyWithImpl<_$_AuthStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(CountryWithPhoneCode country) ready,
    required TResult Function(String errorText) error,
  }) {
    return ready(country);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
  }) {
    return ready?.call(country);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(country);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateInitializing value) initializing,
    required TResult Function(_AuthStateReady value) ready,
    required TResult Function(_AuthStateError value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _AuthStateReady implements AuthState {
  const factory _AuthStateReady(final CountryWithPhoneCode country) =
      _$_AuthStateReady;

  CountryWithPhoneCode get country;
  @JsonKey(ignore: true)
  _$$_AuthStateReadyCopyWith<_$_AuthStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthStateErrorCopyWith<$Res> {
  factory _$$_AuthStateErrorCopyWith(
          _$_AuthStateError value, $Res Function(_$_AuthStateError) then) =
      __$$_AuthStateErrorCopyWithImpl<$Res>;
  $Res call({String errorText});
}

/// @nodoc
class __$$_AuthStateErrorCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_AuthStateErrorCopyWith<$Res> {
  __$$_AuthStateErrorCopyWithImpl(
      _$_AuthStateError _value, $Res Function(_$_AuthStateError) _then)
      : super(_value, (v) => _then(v as _$_AuthStateError));

  @override
  _$_AuthStateError get _value => super._value as _$_AuthStateError;

  @override
  $Res call({
    Object? errorText = freezed,
  }) {
    return _then(_$_AuthStateError(
      errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthStateError implements _AuthStateError {
  const _$_AuthStateError(this.errorText);

  @override
  final String errorText;

  @override
  String toString() {
    return 'AuthState.error(errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateError &&
            const DeepCollectionEquality().equals(other.errorText, errorText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(errorText));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      __$$_AuthStateErrorCopyWithImpl<_$_AuthStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(CountryWithPhoneCode country) ready,
    required TResult Function(String errorText) error,
  }) {
    return error(errorText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
  }) {
    return error?.call(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(CountryWithPhoneCode country)? ready,
    TResult Function(String errorText)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateInitializing value) initializing,
    required TResult Function(_AuthStateReady value) ready,
    required TResult Function(_AuthStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateInitializing value)? initializing,
    TResult Function(_AuthStateReady value)? ready,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthStateError implements AuthState {
  const factory _AuthStateError(final String errorText) = _$_AuthStateError;

  String get errorText;
  @JsonKey(ignore: true)
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
