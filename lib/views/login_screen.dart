// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/core/utils/validators.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/controllers.dart';
import '../core/core.dart';
import 'widgets/widgets.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
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
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.phoneNumberController,
                          keyboardType: TextInputType.phone,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Mobile Number",
                          prefixIcon: Iconsax.call,
                          validator: Validator.validatePhone,
                        ),
                        context.heightBox((context.screenHeight * 0.02)),
                        CustomTextFormField(
                          obscureText: true,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Password",
                          prefixIcon: Iconsax.lock,
                          validator: Validator.validatePassword,
                        ),
                        Align(
                          alignment: centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: context.bodySmallStyle!.copyWith(
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        context.heightBox((context.screenHeight * 0.02)),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            radius: 20,
                            text: "Sign In",
                            onPressed: () {
                              // if (controller.loginFormKey.currentState!
                              //     .validate()) {}
                              Get.offAllNamed(AppRoutes.navbar);
                            },
                            backgroundColor: AppColors.appPrimaryColor,
                          ),
                        ),
                        context.heightBox((context.screenHeight * 0.02)),
                        RichText(
                          text: TextSpan(
                            text: "Don’t have an account? ",
                            style: context.bodySmallStyle!.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Create New Account",
                                style: context.bodySmallStyle!.copyWith(
                                  color: AppColors.appPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signup);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
