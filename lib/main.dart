import 'package:chat_pocket_base/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI().setup();
  runApp(
    const ProviderScope(
      // observers: [ProviderStateLogger()],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final routerObserver = ref.watch(routerObserverProvider);
    final appTheme = AppTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      onGenerateRoute: router.generateRoute,
      navigatorObservers: [routerObserver],
      navigatorKey: navigatorKey,
    );
  }
}
