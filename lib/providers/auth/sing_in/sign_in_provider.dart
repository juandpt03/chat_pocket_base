import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/providers/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInProvider =
    StateNotifierProvider<SignInNotifier, SignInState>((ref) {
  return SignInNotifier(
    authService: ServiceLocator().get(),
  );
});
