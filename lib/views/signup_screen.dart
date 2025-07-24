// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/core/utils/validators.dart';
import 'package:anmol_marketing/data/models/get_models/get_location_model.dart';
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
                        context.heightBox((context.screenHeight * 0.01)),
                        Obx(() {
                          return DropdownButtonFormField<Sector>(
                            dropdownColor: Colors.white,
                            
                            style: context.bodySmallStyle!.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Sector",
                              hintStyle: context.bodySmallStyle!.copyWith(
                                color: AppColors.greyTextColor,
                              ),

                              prefixIcon: Icon(
                                Iconsax.map,
                                color: AppColors.greyColor,
                                size: 20,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.lightGreyColor.withOpacity(
                                    0.5,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: AppColors.mostLightGreyColor
                                  .withOpacity(0.5),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.greyColor,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                            ),
                            value: controller.selectedSector.value,
                            onChanged: (sector) {
                              if (sector != null) {
                                controller.onSectorSelected(sector);
                                controller.sectorController.text = sector.name;
                              }
                            },
                            items: controller.sectors.map((sector) {
                              return DropdownMenuItem(
                                
                                value: sector,
                                child: Text(sector.name),
                              );
                            }).toList(),
                          );
                        }),
                        context.heightBox((context.screenHeight * 0.01)),
                        Obx(() {
                          return DropdownButtonFormField<Town>(
                            dropdownColor: Colors.white,
                            isDense: true,
                            style: context.bodySmallStyle!.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Town",
                              hintStyle: context.bodySmallStyle!.copyWith(
                                color: AppColors.greyTextColor,
                              ),

                              prefixIcon: Icon(
                                Iconsax.location,
                                color: AppColors.greyColor,
                                size: 20,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.lightGreyColor.withOpacity(
                                    0.5,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: AppColors.mostLightGreyColor
                                  .withOpacity(0.5),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.greyColor,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                            ),
                            value: controller.selectedTown.value,
                            onChanged: (town) {
                              if (town != null) {
                                controller.onTownSelected(town);
                              }
                            },
                            items: controller.towns.map((town) {
                              return DropdownMenuItem(
                                value: town,
                                child: Text(town.name),
                              );
                            }).toList(),
                          );
                        }),

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
                          readonly: true,
                          controller: controller.licenseExpiryDateController,
                          keyboardType: TextInputType.text,
                          borderColor: AppColors.lightGreyColor.withOpacity(
                            0.5,
                          ),
                          fillColor: AppColors.mostLightGreyColor.withOpacity(
                            0.5,
                          ),
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              // Format the date (optional)
                              final formatted =
                                  "${pickedDate.year}-"
                                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                                  "${pickedDate.day.toString().padLeft(2, '0')}";
                              controller.licenseExpiryDateController.text =
                                  formatted;
                            }
                          },
                          hintText: "License Expiry",
                          prefixIcon: Iconsax.calendar,
                          validator: (lice) {
                            return Validator.validateRequired(
                              lice,
                              fieldName: "License Expiry",
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
                          child: Obx(
                            () => CustomButton(
                              isLoading: controller.isLoading.value,
                              radius: 20,
                              text: "Create an account",
                              onPressed: () async {
                                if (controller.signupFormKey.currentState!
                                    .validate()) {
                                  await controller.createUser();
                                }
                              
                              },
                              backgroundColor: AppColors.appPrimaryColor,
                            ),
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
