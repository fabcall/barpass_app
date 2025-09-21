import 'package:flutter/material.dart' show EdgeInsets;

class AppSpacing {
  const AppSpacing._();

  // Valores primitivos
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Atalhos para padding comum
  static const paddingXs = EdgeInsets.all(xs);
  static const paddingSm = EdgeInsets.all(sm);
  static const paddingMd = EdgeInsets.all(md);
  static const paddingLg = EdgeInsets.all(lg);
  static const paddingXl = EdgeInsets.all(xl);

  static const paddingHorizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);

  static const paddingVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const paddingVerticalXl = EdgeInsets.symmetric(vertical: xl);

  // Contextos específicos
  static const double pageHorizontal = lg;
  static const double pageVertical = lg;
  static const double cardInner = md;
  static const double sectionGap = xl;
  static const double componentGap = md;
  static const double itemGap = sm;

  static const pagePadding = EdgeInsets.all(lg);
  static const cardPadding = EdgeInsets.all(md);
}
