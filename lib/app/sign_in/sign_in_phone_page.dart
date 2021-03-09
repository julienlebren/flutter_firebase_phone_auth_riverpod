import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/buttons.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_phone_model.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInPhoneModelProvider =
    StateNotifierProvider.autoDispose<SignInPhoneModel>((ref) {
  final authService = ref.watch(authServiceProvider);
  return SignInPhoneModel(
    authService: authService,
  );
});

final selectedCountryProvider = Provider.autoDispose<String>((ref) {
  final authState = ref.watch(authStateProvider.state);
  return authState.maybeWhen(
    ready: (selectedCountry) => selectedCountry.countryName,
    orElse: () => null,
  );
});

class SignInPhonePageBuilder extends StatelessWidget {
  Future<void> _openVerification(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(AppRoutes.signInVerificationPage);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SignInState>(
      provider: signInPhoneModelProvider.state,
      onChange: (context, state) async {
        if (state == SignInState.success()) {
          await _openVerification(context);
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(signInPhoneModelProvider.state);
          final countryName = watch(selectedCountryProvider);
          final model = context.read(signInPhoneModelProvider);
          return SignInPhonePage(
            countryName: countryName,
            formatter: model.phoneNumberFormatter,
            onSubmit: model.verifyPhone,
            canSubmit: state.maybeWhen(
              canSubmit: () => true,
              success: () => true,
              orElse: () => false,
            ),
            isLoading: state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            ),
            errorText: state.maybeWhen(
              error: (error) => error,
              orElse: () => null,
            ),
          );
        },
      ),
    );
  }
}

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({
    Key key,
    this.canSubmit = false,
    this.isLoading = false,
    this.errorText,
    @required this.countryName,
    @required this.formatter,
    @required this.onSubmit,
  }) : super(key: key);

  final LibPhonenumberTextFormatter formatter;
  final String countryName;
  final bool canSubmit;
  final bool isLoading;
  final String errorText;
  final Function() onSubmit;

  @override
  _SignInPhonePageState createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  void initState() {
    print("_SignInPhonePageState initState");
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign in with phone number",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(children: [
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Text(
                        widget.countryName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.countriesPage);
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              controller: controller,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: Colors.grey[400],
                ),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [widget.formatter],
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: "Continue",
                onPressed: () => widget.canSubmit ? widget.onSubmit : null,
              ),
            ),
            if (widget.errorText != null)
              Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: Text(
                  widget.errorText,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
