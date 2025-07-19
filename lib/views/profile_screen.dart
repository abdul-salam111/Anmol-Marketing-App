// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/core/utils/validators.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: CustomAppBar(title: "Profile"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: screenPadding,
              child: Column(
                children: [
                  SizedBox(height: context.screenHeight * 0.02),
                  Container(
                    height: context.screenHeight * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: mainAxisCenter,
                      children: [
                        CircleAvatar(
                          radius: 40,

                          child: Image.asset(
                            AppIcons.profileicon,
                            width: 50,
                            height: 50,
                            color: AppColors.appPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Softronix",
                          style: context.bodyMediumStyle!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "03115308116",
                          style: context.bodySmallStyle!.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 2, // How much the shadow spreads
                          blurRadius: 5, // Softness of the shadow
                          offset: Offset(
                            0,
                            3,
                          ), // Position of the shadow (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: padding20,
                      child: Column(
                        crossAxisAlignment: crossAxisStart,
                        children: [
                          Text(
                            "Change Password",
                            style: context.bodyMediumStyle!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            labelColor: Colors.black,
                            obscureText: true,
                            labelfontSize: 14,
                            label: "Old Password",
                            keyboardType: TextInputType.text,
                            borderColor: AppColors.lightGreyColor.withOpacity(
                              0.5,
                            ),

                            hintText: "Enter old password",
                            prefixIcon: Iconsax.lock,
                            validator: (lice) {
                              return Validator.validateRequired(
                                lice,
                                fieldName: "Old Password",
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            labelColor: Colors.black,
                            obscureText: true,
                            labelfontSize: 14,
                            label: "New Password",
                            keyboardType: TextInputType.text,
                            borderColor: AppColors.lightGreyColor.withOpacity(
                              0.5,
                            ),

                            hintText: "Enter new password",
                            prefixIcon: Iconsax.lock,
                            validator: (lice) {
                              return Validator.validateRequired(
                                lice,
                                fieldName: "New Password",
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            labelColor: Colors.black,
                            obscureText: true,
                            labelfontSize: 14,
                            label: "Confirm Password",
                            keyboardType: TextInputType.text,
                            borderColor: AppColors.lightGreyColor.withOpacity(
                              0.5,
                            ),

                            hintText: "Enter confirm password",
                            prefixIcon: Iconsax.lock,
                            validator: (lice) {
                              return Validator.validateRequired(
                                lice,
                                fieldName: "Confirm Password",
                              );
                            },
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: CustomButton(
                              radius: 10,
                              text: "Change Password",
                              onPressed: () {},
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: CustomButton(
                      radius: 10,
                      text: "Log Out",
                      onPressed: () {},
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
