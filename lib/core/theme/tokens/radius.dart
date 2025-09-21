import 'package:flutter/painting.dart';

/// Border radius do BarPass
class AppRadius {
  const AppRadius._();

  // Valores primitivos
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 20;
  static const double pill = 40;

  // BorderRadius prontos
  static BorderRadius get borderSm => BorderRadius.circular(sm);
  static BorderRadius get borderMd => BorderRadius.circular(md);
  static BorderRadius get borderLg => BorderRadius.circular(lg);
}
