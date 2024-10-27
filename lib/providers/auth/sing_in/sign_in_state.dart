import 'package:chat_pocket_base/models/models.dart';

class SignInState {
  final User user;
  final bool isPosting;

  SignInState({
    required this.user,
    this.isPosting = false,
  });

  SignInState copyWith({
    User? user,
    bool? isPosting,
  }) =>
      SignInState(
        user: user ?? this.user,
        isPosting: isPosting ?? this.isPosting,
      );
}
