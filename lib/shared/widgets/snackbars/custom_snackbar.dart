import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool success = true,
    EdgeInsetsGeometry? padding,
  }) {
    final colors = Theme.of(context).colorScheme;
    if (!success) HapticFeedback.vibrate();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        showCloseIcon: true,
        backgroundColor: success ? colors.primary : colors.error,
        padding: padding,
        content: Text(
          message,
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
