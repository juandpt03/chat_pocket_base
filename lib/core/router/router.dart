import 'dart:developer';

import 'package:chat_pocket_base/core/router/go_router_notifier.dart';
import 'package:chat_pocket_base/core/router/redirect_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_pocket_base/screens/screens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.watch(goRouterNotifierProvider);

  return GoRouter(
    refreshListenable: goRouterNotifier,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/sign-in',
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final redirectRoute = RedirectRoute(
        authStatus: authStatus,
        route: isGoingTo,
      );
      log('Redirecting to: $isGoingTo');

      if (redirectRoute.isRouteAllowed()) {
        return null;
      }

      return redirectRoute.getRedirectRoute();
    },
    routes: [
      GoRoute(
        path: '/home',
        name: HomeScreen.routeName,
        pageBuilder: (context, state) => customTransitionPage(
          child: const HomeScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '/sign-in',
        name: SignInScreen.routeName,
        pageBuilder: (context, state) => customTransitionPage(
          child: const SignInScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '/sign-up',
        name: SignUpScreen.routeName,
        pageBuilder: (context, state) => customTransitionPage(
          child: const SignUpScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '/chats',
        name: ChatsView.routeName,
        pageBuilder: (context, state) => customTransitionPage(
          child: const ChatsView(),
          state: state,
        ),
        routes: [
          GoRoute(
            path: 'chat',
            name: ChatView.routeName,
            pageBuilder: (context, state) => customTransitionPage(
              child: const ChatView(),
              state: state,
            ),
          ),
        ],
      ),
    ],
  );
});

CustomTransitionPage<T> customTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
