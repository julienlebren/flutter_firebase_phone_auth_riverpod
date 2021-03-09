import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_phone_auth_riverpod/services/auth_service.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final delayBeforeUserCanRequestNewCode = 15;

class SignInVerificationModel extends StateNotifier<SignInState> {
  SignInVerificationModel({
    @required this.authService,
  }) : super(const SignInState.notValid()) {
    _startTimer();
  }

  AuthService authService;
  String get formattedPhoneNumber => authService.formattedPhoneNumber;

  Timer _timer;
  StreamController<int> countdown = StreamController<int>();
  int _countdown;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdown = delayBeforeUserCanRequestNewCode;
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
        } else {
          print("_countdown: $_countdown");
          _countdown--;
          countdown.add(_countdown);
        }
      },
    );
  }

  void resendCode() {
    state = SignInState.loading();
    try {
      authService.verifyPhone(() {
        state = SignInState.canSubmit();
        _startTimer();
      });
    } catch (e) {
      state = SignInState.error(e.message);
    }
  }

  Future<void> verifyCode(String smsCode) async {
    _timer.cancel();
    state = SignInState.loading();
    try {
      authService.verifyCode(smsCode, () {
        state = SignInState.success();
      });
    } catch (e) {
      state = SignInState.error(e.message);
    }
  }
}
