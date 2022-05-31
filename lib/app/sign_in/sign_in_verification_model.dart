import 'dart:async';
import 'package:flutter_firebase_phone_auth_riverpod/services/auth_service.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final delayBeforeUserCanRequestNewCode = 30;

class SignInVerificationModel extends StateNotifier<SignInState> {
  SignInVerificationModel({
    this.authService,
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
    state = SignInState.loading();
    try {
      await authService.verifyCode(smsCode, () {
        state = SignInState.success();
      });
    } catch (e) {
      if (e.code == "invalid-verification-code") {
        state = SignInState.error("Invalid verification code!");
      } else {
        state = SignInState.error(e.message);
      }
    }
  }
}
