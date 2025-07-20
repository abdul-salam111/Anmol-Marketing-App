// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExpairyClaimScreen extends GetView {
  const ExpairyClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Expiry Claim"),
      body: Padding(
        padding: screenPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: mainAxisCenter,
            crossAxisAlignment: crossAxisCenter,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.orange.withOpacity(0.1),
                child: Image.asset(AppIcons.claimicon, height: 50, width: 50),
              ),
              SizedBox(height: 20),
              Text(
                "Expiry Claim",
                style: context.bodyLargeStyle!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: context.screenWidth * 0.75,
                child: Text(
                  "For any expiry-related claims, please contact the vendor directly at:",
                  style: context.bodySmallStyle!.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                  textAlign: textAlignCenter,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "0334-7555547",
                style: context.bodyLargeStyle!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 130,
                height: 40,
                child: CustomButton(
                  radius: 7,
                  text: "Call Now",
                  onPressed: () async {
                    launchCaller("03347555547");
                  },
                  fontsize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
