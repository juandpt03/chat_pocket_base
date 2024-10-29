import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/services/services.dart';

import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DI {
  DI._internal();
  static final DI instance = DI._internal();
  static final ServiceLocator serviceLocator = ServiceLocator();

  factory DI() => instance;

  Future<void> setup() async {
    final prefs = await SharedPreferences.getInstance();
    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );
    serviceLocator.register(prefs);
    serviceLocator.register(PocketBase(apiURL, authStore: store));
    serviceLocator.register(AuthService(pb: serviceLocator.get()));
  }
}
