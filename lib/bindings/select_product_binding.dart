import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class SelectProductBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => SelectProductController(), fenix: true);
    Get.lazyPut(() => CreateOrderController());
  }
}
