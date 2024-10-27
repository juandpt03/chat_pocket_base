import 'package:chat_pocket_base/core/patterns/either.dart';
import 'package:chat_pocket_base/models/models.dart';
import 'package:chat_pocket_base/providers/auth/sign_up/sign_up_state.dart';
import 'package:chat_pocket_base/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthService _authService;

  SignUpNotifier({
    required AuthService authService,
  })  : _authService = authService,
        super(SignUpState(user: User.empty()));

  void onEmailChanged(String email) {
    state = state.copyWith(user: state.user.copyWith(email: email));
  }

  void onUsernameChanged(String username) {
    state = state.copyWith(user: state.user.copyWith(username: username));
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(user: state.user.copyWith(password: password));
  }

  Future<Either<ApiResponse, User>> signUp() async {
    final user = state.user;

    state = state.copyWith(isPosting: true);

    final response = await _authService.signUp(user);

    state = state.copyWith(isPosting: false);

    return response;
  }
}
