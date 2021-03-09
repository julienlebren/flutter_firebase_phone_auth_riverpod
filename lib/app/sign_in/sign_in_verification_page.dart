import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_verification_model.dart';
import 'package:flutter_firebase_phone_auth_riverpod/providers.dart';
import 'package:flutter_firebase_phone_auth_riverpod/state/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';

final signInVerificationModelProvider =
    StateNotifierProvider.autoDispose<SignInVerificationModel>((ref) {
  final authService = ref.watch(authServiceProvider);
  return SignInVerificationModel(
    authService: authService,
  );
});

final countdownProvider = StreamProvider.autoDispose<int>((ref) {
  final signInVerificationModel = ref.watch(signInVerificationModelProvider);
  return signInVerificationModel.countdown.stream;
});

class SignInVerificationPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<SignInState>(
      provider: signInVerificationModelProvider.state,
      onChange: (context, state) async {
        if (state == SignInState.success()) {}
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(signInVerificationModelProvider.state);
          final countdown = watch(countdownProvider);
          final model = context.read(signInVerificationModelProvider);
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
        },
      ),
    );
  }
}

class SignInVerificationPage extends StatefulWidget {
  const SignInVerificationPage({
    Key key,
    @required this.phoneNumber,
    this.canSubmit = false,
    this.isLoading = false,
    this.errorText,
    this.delayBeforeNewCode,
    @required this.resendCode,
    @required this.verifyCode,
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
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 56),
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
                    border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    width: 1.0,
                  ),
                )),
                selectedFieldDecoration: _pinPutDecoration.copyWith(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.0,
                  ),
                )),
                followingFieldDecoration: _pinPutDecoration,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (s) {
                  if (widget.errorText == null && s.length == 6)
                    widget.verifyCode(s);
                  return null;
                },
              ),
            ),
            if (widget.errorText != null) ...[
              Text(widget.errorText,
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Did not receive the SMS?",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      widget.resendCode();
                    },
                    child: Text(
                        widget.delayBeforeNewCode > 0
                            ? "Please wait ${widget.delayBeforeNewCode.toString()} sec"
                            : "Resend",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                ],
              )
            ],
          ]),
        ),
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
      ),
    );
  }
}
