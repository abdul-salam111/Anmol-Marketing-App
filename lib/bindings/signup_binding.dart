import 'package:anmol_marketing/controllers/signup_controller.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings{
    @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}