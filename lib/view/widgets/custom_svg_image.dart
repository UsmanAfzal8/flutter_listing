import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

class CustomSvgImage extends StatelessWidget {
  final String svgPath;
  final double width;
  final double height;

  const CustomSvgImage({
    super.key,
    required this.svgPath,
    this.width = 50.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(
        svgPath,
        fit: BoxFit.fill,
      ),
    );
  }
}
