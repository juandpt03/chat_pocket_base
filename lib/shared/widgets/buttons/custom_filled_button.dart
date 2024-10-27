import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final WidgetStateProperty<OutlinedBorder?>? shape;
  final double height;
  final bool isExpanded;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  const CustomFilledButton({
    required this.text,
    super.key,
    this.onPressed,
    this.shape,
    this.height = 48,
    this.isExpanded = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      width: isExpanded ? double.infinity : 180,
      child: FilledButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
            foregroundColor ?? colors.onPrimary,
          ),
          backgroundColor:
              WidgetStatePropertyAll(backgroundColor ?? colors.primary),
          splashFactory: InkSplash.splashFactory,
          elevation: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return 0;
              }
              return 10;
            },
          ),
          overlayColor: WidgetStatePropertyAll(colors.primaryContainer),
          padding: WidgetStatePropertyAll(padding),
          shape: shape ??
              WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
        ),
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
