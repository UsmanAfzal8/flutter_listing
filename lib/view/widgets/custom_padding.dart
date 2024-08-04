import 'package:flutter/material.dart';

import '../../utilis/utilis.dart';

EdgeInsetsGeometry CustomPadding(
    {required ScreenEnum screenEnum,
    required BuildContext context,
    bool? isHome,
    double? top,
    double? bottom,
    double? left,
    double? right,
    }) {
  double height = getMaxHeight(context);
  double width = getMaxWidth(context);
  double verticalHeight = height * 0.1;
  if (isHome == true) {
    verticalHeight = 0;
  }
  if (screenEnum == ScreenEnum.desktop) {
    // return EdgeInsets.symmetric(
    //     horizontal: width * 0.1, vertical: verticalHeight);
    return EdgeInsets.only(left: left??width * 0.1,
    right: right??width * 0.1,
    top:top??verticalHeight ,
    bottom: bottom??verticalHeight,
    );
  } else if (screenEnum == ScreenEnum.tablet) {
    // return EdgeInsets.symmetric(
    //     horizontal: width * 0.08, vertical: verticalHeight);
     return EdgeInsets.only(left: left??width * 0.08,
    right: right??width * 0.08,
    top:top??verticalHeight ,
    bottom: bottom??verticalHeight,
    );
  } else {
    // return EdgeInsets.symmetric(
    //     horizontal: width * 0.05, vertical: verticalHeight);
     return EdgeInsets.only(left: left??width * 0.05,
    right: right??width * 0.05,
    top:top??verticalHeight ,
    bottom: bottom??verticalHeight,
    );
  }
}

double getMaxWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getMaxHeight(BuildContext context) => MediaQuery.of(context).size.height;
