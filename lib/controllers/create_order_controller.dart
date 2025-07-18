import 'package:anmol_marketing/controllers/catalogue_controller.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  RxList<CartProducts> cartItems = <CartProducts>[].obs;
  RxList<CompanyModel> companies = <CompanyModel>[
    CompanyModel(
      name: 'Abbott Laboratories Pakistan',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'The Searle Company',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
  ].obs;

  RxInt totalProducts = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  
}
