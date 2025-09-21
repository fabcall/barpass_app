import 'package:flutter/material.dart';

class OnboardingStep {
  final Widget Function(BuildContext) illustration;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;

  const OnboardingStep({
    required this.illustration,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
  });
}
