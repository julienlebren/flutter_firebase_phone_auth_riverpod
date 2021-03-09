import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initializing() = _AuthStateInitializing;
  const factory AuthState.ready(CountryWithPhoneCode country) = _AuthStateReady;
  const factory AuthState.error(String errorText) = _AuthStateError;
}
