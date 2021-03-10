import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_phone_auth_riverpod/services/auth_service.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPhoneModel extends StateNotifier<SignInState> {
  SignInPhoneModel({
    @required this.authService,
  }) : super(const SignInState.notValid());

  AuthService authService;

  LibPhonenumberTextFormatter get phoneNumberFormatter {
    return LibPhonenumberTextFormatter(
      phoneNumberType: PhoneNumberType.mobile,
      phoneNumberFormat: PhoneNumberFormat.international,
      overrideSkipCountryCode: authService.countryCode,
      onFormatFinished: (inputText) async => _parsePhoneNumber(inputText),
    );
  }

  Future<void> _parsePhoneNumber(String inputText) async {
    try {
      await authService.parsePhoneNumber(inputText);
      print("Phone number is valid, state set to 'canSubmit'");
      state = SignInState.canSubmit();
    } catch (e) {
      if (!e.message.contains('parse')) {
        state = SignInState.error(e.message);
      } else {
        state = SignInState.notValid();
      }
    }
  }

  Future<void> verifyPhone() async {
    print("Verifying phone number...");
    state = SignInState.loading();
    try {
      authService.verifyPhone(() {
        state = SignInState.success();
      });
    } catch (e) {
      state = SignInState.error(e.message);
    }
  }
}
