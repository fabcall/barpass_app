/// Sistema de tema unificado do BarPass
library;

import 'package:barpass_app/core/theme/themes/dark_theme.dart';
import 'package:barpass_app/core/theme/themes/light_theme.dart';
import 'package:flutter/material.dart';

// Extensões
export 'extensions/theme_extensions.dart';
// Temas
export 'themes/dark_theme.dart';
export 'themes/light_theme.dart';
// Tokens
export 'tokens/tokens.dart';

/// Classe principal de acesso aos temas
abstract final class AppTheme {
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
}
