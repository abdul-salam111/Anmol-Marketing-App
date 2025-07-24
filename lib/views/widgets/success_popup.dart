import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessPopup({String message = "Order placed successfully!"}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              height: 45,
              child: CustomButton(
                radius: 10,
                text: "Okay",
                fontsize: 12,
                backgroundColor: AppColors.appPrimaryColor,
                onPressed: () {
                  // Close dialog and go to main navbar
                  if (Get.isDialogOpen ?? false) Get.back();
                  Get.offAllNamed(AppRoutes.navbar);
                },
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
