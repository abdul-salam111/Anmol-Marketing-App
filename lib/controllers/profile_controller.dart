import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/services/storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Future<void> logoutUser() async {
    await storage.clearValues(StorageKeys.loggedIn);
    await storage.clearValues(StorageKeys.userDetails);
    await Get.offAllNamed(AppRoutes.login);
  }
}
