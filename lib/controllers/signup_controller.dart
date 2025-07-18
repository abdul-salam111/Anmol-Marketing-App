import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController whatsAppNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController pharmacyOwnerNameController = TextEditingController();
  final TextEditingController workPhoneController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postalAddressController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController licenseOwnerNameController = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

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
