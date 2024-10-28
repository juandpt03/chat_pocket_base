import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerObserverProvider = Provider<RouterObserver>((ref) {
  return RouterObserver(ref);
});

final currentRouteProvider = StateProvider<String>((ref) => '/');

class RouterObserver extends NavigatorObserver {
  final Ref ref;

  RouterObserver(this.ref);

  void _setRoute(Route<dynamic>? route) {
    final routeName = route?.settings.name;
    if (routeName != null) {
      log('Route: $routeName');
      ref.read(currentRouteProvider.notifier).state = routeName;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _setRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _setRoute(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _setRoute(newRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _setRoute(previousRoute);
  }
}
