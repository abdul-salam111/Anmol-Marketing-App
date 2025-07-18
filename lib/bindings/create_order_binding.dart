import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class CreateOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateOrderController());
  }
}
