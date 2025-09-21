import 'package:flutter/material.dart' show EdgeInsets;

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 24;
  static const double xl = 32;

  // Atalhos
  static const paddingMd = EdgeInsets.all(md);
  static const paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
}
