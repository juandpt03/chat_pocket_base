import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerObserverProvider = Provider<RouterObserver>((ref) {
  return RouterObserver(ref);
});

final currentRouteProvider = StateProvider<String>((ref) => '/');

class RouterObserver extends NavigatorObserver {
  final Ref ref;

  RouterObserver(this.ref);

  void _updateCurrentRoute(String? routeName) {
    if (routeName != null) {
      ref.read(currentRouteProvider.notifier).state = routeName;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateCurrentRoute(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _updateCurrentRoute(previousRoute?.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _updateCurrentRoute(newRoute?.settings.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _updateCurrentRoute(previousRoute?.settings.name);
  }
}
