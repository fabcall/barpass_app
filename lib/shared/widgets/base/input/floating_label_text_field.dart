import 'package:barpass_app/shared/widgets/base/input/floating_label_input_border.dart';
import 'package:flutter/material.dart';

/// Widget de TextField com label flutuante interna
class FloatingLabelTextField extends StatelessWidget {
  const FloatingLabelTextField({
    required this.label,
    super.key,
    this.hintText,
    this.initialValue,
    this.hasError = false,
    this.errorMessage,
    this.borderColor,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final String? initialValue;
  final bool hasError;
  final String? errorMessage;
  final Color? borderColor;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inputTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(
          color: hasError ? colorScheme.error : inputTheme.labelStyle?.color,
        ),
        floatingLabelStyle: TextStyle(
          color: hasError
              ? colorScheme.error
              : inputTheme.floatingLabelStyle?.color,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        filled: inputTheme.filled,
        fillColor: inputTheme.fillColor,

        // Usa o FloatingLabelInputBorder customizado
        enabledBorder: FloatingLabelInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color:
                borderColor ??
                (hasError
                    ? colorScheme.error
                    : inputTheme.enabledBorder?.borderSide.color ??
                          Colors.grey),
            width: inputTheme.enabledBorder?.borderSide.width ?? 1.0,
          ),
        ),

        focusedBorder: FloatingLabelInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color:
                borderColor ??
                (hasError
                    ? colorScheme.error
                    : inputTheme.focusedBorder?.borderSide.color ??
                          colorScheme.primary),
            width: inputTheme.focusedBorder?.borderSide.width ?? 2.0,
          ),
        ),

        errorBorder: FloatingLabelInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: inputTheme.errorBorder?.borderSide.width ?? 1.0,
          ),
        ),

        focusedErrorBorder: FloatingLabelInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: inputTheme.focusedErrorBorder?.borderSide.width ?? 2.0,
          ),
        ),

        disabledBorder: FloatingLabelInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color:
                inputTheme.disabledBorder?.borderSide.color ??
                Colors.grey.shade300,
            width: inputTheme.disabledBorder?.borderSide.width ?? 1.0,
          ),
        ),

        contentPadding:
            inputTheme.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        errorText: hasError ? errorMessage : null,
        errorStyle: inputTheme.errorStyle,
      ),
    );
  }
}
