import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/buttons.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/error_text.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_phone_model.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInPhoneModelProvider =
    StateNotifierProvider.autoDispose<SignInPhoneModel, SignInState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return SignInPhoneModel(
    authService: authService,
  );
});

final selectedCountryProvider =
    Provider.autoDispose<CountryWithPhoneCode?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    ready: (selectedCountry) => selectedCountry,
    orElse: () => null,
  );
});

class SignInPhonePageBuilder extends ConsumerWidget {
  Future<void> _openVerification(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(AppRoutes.signInVerificationPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(signInPhoneModelProvider, (_, state) {
      if (state == SignInState.success()) {
        _openVerification(context);
      }
    });

    final state = ref.watch(signInPhoneModelProvider);
    final selectedCountry = ref.watch(selectedCountryProvider);
    final model = ref.read(signInPhoneModelProvider.notifier);

    return SignInPhonePage(
      phoneCode: '+${selectedCountry!.phoneCode}',
      phonePlaceholder: selectedCountry.exampleNumberMobileInternational
          .replaceAll('+${selectedCountry.phoneCode} ', ''),
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
        orElse: () => "Something is going on, not sure what.",
      ),
    );
  }
}

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({
    super.key,
    this.canSubmit = false,
    this.isLoading = false,
    required this.errorText,
    required this.phoneCode,
    required this.phonePlaceholder,
    required this.formatter,
    required this.onSubmit,
  });

  final LibPhonenumberTextFormatter formatter;
  final String phoneCode;
  final String phonePlaceholder;
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

  void noop() {}

  void initState() {
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
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(children: [
            SizedBox(height: 20),
            Text(
              "Please enter your phone number to receive a verification code.",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: OutlinedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        widget.phoneCode,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
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
                SizedBox(width: 5),
                Flexible(
                  child: TextFormField(
                    focusNode: focusNode,
                    keyboardType: TextInputType.phone,
                    controller: controller,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: widget.phonePlaceholder,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        letterSpacing: -0.2,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: (Colors.grey[300])!, width: 1.0),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    inputFormatters: [widget.formatter],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: "Continue",
                onPressed: widget.canSubmit ? widget.onSubmit : noop,
              ),
            ),
            if (widget.errorText != null) ErrorText(message: widget.errorText),
            SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
