import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconLogoWidget extends StatelessWidget {
  const IconLogoWidget({
    super.key,
    this.size = 18,
  });

  final double size;

  static const assetName = 'assets/icons/logo.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorMapper: _IconLogoColorMapper(context),
      semanticsLabel: 'Barpass logo',
      height: size,
      width: size,
    );
  }
}

class _IconLogoColorMapper extends ColorMapper {
  const _IconLogoColorMapper(this.context);
  final BuildContext context;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    final isDarkMode = context.isDark;

    if (color == Colors.black && isDarkMode) {
      return Colors.white;
    }

    return color;
  }
}
