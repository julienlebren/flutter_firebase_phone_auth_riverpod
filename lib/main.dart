import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/common_widgets/error_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/home/home_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/routing/app_router.dart';
import 'package:flutter_firebase_phone_auth_riverpod/app/sign_in/sign_in_landing_page.dart';
import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Phone Auth with Riverpod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20.0),
          caption: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
      initialRoute: AppRoutes.startupPage,
    );
  }
}

class StartupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
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
