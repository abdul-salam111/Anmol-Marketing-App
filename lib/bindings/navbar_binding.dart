import 'package:get/get.dart';

import '../controllers/controllers.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavbarController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CatalogueController());
    Get.lazyPut(() => CreateOrderController());
    Get.lazyPut(() => OrderHistoryController());
    Get.lazyPut(() => ProfileController());

  }
}
