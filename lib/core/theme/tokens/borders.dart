import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/base/input/floating_label_input_border.dart';
import 'package:flutter/material.dart';

class AppBorders {
  static FloatingLabelInputBorder baseBorder(
    Color color,
    double width,
  ) {
    return FloatingLabelInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
