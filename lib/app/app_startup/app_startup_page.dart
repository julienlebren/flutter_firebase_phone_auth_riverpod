import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/error_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/home/home_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_landing_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStartupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) {
        if (user != null) {
          return HomePage();
        } else {
          return SignInLandingPage();
        }
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => ErrorPage(message: error.toString()),
    );
  }
}
