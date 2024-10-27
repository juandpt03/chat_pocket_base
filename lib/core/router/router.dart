import 'package:chat_pocket_base/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> _routes = {
    HomeScreen.routeName: (_) => const HomeScreen(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    ChatsView.routeName: (_) => const ChatsView(),
    ChatView.routeName: (_) => const ChatView(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = _routes[settings.name];

    return MaterialPageRoute(
      builder: builder ?? (_) => const SignInScreen(),
    );
  }
}
