import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void push(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  void popAndPush(String routeName, {Object? arguments}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: arguments);

  void pushReplace(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  void pushRemove(String routeName, bool Function(Route<dynamic>)? predicate,
          {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(
          this, routeName, predicate ?? (route) => false,
          arguments: arguments);

  void pop([Object? result]) => Navigator.pop(this, result);
}
