import 'dart:ui';

import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual styling for Burnt toasts.
///
/// Use this [ThemeExtension] to customize the appearance of toasts globally
/// or for a specific part of your widget tree.
@immutable
class BurntThemeData extends ThemeExtension<BurntThemeData>
    with DiagnosticableTreeMixin {
  /// Creates a [BurntThemeData].
  const BurntThemeData({
    this.backgroundColor,
    this.titleStyle,
    this.messageStyle,
    this.contentPadding,
    this.successIcon,
    this.warningIcon,
    this.errorIcon,
    this.successIconColor,
    this.warningIconColor,
    this.errorIconColor,
    this.presetIconSize,
    // Replaced blur with shadow properties
    this.shadows,
    this.borderRadius,
    // Enhanced border properties
    this.shape,
    this.elevation,
    this.shadowColor,
    // New gradient support
    this.backgroundGradient,
    this.borderColor,
    this.borderWidth,
  });

  /// Obtém o BurntThemeData do contexto, mesclando o tema customizado
  /// sobre um tema base com valores padrão.
  factory BurntThemeData.of(BuildContext context) {
    // 1. Cria um tema base completo com todos os valores padrão.
    final baseTheme = BurntThemeData.fromTheme(Theme.of(context));

    // 2. Busca por um tema parcial definido pelo usuário.
    final providedTheme = context.theme.extension<BurntThemeData>();

    // 3. Se não houver tema customizado, retorna o tema base.
    if (providedTheme == null) {
      return baseTheme;
    }

    // 4. Se houver, mescla o tema do usuário sobre o tema base.
    return baseTheme.copyWith(
      backgroundColor: providedTheme.backgroundColor,
      titleStyle: providedTheme.titleStyle,
      messageStyle: providedTheme.messageStyle,
      contentPadding: providedTheme.contentPadding,
      successIcon: providedTheme.successIcon,
      warningIcon: providedTheme.warningIcon,
      errorIcon: providedTheme.errorIcon,
      successIconColor: providedTheme.successIconColor,
      warningIconColor: providedTheme.warningIconColor,
      errorIconColor: providedTheme.errorIconColor,
      presetIconSize: providedTheme.presetIconSize,
      shadows: providedTheme.shadows,
      borderRadius: providedTheme.borderRadius,
      shape: providedTheme.shape,
      elevation: providedTheme.elevation,
      shadowColor: providedTheme.shadowColor,
      backgroundGradient: providedTheme.backgroundGradient,
      borderColor: providedTheme.borderColor,
      borderWidth: providedTheme.borderWidth,
    );
  }

  /// Cria um BurntThemeData com valores padrão derivados do ThemeData global.
  factory BurntThemeData.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    // More opaque background since we're not using blur
    final backgroundColor = isDark
        ? theme.colorScheme.surface
        : theme.colorScheme.surface;

    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    );

    final messageStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
      fontSize: 13,
    );

    // Enhanced shadow system for depth
    final shadows = [
      // Primary shadow for depth
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.4)
            : Colors.black.withValues(alpha: 0.15),
        offset: const Offset(0, 4),
        blurRadius: 12,
      ),
      // Secondary shadow for ambient lighting
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.1),
        offset: const Offset(0, 2),
        blurRadius: 6,
        spreadRadius: -2,
      ),
      // Subtle highlight for dimensionality
      if (!isDark)
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.1),
          offset: const Offset(0, -1),
          blurRadius: 2,
        ),
    ];

    return BurntThemeData(
      backgroundColor: backgroundColor,
      titleStyle: titleStyle,
      messageStyle: messageStyle,
      borderRadius: BorderRadius.circular(24),
      shadows: shadows,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      successIconColor: Colors.green.shade400,
      warningIconColor: Colors.amber.shade500,
      errorIconColor: Colors.red.shade400,
      presetIconSize: 20,
      borderColor: isDark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.05),
      borderWidth: 1,
    );
  }

  /// The background color of the toast.
  final Color? backgroundColor;

  /// The text style for the toast's title.
  final TextStyle? titleStyle;

  /// The text style for the toast's message.
  final TextStyle? messageStyle;

  /// The padding around the content within the toast.
  final EdgeInsetsGeometry? contentPadding;

  /// A custom widget to use as the icon for the 'done' preset.
  /// If null, a default icon will be used.
  final Widget? successIcon;

  /// A custom widget to use as the icon for the 'warning' preset.
  /// If null, a default icon will be used.
  final Widget? warningIcon;

  /// A custom widget to use as the icon for the 'error' preset.
  /// If null, a default icon will be used.
  final Widget? errorIcon;

  /// The color for the default 'done' preset icon, if [successIcon] is not provided.
  final Color? successIconColor;

  /// The color for the default 'warning' preset icon, if [warningIcon] is not provided.
  final Color? warningIconColor;

  /// The color for the default 'error' preset icon, if [errorIcon] is not provided.
  final Color? errorIconColor;

  /// The size for the default preset icons ('done', 'error'), if custom icons are not provided
  /// or if the provided custom icons don't specify a size.
  final double? presetIconSize;

  /// Custom shadows for the toast. If provided, overrides the default elevation shadow.
  final List<BoxShadow>? shadows;

  /// Border radius for the toast container. If null, uses a default rounded rectangle.
  final BorderRadius? borderRadius;

  /// Shape for the toast container. If null, uses rounded rectangle with borderRadius.
  final ShapeBorder? shape;

  /// Elevation/shadow depth for the toast. Ignored if [shadows] is provided.
  final double? elevation;

  /// Color of the drop shadow. Ignored if [shadows] is provided.
  final Color? shadowColor;

  /// Optional gradient background for the toast.
  final Gradient? backgroundGradient;

  /// Border color for the toast.
  final Color? borderColor;

  /// Border width for the toast.
  final double? borderWidth;

  @override
  BurntThemeData copyWith({
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    EdgeInsetsGeometry? contentPadding,
    Widget? successIcon,
    Widget? warningIcon,
    Widget? errorIcon,
    Color? successIconColor,
    Color? warningIconColor,
    Color? errorIconColor,
    double? presetIconSize,
    List<BoxShadow>? shadows,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
    double? elevation,
    Color? shadowColor,
    Gradient? backgroundGradient,
    Color? borderColor,
    double? borderWidth,
  }) {
    return BurntThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      successIcon: successIcon ?? this.successIcon,
      warningIcon: warningIcon ?? this.warningIcon,
      errorIcon: errorIcon ?? this.errorIcon,
      successIconColor: successIconColor ?? this.successIconColor,
      warningIconColor: warningIconColor ?? this.warningIconColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      presetIconSize: presetIconSize ?? this.presetIconSize,
      shadows: shadows ?? this.shadows,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  BurntThemeData lerp(ThemeExtension<BurntThemeData>? other, double t) {
    if (other is! BurntThemeData) {
      return this;
    }
    return BurntThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      messageStyle: TextStyle.lerp(messageStyle, other.messageStyle, t),
      contentPadding: EdgeInsetsGeometry.lerp(
        contentPadding,
        other.contentPadding,
        t,
      ),
      successIcon: t < 0.5 ? successIcon : other.successIcon,
      warningIcon: t < 0.5 ? warningIcon : other.warningIcon,
      errorIcon: t < 0.5 ? errorIcon : other.errorIcon,
      successIconColor: Color.lerp(successIconColor, other.successIconColor, t),
      warningIconColor: Color.lerp(warningIconColor, other.warningIconColor, t),
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t),
      presetIconSize: lerpDouble(presetIconSize, other.presetIconSize, t),
      shadows: t < 0.5 ? shadows : other.shadows,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      backgroundGradient: t < 0.5
          ? backgroundGradient
          : other.backgroundGradient,
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<TextStyle>('titleStyle', titleStyle))
      ..add(DiagnosticsProperty<TextStyle>('messageStyle', messageStyle))
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>(
          'contentPadding',
          contentPadding,
        ),
      )
      ..add(DiagnosticsProperty<Widget>('successIcon', successIcon))
      ..add(DiagnosticsProperty<Widget>('warningIcon', warningIcon))
      ..add(DiagnosticsProperty<Widget>('errorIcon', errorIcon))
      ..add(ColorProperty('successIconColor', successIconColor))
      ..add(ColorProperty('warningIconColor', warningIconColor))
      ..add(ColorProperty('errorIconColor', errorIconColor))
      ..add(DoubleProperty('presetIconSize', presetIconSize))
      ..add(DiagnosticsProperty<List<BoxShadow>>('shadows', shadows))
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius))
      ..add(DiagnosticsProperty<ShapeBorder>('shape', shape))
      ..add(DoubleProperty('elevation', elevation))
      ..add(ColorProperty('shadowColor', shadowColor))
      ..add(
        DiagnosticsProperty<Gradient>('backgroundGradient', backgroundGradient),
      )
      ..add(ColorProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BurntThemeData &&
        other.backgroundColor == backgroundColor &&
        other.titleStyle == titleStyle &&
        other.messageStyle == messageStyle &&
        other.contentPadding == contentPadding &&
        other.successIcon == successIcon &&
        other.warningIcon == warningIcon &&
        other.errorIcon == errorIcon &&
        other.successIconColor == successIconColor &&
        other.warningIconColor == warningIconColor &&
        other.errorIconColor == errorIconColor &&
        other.presetIconSize == presetIconSize &&
        listEquals(other.shadows, shadows) &&
        other.borderRadius == borderRadius &&
        other.shape == shape &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.backgroundGradient == backgroundGradient &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      titleStyle,
      messageStyle,
      contentPadding,
      successIcon,
      warningIcon,
      errorIcon,
      successIconColor,
      warningIconColor,
      errorIconColor,
      presetIconSize,
      shadows,
      borderRadius,
      shape,
      elevation,
      shadowColor,
      backgroundGradient,
      borderColor,
      borderWidth,
    ]);
  }
}
