// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

import 'widgets/widgets.dart';

class PhoneVerificationScreen extends GetView<PhoneVerificationController> {
  PhoneVerificationScreen({super.key});

  final defaultPinTheme = PinTheme(
    width: 70,
    height: 50,

    decoration: BoxDecoration(
      color: AppColors.mostLightGreyColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.darkGreyColor),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.appLightThemeBackground,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: crossAxisStart,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AppLogo(
                    width: context.screenWidth * 0.2,
                    height: context.screenHeight * 0.2,
                  ),
                ),
              ),
              context.heightBox((context.screenHeight * 0.05)),
              Text(
                "OTP Verification",
                style: context.headlineMediumStyle!.copyWith(
                  color: AppColors.appTertiaryColor,
                ),
              ),
              context.heightBox((3)),
              Text(
                "Please check your email to see the verification code.",
                style: context.bodySmallStyle!.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
              context.heightBox((context.screenHeight * 0.03)),
              Text(
                "OTP Code",
                style: context.headlineSmallStyle!.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
              context.heightBox((10)),

              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: controller.pinController,
                      focusNode: controller.focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 12),

                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },

                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.greyColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: AppColors.mostLightGreyColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.blackTextColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                    context.heightBox((20)),
                    Center(
                      child: OtpTimerButton(
                        buttonType: ButtonType.text_button,
                        controller: controller.controller,
                        onPressed: () => controller.requestOtp(),
                        text: Text('Resend OTP'),
                        duration: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  radius: 20,
                  text: "Verify",
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {}
                  },
                  backgroundColor: AppColors.appPrimaryColor,
                ),
              ),
              context.heightBox((context.screenHeight * 0.03)),
            ],
          ),
        ),
      ),
    );
  }
}
