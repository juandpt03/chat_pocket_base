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
    ref.listen<AuthState>(authProvider, (_, next) {
      _handleAuthStateChange(next);
    });
  }

  void _handleAuthStateChange(AuthState authState) {
    final isAuth = authState.authStatus == AuthStatus.authenticated;
    final currentRoute = ref.read(currentRouteProvider);
    final shouldRedirect = _routes[currentRoute]?.isAuth != isAuth;

    if (shouldRedirect) redirect(isAuth);
  }

  void redirect(bool isAuth) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      isAuth ? HomeScreen.routeName : SignInScreen.routeName,
      (_) => false,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final route = _routes[settings.name] ?? _routes[SignInScreen.routeName]!;
    return MaterialPageRoute(
      builder: route.builder,
      settings: settings,
    );
  }

  final _routes = {
    HomeScreen.routeName: _RouteData(
      builder: (_) => const HomeScreen(),
      isAuth: true,
    ),
    SignInScreen.routeName: _RouteData(
      builder: (_) => const SignInScreen(),
      isAuth: false,
    ),
    SignUpScreen.routeName: _RouteData(
      builder: (_) => const SignUpScreen(),
      isAuth: false,
    ),
    ChatsView.routeName: _RouteData(
      builder: (_) => const ChatsView(),
      isAuth: true,
    ),
    ChatView.routeName: _RouteData(
      builder: (_) => const ChatView(),
      isAuth: true,
    ),
  };
}

class _RouteData {
  final WidgetBuilder builder;
  final bool isAuth;

  const _RouteData({required this.builder, required this.isAuth});
}
