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

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appLightThemeBackground,
          surfaceTintColor: AppColors.appLightThemeBackground,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  Center(child: AppLogo(radius: 50)),
                  context.heightBox((context.screenHeight * 0.02)),

                  Text(
                    "Create an account",
                    style: context.headlineSmallStyle!.copyWith(
                      color: AppColors.appTertiaryColor,
                    ),
                  ),
                  context.heightBox((3)),
                  Text(
                    "Fill the details below to continue.",
                    style: context.displayLargeStyle!.copyWith(
                      color: AppColors.greyTextColor,
                    ),
                  ),
                  context.heightBox((context.screenHeight * 0.02)),
                  Form(
                    key: controller.signupFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.whatsAppNumberController,
                          keyboardType: TextInputType.phone,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "WhatsApp Number",
                          prefixIcon: Iconsax.call,
                          validator: Validator.validatePhone,
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
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

                        context.heightBox((context.screenHeight * 0.03)),
                        CustomTextFormField(
                          controller: controller.pharmacyNameController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Pharmacy Legal Name",
                          prefixIcon: Iconsax.card_edit,
                          validator: (pharname) {
                            return Validator.validateRequired(
                              pharname,
                              fieldName: "Pharmacy name",
                            );
                          },
                        ),
                        context.heightBox((context.screenHeight * 0.005)),

                        CustomTextFormField(
                          controller: controller.pharmacyOwnerNameController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Owner Name",
                          prefixIcon: Iconsax.profile_circle,
                          validator: (pharname) {
                            return Validator.validateRequired(
                              pharname,
                              fieldName: "Owner name",
                            );
                          },
                        ),

                        context.heightBox((context.screenHeight * 0.005)),

                        CustomTextFormField(
                          controller: controller.workPhoneController,
                          keyboardType: TextInputType.phone,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Phone Work",
                          prefixIcon: Iconsax.call,
                          validator: Validator.validatePhone,
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
                        CustomTextFormField(
                          controller: controller.sectorController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Sector",
                          prefixIcon: Iconsax.location,
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
                        CustomTextFormField(
                          controller: controller.townController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Town",
                          prefixIcon: Iconsax.map,
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
                        CustomTextFormField(
                          controller: controller.postalAddressController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "Postal Address",
                          prefixIcon: Iconsax.location,
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
                        CustomTextFormField(
                          controller: controller.licenseNumberController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "License#",
                          prefixIcon: Iconsax.card_edit,
                          validator: (lice) {
                            return Validator.validateRequired(
                              lice,
                              fieldName: "Licenese Number",
                            );
                          },
                        ),
                        context.heightBox((context.screenHeight * 0.005)),
                        CustomTextFormField(
                          controller: controller.licenseOwnerNameController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          hintText: "License Owner Name",
                          prefixIcon: Iconsax.profile_circle,
                          validator: (lice) {
                            return Validator.validateRequired(
                              lice,
                              fieldName: "Licenese owner Name",
                            );
                          },
                        ),

                        context.heightBox((context.screenHeight * 0.03)),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            radius: 20,
                            text: "Create an account",
                            onPressed: () {
                              if (controller.signupFormKey.currentState!
                                  .validate()) {}
                            },
                            backgroundColor: AppColors.appPrimaryColor,
                          ),
                        ),
                        context.heightBox((context.screenHeight * 0.02)),
                        RichText(
                          text: TextSpan(
                            text: "Have an account? ",
                            style: context.displayLargeStyle!.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign in",
                                style: context.displayLargeStyle!.copyWith(
                                  color: AppColors.appPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(AppRoutes.login);
                                  },
                              ),
                            ],
                          ),
                        ),
                        context.heightBox(30),
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
