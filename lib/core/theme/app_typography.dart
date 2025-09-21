import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tipografia do BarPass - baseada em Poppins + Comfortaa
class AppTypography {
  AppTypography._();

  // === FONTS ===
  static String get poppins => GoogleFonts.poppins().fontFamily!;
  static const String comfortaa = 'Comfortaa';

  // === ESTILOS PRINCIPAIS ===

  /// Para títulos de AppBar (Comfortaa)
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: comfortaa,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.75,
  );

  /// Para textos de corpo (Poppins)
  static TextStyle get body => TextStyle(
    fontFamily: poppins,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  /// Para títulos de seção (Poppins)
  static TextStyle get heading => TextStyle(
    fontFamily: poppins,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  /// Para labels de botões (Poppins)
  static TextStyle get button => TextStyle(
    fontFamily: poppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Para textos pequenos (Poppins)
  static TextStyle get caption => TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // === MÉTODO HELPER ===
  /// Cria TextTheme para o Material Design
  static TextTheme createTextTheme() {
    return TextTheme(
      // Headlines
      headlineLarge: heading.copyWith(fontSize: 32),
      headlineMedium: heading.copyWith(fontSize: 28),
      headlineSmall: heading,

      // Titles
      titleLarge: heading.copyWith(fontSize: 22),
      titleMedium: heading.copyWith(fontSize: 20),
      titleSmall: heading.copyWith(fontSize: 18),

      // Body
      bodyLarge: body,
      bodyMedium: body.copyWith(fontSize: 14),
      bodySmall: caption,

      // Labels
      labelLarge: button,
      labelMedium: button.copyWith(fontSize: 14),
      labelSmall: button.copyWith(fontSize: 12),
    );
  }
}
