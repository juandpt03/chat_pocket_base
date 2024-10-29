import 'dart:async';
import 'dart:developer';

import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/models/models.dart';
import 'package:chat_pocket_base/providers/providers.dart';
import 'package:chat_pocket_base/services/auth/auth_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref: ref,
    pb: ServiceLocator().get(),
    authService: ServiceLocator().get(),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  final PocketBase pb;
  final AuthService authService;
  StreamSubscription<AuthStoreEvent>? _authStoreSubscription;

  AuthNotifier({
    required this.ref,
    required this.pb,
    required this.authService,
  }) : super(AuthState(authStatus: AuthStatus.checking)) {
    _checkAuthStatus();
    _onStateChanged();
  }

  Future<ApiResponse> signIn() async {
    final response = await ref.read(signInProvider.notifier).signIn();
    return response;
  }

  Future<ApiResponse> signUp() async {
    final response = await ref.read(signUpProvider.notifier).signUp();
    return response;
  }

  Future<ApiResponse> _checkAuthStatus() async {
    final response = await authService.checkStatus();
    return response;
  }

  void _setLoggedIn(User user) {
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  void _setLoggedOut() {
    state = state.copyWith(user: null, authStatus: AuthStatus.unauthenticated);
  }

  void logout() => pb.authStore.clear();

  void _onStateChanged() {
    _authStoreSubscription = pb.authStore.onChange.listen((event) {
      log('AuthStoreEvent: $event');
      if (event.token.isEmpty) {
        _setLoggedOut();
        return;
      }
      final user = User.fromJson(pb.authStore.model.toJson());
      _setLoggedIn(user);
    });
  }

  @override
  void dispose() {
    _authStoreSubscription?.cancel();
    super.dispose();
  }
}

class AuthState {
  final User? user;
  final AuthStatus authStatus;

  AuthState({
    this.user,
    required this.authStatus,
  });

  AuthState copyWith({
    User? user,
    AuthStatus? authStatus,
  }) =>
      AuthState(
        user: user,
        authStatus: authStatus ?? this.authStatus,
      );
}

enum AuthStatus {
  checking,
  authenticated,
  unauthenticated,
}
