
import 'package:flutter/material.dart';
import '../../../utilis/utilis.dart';
import 'widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
        desktop: HomeWidget(
          screenEnum: ScreenEnum.desktop,
        ),
        mobile: HomeWidget(screenEnum: ScreenEnum.mobile),
        tablet: HomeWidget(
          screenEnum: ScreenEnum.tablet,
        ));
  }
}

