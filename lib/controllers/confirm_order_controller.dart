import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/controllers/create_order_controller.dart';
import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/models/post_models/create_order_for_local.dart';
import 'package:anmol_marketing/data/models/post_models/create_order_model_for_api.dart';
import 'package:anmol_marketing/data/repositories/orders_repository.dart';
import 'package:anmol_marketing/views/widgets/success_popup.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ConfirmOrderController extends GetxController {
  RxList<OrderCompany> cartItems = <OrderCompany>[].obs;
  final RxInt totalProducts = 0.obs;
  final RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cartItems = Get.arguments[0];
    totalAmount.value = Get.arguments[1];
    totalProducts.value = Get.arguments[2];
  }

  var isLoading = false.obs;

  Future createOrder() async {
    try {
      isLoading.value = true;
      List<Row> productRows = [];

      for (int i = 0; i < cartItems.length; i++) {
        for (int j = 0; j < cartItems[i].products.length; j++) {
          final product = cartItems[i].products[j];

          productRows.add(
            Row(
              productId: product.productId,
              price: product.salePrice,
              qty: product.quantity,
            ),
          );
        }
      }

      final isCreated = await OrdersRepository.createOrder(
        CreateOrderModelApi(paymentModeId: 58, rows: productRows),
      );
      await Get.find<HomeController>().getLastOrder();
      await Get.find<CreateOrderController>().deleteAllOrder();

      isLoading.value = false;

      if (isCreated) {
        showSuccessPopup();
      }
    } on UnauthorizedException {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, "Please, login again and try!");
    } catch (error) {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, error.toString());
    }
  }
}
