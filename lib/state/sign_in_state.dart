import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState.notValid() = _NotValid;
  const factory SignInState.canSubmit() = _CanSubmit;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.success() = _Success;
  const factory SignInState.error(String errorText) = _Error;
}
