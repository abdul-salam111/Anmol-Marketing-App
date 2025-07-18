
import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class ViewProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewProductsController());
    Get.lazyPut(() => SelectProductController());
  }
}
