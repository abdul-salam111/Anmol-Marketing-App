import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/models/post_models/login_model.dart';
import 'package:anmol_marketing/data/repositories/auth_repository.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/services/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  Future loginUser() async {
    try {
      isLoading.value = true;
      final response = await AuthRepository.loginUser(
        LoginUserModel(
          loginId: phoneNumberController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      await SessionController().saveUserInStorage(response);
      await SessionController().getUserfromSharedpref();
      await Get.offAllNamed(AppRoutes.navbar);
      isLoading.value = false;

      phoneNumberController.clear();
      passwordController.clear();
    } catch (e) {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, e.toString());
    }
  }
}
