import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class CatalogueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CatalogueController());
  }
}
