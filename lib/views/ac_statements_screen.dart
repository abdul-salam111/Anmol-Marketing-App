// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class AcStatementsScreen extends StatelessWidget {
  const AcStatementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "A/C Statements"),
      body: Padding(
        padding: screenPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: mainAxisCenter,
            crossAxisAlignment: crossAxisCenter,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xff81C784).withOpacity(0.1),
                child: Image.asset(
                  AppIcons.statementsicon,
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "A/C Statements",
                style: context.bodyLargeStyle!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: context.screenWidth * 0.75,
                child: Text(
                  "Account Statements will be available online soon. Meanwhile, please contact us directly at:",
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
                  onPressed: () {
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
