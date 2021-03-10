import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/buttons.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneNumberProvider = Provider.autoDispose<String>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.formattedPhoneNumber;
});

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final phoneNumber = watch(phoneNumberProvider);
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
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 80),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "You have successfully signed in with phone number",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              phoneNumber,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                  title: "Sign out",
                  onPressed: () {
                    final authService = context.read(authServiceProvider);
                    authService.signOut();
                  }),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
