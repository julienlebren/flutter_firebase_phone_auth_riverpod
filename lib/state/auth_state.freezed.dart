// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

// ignore: unused_element
  _AuthStateInitializing initializing() {
    return const _AuthStateInitializing();
  }

// ignore: unused_element
  _AuthStateReady ready(CountryWithPhoneCode country) {
    return _AuthStateReady(
      country,
    );
  }

// ignore: unused_element
  _AuthStateError error(String errorText) {
    return _AuthStateError(
      errorText,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initializing(),
    @required TResult ready(CountryWithPhoneCode country),
    @required TResult error(String errorText),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initializing(),
    TResult ready(CountryWithPhoneCode country),
    TResult error(String errorText),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initializing(_AuthStateInitializing value),
    @required TResult ready(_AuthStateReady value),
    @required TResult error(_AuthStateError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initializing(_AuthStateInitializing value),
    TResult ready(_AuthStateReady value),
    TResult error(_AuthStateError value),
    @required TResult orElse(),
  });
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
abstract class _$AuthStateInitializingCopyWith<$Res> {
  factory _$AuthStateInitializingCopyWith(_AuthStateInitializing value,
          $Res Function(_AuthStateInitializing) then) =
      __$AuthStateInitializingCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthStateInitializingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateInitializingCopyWith<$Res> {
  __$AuthStateInitializingCopyWithImpl(_AuthStateInitializing _value,
      $Res Function(_AuthStateInitializing) _then)
      : super(_value, (v) => _then(v as _AuthStateInitializing));

  @override
  _AuthStateInitializing get _value => super._value as _AuthStateInitializing;
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
    return identical(this, other) || (other is _AuthStateInitializing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initializing(),
    @required TResult ready(CountryWithPhoneCode country),
    @required TResult error(String errorText),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initializing(),
    TResult ready(CountryWithPhoneCode country),
    TResult error(String errorText),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initializing(_AuthStateInitializing value),
    @required TResult ready(_AuthStateReady value),
    @required TResult error(_AuthStateError value),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initializing(_AuthStateInitializing value),
    TResult ready(_AuthStateReady value),
    TResult error(_AuthStateError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
abstract class _$AuthStateReadyCopyWith<$Res> {
  factory _$AuthStateReadyCopyWith(
          _AuthStateReady value, $Res Function(_AuthStateReady) then) =
      __$AuthStateReadyCopyWithImpl<$Res>;
  $Res call({CountryWithPhoneCode country});
}

/// @nodoc
class __$AuthStateReadyCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateReadyCopyWith<$Res> {
  __$AuthStateReadyCopyWithImpl(
      _AuthStateReady _value, $Res Function(_AuthStateReady) _then)
      : super(_value, (v) => _then(v as _AuthStateReady));

  @override
  _AuthStateReady get _value => super._value as _AuthStateReady;

  @override
  $Res call({
    Object country = freezed,
  }) {
    return _then(_AuthStateReady(
      country == freezed ? _value.country : country as CountryWithPhoneCode,
    ));
  }
}

/// @nodoc
class _$_AuthStateReady implements _AuthStateReady {
  const _$_AuthStateReady(this.country) : assert(country != null);

  @override
  final CountryWithPhoneCode country;

  @override
  String toString() {
    return 'AuthState.ready(country: $country)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthStateReady &&
            (identical(other.country, country) ||
                const DeepCollectionEquality().equals(other.country, country)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(country);

  @JsonKey(ignore: true)
  @override
  _$AuthStateReadyCopyWith<_AuthStateReady> get copyWith =>
      __$AuthStateReadyCopyWithImpl<_AuthStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initializing(),
    @required TResult ready(CountryWithPhoneCode country),
    @required TResult error(String errorText),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return ready(country);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initializing(),
    TResult ready(CountryWithPhoneCode country),
    TResult error(String errorText),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(country);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initializing(_AuthStateInitializing value),
    @required TResult ready(_AuthStateReady value),
    @required TResult error(_AuthStateError value),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initializing(_AuthStateInitializing value),
    TResult ready(_AuthStateReady value),
    TResult error(_AuthStateError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _AuthStateReady implements AuthState {
  const factory _AuthStateReady(CountryWithPhoneCode country) =
      _$_AuthStateReady;

  CountryWithPhoneCode get country;
  @JsonKey(ignore: true)
  _$AuthStateReadyCopyWith<_AuthStateReady> get copyWith;
}

/// @nodoc
abstract class _$AuthStateErrorCopyWith<$Res> {
  factory _$AuthStateErrorCopyWith(
          _AuthStateError value, $Res Function(_AuthStateError) then) =
      __$AuthStateErrorCopyWithImpl<$Res>;
  $Res call({String errorText});
}

/// @nodoc
class __$AuthStateErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateErrorCopyWith<$Res> {
  __$AuthStateErrorCopyWithImpl(
      _AuthStateError _value, $Res Function(_AuthStateError) _then)
      : super(_value, (v) => _then(v as _AuthStateError));

  @override
  _AuthStateError get _value => super._value as _AuthStateError;

  @override
  $Res call({
    Object errorText = freezed,
  }) {
    return _then(_AuthStateError(
      errorText == freezed ? _value.errorText : errorText as String,
    ));
  }
}

/// @nodoc
class _$_AuthStateError implements _AuthStateError {
  const _$_AuthStateError(this.errorText) : assert(errorText != null);

  @override
  final String errorText;

  @override
  String toString() {
    return 'AuthState.error(errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthStateError &&
            (identical(other.errorText, errorText) ||
                const DeepCollectionEquality()
                    .equals(other.errorText, errorText)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorText);

  @JsonKey(ignore: true)
  @override
  _$AuthStateErrorCopyWith<_AuthStateError> get copyWith =>
      __$AuthStateErrorCopyWithImpl<_AuthStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initializing(),
    @required TResult ready(CountryWithPhoneCode country),
    @required TResult error(String errorText),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return error(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initializing(),
    TResult ready(CountryWithPhoneCode country),
    TResult error(String errorText),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initializing(_AuthStateInitializing value),
    @required TResult ready(_AuthStateReady value),
    @required TResult error(_AuthStateError value),
  }) {
    assert(initializing != null);
    assert(ready != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initializing(_AuthStateInitializing value),
    TResult ready(_AuthStateReady value),
    TResult error(_AuthStateError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthStateError implements AuthState {
  const factory _AuthStateError(String errorText) = _$_AuthStateError;

  String get errorText;
  @JsonKey(ignore: true)
  _$AuthStateErrorCopyWith<_AuthStateError> get copyWith;
}
