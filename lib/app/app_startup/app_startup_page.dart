import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/error_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/loader.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/home/home_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_phone_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/providers.dart';
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
          return SignInPhonePageBuilder();
        }
      },
      loading: () => Loader(),
      error: (error, _) => ErrorPage(message: error.toString()),
    );
  }
}
