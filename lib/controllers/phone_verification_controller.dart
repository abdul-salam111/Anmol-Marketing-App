import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:anmol_marketing/data/models/post_models/verify_otp.dart';
import 'package:anmol_marketing/data/repositories/auth_repository.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../core/core.dart';
import '../views/widgets/custom_button.dart';

class PhoneVerificationController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OtpTimerButtonController controller = OtpTimerButtonController();

  late int customerId;
  late String otp;

  RxBool isLoading = false.obs;

  Future verifyOpt() async {
    try {
      isLoading.value = true;
      await AuthRepository.verifyOtp(
        VerifyOtpModel(
          customerId: Get.arguments[0].toString(),
          otp: pinController.text.trim(),
        ),
      );
      isLoading.value = false;
      Get.defaultDialog(
        title: "",
        content: Padding(
          padding: padding14,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 40,
                child: Icon(Icons.check, size: 40, color: Colors.white),
              ),

              SizedBox(height: 20),
              Text("Account Verified!", style: Get.context!.headlineSmallStyle),
              SizedBox(height: 10),
              Text(
                "Your accout has been verified, please login to continue.",
                style: Get.context!.bodySmallStyle!.copyWith(
                  color: AppColors.greyColor,
                ),
                textAlign: textAlignCenter,
              ),
              SizedBox(height: 20),

              SizedBox(
                width: 100,
                child: CustomButton(
                  backgroundColor: AppColors.appPrimaryColor,
                  radius: 10,
                  text: "Verify",
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Automatically navigate after 7 seconds
      Future.delayed(const Duration(seconds: 7), () {
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close dialog
          Get.offAllNamed(AppRoutes.login);
        }
      });
    }  catch (error) {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, error.toString());
    }
  }

  requestOtp() {
    controller.loading();
    Future.delayed(Duration(seconds: 2), () {
      controller.startTimer();
    });
  }

  @override
  void onInit() {
    super.onInit();
    customerId = Get.arguments[0];
    otp = Get.arguments[1];
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
