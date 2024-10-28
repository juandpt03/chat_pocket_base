import 'package:chat_pocket_base/providers/providers.dart';

class RedirectRoute {
  AuthStatus authStatus;
  String route;

  RedirectRoute({required this.authStatus, required this.route});

  static const Map<AuthStatus, List<String>> allowedRoutes = {
    AuthStatus.checking: ['/splash'],
    AuthStatus.unauthenticated: [
      '/sign-in',
      '/sign-up',
    ],
    AuthStatus.authenticated: [
      '/home',
      '/chats',
      '/chats/chat',
    ],
  };

  final Map<AuthStatus, String> redirectRoutes = {
    AuthStatus.unauthenticated: '/sign-in',
    AuthStatus.authenticated: '/home',
  };
  bool isRouteAllowed() {
    return allowedRoutes[authStatus]?.contains(route) ?? false;
  }

  String? getRedirectRoute() {
    return redirectRoutes[authStatus];
  }
}
