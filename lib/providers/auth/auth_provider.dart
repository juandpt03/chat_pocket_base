import 'dart:async';

import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/models/models.dart';
import 'package:chat_pocket_base/providers/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    pb: ServiceLocator().get(),
    ref: ref,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  final PocketBase pb;
  StreamSubscription<AuthStoreEvent>? _authStoreSubscription;

  AuthNotifier({
    required this.ref,
    required this.pb,
  }) : super(AuthState(authStatus: AuthStatus.checking)) {
    checkAuthStatus();
    onStateChanged();
  }

  void checkAuthStatus() {
    final token = pb.authStore.token;

    if (token.isEmpty) return setLoggedOutUser();
  }

  Future<void> signOut() async {}

  Future<ApiResponse?> signIn() async {
    final response = await ref.read(signInProvider.notifier).signIn();

    return response.when(
      left: (response) => response,
      right: (user) {
        setLoggedInUser(user);
        return null;
      },
    );
  }

  Future<ApiResponse?> signUp() async {
    final response = await ref.read(signUpProvider.notifier).signUp();

    return response.when(
      left: (response) => response,
      right: (user) {
        setLoggedInUser(user);
        return null;
      },
    );
  }

  void setLoggedInUser(User user) =>
      state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);

  void setLoggedOutUser() {
    state = state.copyWith(user: null, authStatus: AuthStatus.unauthenticated);

    pb.authStore.clear();
  }

  void onStateChanged() {
    _authStoreSubscription?.cancel();
    _authStoreSubscription = pb.authStore.onChange.listen((event) {
      if (event.token.isEmpty) setLoggedOutUser();
      return;
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
        user: user ?? this.user,
        authStatus: authStatus ?? this.authStatus,
      );
}

enum AuthStatus {
  checking,
  authenticated,
  unauthenticated,
}
