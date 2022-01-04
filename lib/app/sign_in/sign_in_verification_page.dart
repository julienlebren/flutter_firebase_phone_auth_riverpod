import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/error_text.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_verification_model.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';

final signInVerificationModelProvider =
    StateNotifierProvider.autoDispose<SignInVerificationModel, SignInState>(
        (ref) {
  final authService = ref.watch(authServiceProvider);
  return SignInVerificationModel(
    authService: authService,
  );
});

final countdownProvider = StreamProvider.autoDispose<int>((ref) {
  final signInVerificationModel =
      ref.watch(signInVerificationModelProvider.notifier);
  return signInVerificationModel.countdown.stream;
});

class SignInVerificationPageBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(signInVerificationModelProvider, (_, state) {
      if (state == SignInState.success()) {
        Navigator.popUntil(
          context,
          ModalRoute.withName(AppRoutes.startupPage),
        );
      }
    });

    final state = ref.watch(signInVerificationModelProvider);
    final countdown = ref.watch(countdownProvider);
    final model = ref.read(signInVerificationModelProvider.notifier);

    return SignInVerificationPage(
      phoneNumber: model.formattedPhoneNumber,
      resendCode: () => model.resendCode(),
      verifyCode: (String smsCode) => model.verifyCode(smsCode),
      delayBeforeNewCode:
          (countdown.data?.value ?? delayBeforeUserCanRequestNewCode),
      canSubmit: state.maybeWhen(
        canSubmit: () => true,
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
  }
}

class SignInVerificationPage extends StatefulWidget {
  const SignInVerificationPage({
    Key key,
    this.phoneNumber,
    this.canSubmit = false,
    this.isLoading = false,
    this.errorText,
    this.delayBeforeNewCode,
    this.resendCode,
    this.verifyCode,
  }) : super(key: key);

  final String phoneNumber;
  final bool canSubmit;
  final bool isLoading;
  final int delayBeforeNewCode;
  final String errorText;
  final Function() resendCode;
  final Function(String smsCode) verifyCode;

  @override
  State<StatefulWidget> createState() => _SignInVerificationPageState();
}

class _SignInVerificationPageState extends State<SignInVerificationPage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

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
          "Verification code",
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(children: [
            SizedBox(height: 20),
            Text(
              "Please enter the verfication code we sent to ${widget.phoneNumber}:",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 40),
                onTap: () {
                  if (widget.errorText != null) {
                    controller.text = "";
                  }
                },
                onSubmit: widget.verifyCode,
                focusNode: focusNode,
                controller: controller,
                pinAnimationType: PinAnimationType.none,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  border: Border.all(color: Colors.grey[300]),
                ),
                selectedFieldDecoration: _pinPutDecoration.copyWith(
                  border: Border.all(color: Colors.blue),
                ),
                followingFieldDecoration: _pinPutDecoration,
                autovalidateMode: AutovalidateMode.disabled,
                validator: (s) {
                  if (widget.errorText == null && s.length == 6)
                    widget.verifyCode(s);
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed:
                  widget.delayBeforeNewCode > 0 ? null : widget.resendCode,
              child: Text(
                widget.delayBeforeNewCode > 0
                    ? "If you did not receive the SMS, you will be able to request a new one in ${widget.delayBeforeNewCode.toString()} seconds"
                    : "Resend to ${widget.phoneNumber}",
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.errorText != null) ErrorText(message: widget.errorText),
          ]),
        ),
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey[300]),
      borderRadius: BorderRadius.circular(5.0),
    );
  }
}
