import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/auth_state.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService extends StateNotifier<AuthState> {
  AuthService() : super(AuthState.initializing()) {
    _firebaseAuth = FirebaseAuth.instance;
    _loadCountries();
  }

  FirebaseAuth _firebaseAuth;
  CountryWithPhoneCode _selectedCountry;
  Map _phoneNumber;
  String _verificationId;
  List<CountryWithPhoneCode> countries = [];

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
  String get countryCode => _selectedCountry.countryCode;
  String get countryName => _selectedCountry.countryName;
  String get formattedPhoneNumber => _phoneNumber['national'];

  Future<void> _loadCountries() async {
    try {
      await FlutterLibphonenumber().init();
      var _countries = CountryManager().countries;
      _countries.sort((a, b) {
        return a.countryName
            .toLowerCase()
            .compareTo(b.countryName.toLowerCase());
      });
      countries = _countries;

      final langCode = CountryManager().deviceLocaleCountryCode.toUpperCase();
      _firebaseAuth.setLanguageCode(langCode);

      var filteredCountries =
          countries.where((item) => item.countryCode == langCode);

      if (filteredCountries.length == 0) {
        filteredCountries = countries.where((item) => item.countryCode == 'US');
      }
      if (filteredCountries.length == 0) {
        throw Exception('Unable to find a default country!');
      }
      setCountry(filteredCountries.first);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void setCountry(CountryWithPhoneCode selectedCountry) {
    _selectedCountry = selectedCountry;
    state = AuthState.ready(selectedCountry);
  }

  Future<void> parsePhoneNumber(String inputText) async {
    _phoneNumber = await FlutterLibphonenumber().parse(
      "+${_selectedCountry.phoneCode}${onlyDigits(inputText)}",
      region: _selectedCountry?.countryCode,
    );
    if (_phoneNumber['type'] != 'mobile') {
      throw Exception('You must enter a mobile phone number.');
    }
  }

  Future<void> verifyPhone(Function() completion) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: _phoneNumber['e164'],
      verificationCompleted: (AuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException e) {
        throw e;
      },
      codeSent: (String verificationId, [int resendToken]) {
        _verificationId = verificationId;
        completion();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        completion();
      },
      timeout: Duration(seconds: 120),
    );
  }

  Future<void> verifyCode(String smsCode, Function() completion) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    final user = await _firebaseAuth.signInWithCredential(credential);

    if (user != null) {
      completion();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
