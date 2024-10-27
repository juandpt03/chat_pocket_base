import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/services/services.dart';
import 'package:pocketbase/pocketbase.dart';

class DI {
  DI._internal();
  static final DI instance = DI._internal();
  static final ServiceLocator serviceLocator = ServiceLocator();

  factory DI() => instance;

  Future<void> setup() async {
    serviceLocator.register(PocketBase(apiURL));
    serviceLocator.register(AuthService(pb: serviceLocator.get()));
  }
}
