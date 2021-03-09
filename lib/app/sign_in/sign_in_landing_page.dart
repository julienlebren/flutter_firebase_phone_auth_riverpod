import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/buttons.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';

class SignInLandingPage extends StatelessWidget {
  Future<void> _openSignup(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.signInPhonePage,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Firebase Phone Auth with Riverpod",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Center(child: FlutterLogo(size: 120)),
            SizedBox(height: 30),
            Text(
              "Welcome to this demo app using Firebase Phone Authentication and Riverpod for its State Management",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: "Sign in with phone number",
                onPressed: () => _openSignup(context),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
