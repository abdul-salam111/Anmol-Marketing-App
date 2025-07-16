

import 'package:anmol_marketing/views/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../core/core.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.appDarkThemeBackground,
      body: Center(
        child: AppLogo(
          width: context.screenWidth * 0.3,
          height: context.screenHeight * 0.3,
        ),
      ),
    );
  }
}
