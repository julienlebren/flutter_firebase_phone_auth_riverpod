import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_phone_auth_riverpod/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StateNotifierProvider<AuthService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService;
});

final authStateChangesProvider = StreamProvider<User>(
    (ref) => ref.watch(authServiceProvider).authStateChanges());
