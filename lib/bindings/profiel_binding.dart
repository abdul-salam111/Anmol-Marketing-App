import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class ProfielBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
