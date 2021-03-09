import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_phone_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_verification_page.dart';

class AppRoutes {
  static const signInPhonePage = '/sign-in-phone-page';
  static const signInVerificationPage = '/sign-in-verification-page';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInPhonePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInPhonePageBuilder(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.signInVerificationPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInVerificationPageBuilder(),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
