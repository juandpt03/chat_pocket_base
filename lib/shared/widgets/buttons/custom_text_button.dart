import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final WidgetStateProperty<OutlinedBorder?>? shape;
  final double height;
  final bool isExpanded;
  final EdgeInsets padding;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  const CustomTextButton({
    required this.child,
    super.key,
    this.onPressed,
    this.shape,
    this.height = 48,
    this.isExpanded = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.foregroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      width: isExpanded ? double.infinity : 180,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
            foregroundColor ?? colors.primary,
          ),
          overlayColor: WidgetStatePropertyAll(
            colors.primaryContainer.withOpacity(0.1),
          ),
          padding: WidgetStatePropertyAll(padding),
          shape: shape ??
              WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
