import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double radius;

  const AppLogo({super.key, this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(AppImages.appLogo),
    );
  }
}
