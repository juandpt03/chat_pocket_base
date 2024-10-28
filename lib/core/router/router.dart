import 'package:chat_pocket_base/core/router/router_observer.dart';
import 'package:chat_pocket_base/providers/providers.dart';
import 'package:chat_pocket_base/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  final Ref ref;

  AppRouter(this.ref) {
    ref.listen<AuthState>(authProvider, (_, next) => _handleAuthState(next));
  }

  final _routes = {
    HomeScreen.routeName: _RouteConfig(
      builder: (_) => const HomeScreen(),
      isAllowed: (isAuth) => isAuth,
    ),
    SignInScreen.routeName: _RouteConfig(
      builder: (_) => const SignInScreen(),
      isAllowed: (isAuth) => !isAuth,
    ),
    SignUpScreen.routeName: _RouteConfig(
      builder: (_) => const SignUpScreen(),
      isAllowed: (isAuth) => !isAuth,
    ),
    ChatsView.routeName: _RouteConfig(
      builder: (_) => const ChatsView(),
      isAllowed: (isAuth) => isAuth,
    ),
    ChatView.routeName: _RouteConfig(
      builder: (_) => const ChatView(),
      isAllowed: (isAuth) => isAuth,
    ),
  };

  Route<dynamic> generateRoute(RouteSettings settings) {
    final routeConfig =
        _routes[settings.name] ?? _routes[SignInScreen.routeName]!;
    return MaterialPageRoute(
      builder: routeConfig.builder,
      settings: settings,
    );
  }

  void redirect(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  void _handleAuthState(AuthState authState) {
    final isAuthenticated = authState.authStatus == AuthStatus.authenticated;
    final currentRoute = ref.read(currentRouteProvider);

    if (!isRouteAllowed(currentRoute, isAuthenticated)) {
      final targetRoute =
          isAuthenticated ? HomeScreen.routeName : SignInScreen.routeName;
      redirect(targetRoute);
    }
  }

  bool isRouteAllowed(String? routeName, bool isAuthenticated) {
    return _routes[routeName]?.isAllowed(isAuthenticated) ?? false;
  }
}

class _RouteConfig {
  final WidgetBuilder builder;
  final bool Function(bool) isAllowed;

  const _RouteConfig({required this.builder, required this.isAllowed});
}
