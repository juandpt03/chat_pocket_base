import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final AutovalidateMode autovalidateMode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final EdgeInsetsGeometry padding;
  final TextStyle? hintStyle;
  final TextStyle? style;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    this.hintStyle,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      autocorrect: autocorrect,
      autovalidateMode: autovalidateMode,
      maxLines: maxLines,
      style: style,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: colors.primary.withOpacity(0.05),
        contentPadding: padding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
