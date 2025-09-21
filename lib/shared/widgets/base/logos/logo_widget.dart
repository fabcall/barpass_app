import 'package:barpass_app/core/theme/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  static const assetName = 'assets/images/logo.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorMapper: _LogoColorMapper(context),
      semanticsLabel: 'Barpass logo',
      height: height,
      width: width,
    );
  }
}

class _LogoColorMapper extends ColorMapper {
  const _LogoColorMapper(this.context);
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
