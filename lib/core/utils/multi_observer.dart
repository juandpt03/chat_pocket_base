import 'package:flutter/material.dart';

class MultiObserver extends StatelessWidget {
  final List<Widget Function(BuildContext, Widget)> observers;
  final Widget child;

  const MultiObserver(
      {super.key, required this.observers, required this.child});

  @override
  Widget build(BuildContext context) {
    Widget wrappedChild = child;
    for (var observer in observers.reversed) {
      wrappedChild = observer(context, wrappedChild);
    }
    return wrappedChild;
  }
}
