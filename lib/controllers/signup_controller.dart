import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:anmol_marketing/data/models/post_models/register_user_model.dart';
import 'package:anmol_marketing/data/repositories/auth_repository.dart';
import 'package:anmol_marketing/data/repositories/location_repository.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController whatsAppNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController pharmacyOwnerNameController =
      TextEditingController();
  final TextEditingController workPhoneController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postalAddressController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController licenseExpiryDateController =
      TextEditingController();
  final TextEditingController licenseOwnerNameController =
      TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getLocations();
  }

  //this code is for getting town and sectors from api and then selecting towns and sectors
  final sectors = <Sector>[].obs;
  final selectedSector = Rxn<Sector>();
  final towns = <Town>[].obs;
  final selectedTown = Rxn<Town>();
  final selectedLocationId = 0.obs;
  void getLocations() async {
    try {
      final response =
          await LocationRepository.getLocations(); // List<LocationModel>
      final sectorList = buildSectorsFromJson(response);
      sectors.assignAll(sectorList);
    } catch (error) {
      AppToasts.showErrorToast(Get.context!, error.toString());
    }
  }

  void onSectorSelected(Sector sector) {
    selectedSector.value = sector;
    towns.assignAll(sector.towns);
    selectedTown.value = null; // reset town
  }

  void onTownSelected(Town town) {
    selectedTown.value = town;
    townController.text = town.name;
    selectedLocationId.value = town.id;
  }

  ////////////////////////
  RxBool isLoading = false.obs;

  Future createUser() async {
    try {
      isLoading.value = true;

      final getRegistrationResponse = await AuthRepository.signupUser(
        RegisterUserModel(
          customerName: pharmacyNameController.text,
          mobileNbr: whatsAppNumberController.text,
          password: passwordController.text,
          locationId: selectedLocationId.value,
          licenseNbr: licenseNumberController.text,
          owerName: licenseOwnerNameController.text,
          address: postalAddressController.text,
          licenseExpiryDate: licenseExpiryDateController.text,
        ),
      );

      isLoading.value = false;

      // Show dialog
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
              Text("Verify Account!", style: Get.context!.headlineSmallStyle),
              SizedBox(height: 10),
              Text(
                "Please, check your whatapp for code and verify your account.",
                textAlign: textAlignCenter,
                style: Get.context!.bodySmallStyle!.copyWith(
                  color: AppColors.greyColor,
                ),
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
                    navigateToVerification(getRegistrationResponse);
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
          navigateToVerification(getRegistrationResponse);
        }
      });

      // Clear form fields
      whatsAppNumberController.clear();
      passwordController.clear();
      pharmacyNameController.clear();
      pharmacyOwnerNameController.clear();
      workPhoneController.clear();
      selectedTown.value = null;
      selectedSector.value = null;
      licenseExpiryDateController.clear();
      licenseNumberController.clear();
      licenseOwnerNameController.clear();
    } catch (error) {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, error.toString());
    }
  }

  void navigateToVerification(getRegistrationResponse) {
    Get.toNamed(
      AppRoutes.phoneVerification,
      arguments: [
        getRegistrationResponse.customerId,
        getRegistrationResponse.otp,
      ],
    );
  }

  @override
  void onClose() {
    whatsAppNumberController.dispose();
    passwordController.dispose();
    pharmacyNameController.dispose();
    pharmacyOwnerNameController.dispose();
    workPhoneController.dispose();
    sectorController.dispose();
    townController.dispose();
    postalAddressController.dispose();
    licenseNumberController.dispose();
    licenseOwnerNameController.dispose();
    super.onClose();
  }
}
