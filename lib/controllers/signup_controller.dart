import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:anmol_marketing/data/models/post_models/register_user_model.dart';
import 'package:anmol_marketing/data/repositories/auth_repository.dart';
import 'package:anmol_marketing/data/repositories/location_repository.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
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
      final isSuccess = await AuthRepository.signupUser(
        RegisterUserModel(
          customerName: pharmacyNameController.text,
          mobileNbr: whatsAppNumberController.text,
          password: passwordController.text,
          locationId: selectedLocationId.value,
          licenseNbr: licenseNumberController.text,

          owerName: licenseOwnerNameController.text,
          address: postalAddressController.text,
          phoneWork: workPhoneController.text,
          licenseExpiryDate: licenseExpiryDateController.text,
        ),
      );
      isLoading.value = false;

      if (isSuccess) {
        Get.toNamed(AppRoutes.phoneVerification);
      }
    } catch (error) {
      isLoading.value = false;

      AppToasts.showErrorToast(Get.context!, error.toString());
    }
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
