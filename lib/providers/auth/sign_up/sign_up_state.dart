import 'package:chat_pocket_base/models/user.dart';

class SignUpState {
  final bool isPosting;
  final User user;

  SignUpState({
    this.isPosting = false,
    required this.user,
  });

  SignUpState copyWith({
    User? user,
    bool? isPosting,
  }) =>
      SignUpState(
        user: user ?? this.user,
        isPosting: isPosting ?? this.isPosting,
      );
}
