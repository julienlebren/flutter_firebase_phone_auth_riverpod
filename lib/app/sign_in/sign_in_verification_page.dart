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

final needsProfileProvider = StateProvider<bool>((ref) {
  final profileAsyncValue = ref.watch(profileStreamProvider);
  return profileAsyncValue.maybeWhen(
    data: (profile) {
      if (profile != null && profile.type != ProfileType.unknown) {
        return false;
      } else {
        return true;
      }
    },
    orElse: () => null,
  );
});

class SignInVerificationPageBuilder extends StatelessWidget {
  Future<void> _openProfile(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(AppRoutes.signInProfilePage);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<bool>>(
      provider: needsProfileProvider,
      onChange: (context, state) async {
        print(
            "SignInVerificationPageBuilder > needsProfileProvider changed: $state");
        if (state == true) {
          await _openProfile(context);
        }
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
    print('delayBeforeNewCode: ${widget.delayBeforeNewCode}');
    print('resendCode: ${widget.resendCode}');
    print('phoneNumber: ${widget.phoneNumber}');
    Future.delayed(Duration(milliseconds: 100), () {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).signInVerificationTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: _buildContents(context),
      floatingActionButton: widget.canSubmit
          ? FloatingActionButton(
              onPressed: widget.canSubmit
                  ? () => widget.verifyCode(controller.text)
                  : null,
              child: Icon(Icons.arrow_forward),
              backgroundColor: Colors.blue,
            )
          : null,
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        trailing: GestureDetector(
          onTap: widget.canSubmit
              ? () => widget.verifyCode(controller.text)
              : null,
          child: widget.isLoading
              ? CupertinoActivityIndicator()
              : Text(
                  AppLocalizations.of(context).nextButton,
                  style: TextStyle(
                      fontSize: 18,
                      color: widget.canSubmit == true
                          ? Colors.blueAccent
                          : Colors.grey[300]),
                ),
        ),
      ),
      child: SafeArea(
        child: _buildContents(context),
      ),
    );
  }

  Widget _buildIosPrepend() {
    return Column(children: [
      Text(
        AppLocalizations.of(context).signInVerificationTitle,
        style: TextStyles.signInTitleIos,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 15),
      Text(
        AppLocalizations.of(context)
            .signInVerificationSubtitle(widget.phoneNumber),
        style: TextStyles.signInSubtitleIos,
        textAlign: TextAlign.center,
      ),
    ]);
  }

  Widget _buildContents(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(children: [
          if (Platform.isIOS) _buildIosPrepend(),
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
                Text(AppLocalizations.of(context).signInVerificationNotReceived,
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    widget.resendCode();
                  },
                  child: Text(
                      widget.delayBeforeNewCode > 0
                          ? AppLocalizations.of(context)
                              .signInVerificationCountdown(
                                  widget.delayBeforeNewCode.toString())
                          : AppLocalizations.of(context)
                              .signInVerificationResend,
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
    );
  }

  TextStyle get _resendTextStyle {
    return TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w700,
      fontSize: 16,
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
