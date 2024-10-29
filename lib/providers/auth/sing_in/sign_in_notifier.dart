import 'package:chat_pocket_base/models/models.dart';
import 'package:chat_pocket_base/providers/auth/sing_in/sign_in_state.dart';
import 'package:chat_pocket_base/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  final AuthService _authService;

  SignInNotifier({
    required AuthService authService,
  })  : _authService = authService,
        super(SignInState(user: User.empty()));

  void onEmailChanged(String email) {
    state = state.copyWith(user: state.user.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(user: state.user.copyWith(password: password));
  }

  Future<ApiResponse> signIn() async {
    final user = state.user;

    state = state.copyWith(isPosting: true);

    final response = await _authService.signIn(user);

    state = state.copyWith(isPosting: false);

    return response;
  }
}
