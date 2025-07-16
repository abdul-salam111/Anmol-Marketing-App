import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
