import 'package:anmol_marketing/services/splash_services.dart';
import 'package:get/get.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initApp();
  }
  SplashServices splashServices=SplashServices();

  _initApp() async {
    await Future.delayed(const Duration(seconds: 3));
   splashServices.isLoggedIn();
  }
}
