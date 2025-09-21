import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';
    return SvgPicture.asset(
      assetName,
      colorMapper: _LogoColorMapper(context),
      semanticsLabel: 'App logo',
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (color == Colors.black && isDarkMode) {
      return Colors.white;
    }

    return color;
  }
}
