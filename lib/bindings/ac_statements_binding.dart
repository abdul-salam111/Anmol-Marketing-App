import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:get/get.dart';

class AcStatementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AcStatementsController());
  }
}
