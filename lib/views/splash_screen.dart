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
        child: Image.asset(
          AppImages.appLogo,
          width: context.screenWidth * 0.4,
          height: context.screenHeight * 0.2,
        ),
      ),
    );
  }
}
