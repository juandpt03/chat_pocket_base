import 'package:chat_pocket_base/core/di/service_locator.dart';
import 'package:chat_pocket_base/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier(authService: ServiceLocator().get());
});
