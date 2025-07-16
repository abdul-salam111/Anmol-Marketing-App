import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/constants/alignments.dart';
import 'package:anmol_marketing/core/constants/colors.dart';
import 'package:anmol_marketing/core/constants/paddings.dart';
import 'package:anmol_marketing/core/utils/extensions.dart';
import 'package:anmol_marketing/core/utils/unfocus_wrapper.dart';
import 'package:anmol_marketing/views/widgets/app_logo.dart';
import 'package:anmol_marketing/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              crossAxisAlignment: crossAxisStart,
              children: [
                context.heightBox((context.screenHeight * 0.05)),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: AppLogo(
                      width: context.screenWidth * 0.2,
                      height: context.screenHeight * 0.2,
                    ),
                  ),
                ),
                context.heightBox((context.screenHeight * 0.1)),
                Text(
                  "Let's Sign in",
                  style: context.headlineMediumStyle!.copyWith(
                    color: AppColors.appTertiaryColor,
                  ),
                ),
                context.heightBox((3)),
                Text(
                  "Fill the details below to continue.",
                  style: context.bodySmallStyle!.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
                context.heightBox((context.screenHeight * 0.03)),
                Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        borderColor: AppColors.lightGreyColor.withOpacity(0.5),
                        fillColor:AppColors.mostLightGreyColor.withOpacity(0.5) ,
                        hintText: "Mobile Number",
                        prefixIcon: Iconsax.call,
                      ),
                      context.heightBox((context.screenHeight * 0.02)),
                      CustomTextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                        borderColor: AppColors.lightGreyColor.withOpacity(0.5),
                        fillColor:AppColors.mostLightGreyColor.withOpacity(0.5) ,
                        hintText: "Password",
                        prefixIcon: Iconsax.lock,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
