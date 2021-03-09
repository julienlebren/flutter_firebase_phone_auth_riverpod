import 'package:flutter/material.dart';

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
          AppLocalizations.of(context).signInPhoneTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: _buildContents(context),
      floatingActionButton: widget.canSubmit
          ? FloatingActionButton(
              onPressed: (widget.canSubmit) ? () => widget.onSubmit() : null,
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
          onTap: widget.canSubmit ? () => widget.onSubmit() : null,
          child: widget.isLoading
              ? CupertinoActivityIndicator()
              : Text(
                  AppLocalizations.of(context).nextButton,
                  style: TextStyle(
                      fontSize: 18,
                      color: widget.canSubmit
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

  Widget _buildContents(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            if (Platform.isIOS)
              SignInIosHeader(
                title: AppLocalizations.of(context).signInPhoneTitle,
                subtitle: AppLocalizations.of(context).signInPhoneSubtitle,
              ),
            Column(children: [
              TextButton(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300],
                        width: 1.0, // Underline thickness
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(widget.countryName,
                          style: TextStyle(fontSize: 18, letterSpacing: -0.2)),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right,
                          size: 22, color: Colors.grey)
                    ],
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  primary: Colors.black,
                  textStyle: TextStyle(
                      fontSize: 18,
                      letterSpacing: -0.2,
                      color: Colors.grey[400]),
                ),
                onPressed: () {
                  if (Platform.isIOS)
                    showCupertinoModalBottomSheet(
                      context: context,
                      duration: Duration(milliseconds: 300),
                      builder: (context) => CountriesPage(),
                    );
                  else
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountriesPage(),
                      ),
                    );
                },
              ),
              SizedBox(height: 5),
              TextFormField(
                focusNode: focusNode,
                cursorColor: Theme.of(context).cursorColor,
                keyboardType: TextInputType.phone,
                controller: controller,
                style: TextStyle(fontSize: 18, letterSpacing: -0.2),
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    letterSpacing: -0.2,
                    color: Colors.grey[400],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.systemBlue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                ),
                inputFormatters: [widget.formatter],
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
            if (Platform.isAndroid)
              SignInAndroidFooter(
                subtitle: AppLocalizations.of(context).signInPhoneSubtitle,
              ),
          ],
        ),
      ),
    );
  }
}
