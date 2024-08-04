import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

class AppTextStyles {
  static final TextStyle heading500 =
      GoogleFonts.leagueSpartan(fontWeight: FontWeight.w500, fontSize: 15.0);

  static final TextStyle heading700 = GoogleFonts.leagueSpartan(
    fontWeight: FontWeight.w700,
    fontSize: 15.0,
    
  );
}

Widget customtext(
  String text, {
  Color? color,
  double? size,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  TextDecoration? decoration, // Add this parameter
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: GoogleFonts.leagueSpartan(
        color: color ?? AppColors.blackColor,
        fontSize: size ?? 15,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: 1.5,
        decoration: decoration ?? TextDecoration.none),

    // Show ellipsis if maxLines is specified
  );
}
