import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

   _initApp() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.delete<SplashController>();
    Get.toNamed(AppRoutes.login);

    //
    // // Example: check login or just navigate
    // bool isLoggedIn = false; // replace with your logic

    // if (isLoggedIn) {
    //   Get.offAllNamed(AppRoutes.home);
    // } else {
    //   Get.offAllNamed(AppRoutes.login);
    // }
  }
}
