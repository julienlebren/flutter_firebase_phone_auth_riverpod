import 'package:flutter_firebase_phone_auth_riverpod/services/auth_service.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPhoneModel extends StateNotifier<SignInState> {
  SignInPhoneModel({
    required this.authService,
  }) : super(const SignInState.notValid());

  AuthService authService;

  LibPhonenumberTextFormatter get phoneNumberFormatter {
    return LibPhonenumberTextFormatter(
      phoneNumberType: PhoneNumberType.mobile,
      phoneNumberFormat: PhoneNumberFormat.international,
      country: authService.selectedCountry,
      onFormatFinished: (inputText) async => _parsePhoneNumber(inputText),
    );
  }

  Future<void> _parsePhoneNumber(String inputText) async {
    try {
      await authService.parsePhoneNumber(inputText);
      state = SignInState.canSubmit();
    } on Exception catch (e) {
      print(e.toString());
      if (!e.toString().contains('parse')) {
        state = SignInState.error('Error $e');
      } else {
        state = SignInState.notValid();
      }
    }
  }

  Future<void> verifyPhone() async {
    state = SignInState.loading();
    try {
      authService.verifyPhone(() {
        state = SignInState.success();
      });
    } on Exception catch (e) {
      state = SignInState.error('Error $e');
    }
  }
}
