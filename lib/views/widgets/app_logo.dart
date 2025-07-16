import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({Key? key, required this.width, required this.height})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppImages.appLogo, width: width, height: height);
  }
}
