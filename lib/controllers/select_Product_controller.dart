import 'package:anmol_marketing/controllers/create_order_controller.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products_model.dart';
import 'package:anmol_marketing/data/models/post_models/create_order.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class SelectProductController extends GetxController {
  RxDouble companyTotal =
      0.0.obs; // total of the selected products in that company
  late RxDouble totalAmount; // grand total of overall order

  // Fetch products by company id from api

  RxList<Product> products = <Product>[].obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  late GetCompaniesModel company;
  RxString searchQuery = "".obs;

  Future<void> fetchProducts() async {
    try {
      // products.value = await dataService.getCompanyProducts(
      //   int.parse(company.companyId),
      // );
      // filteredProducts.value = products;
    } catch (e) {
      print(e);
    }
  }

  void searchProduct(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      // If search is empty, show all products
      filteredProducts.value = products;
    } else {
      // Filter products where productName contains the query (case-insensitive)
      filteredProducts.value = products.where((product) {
        return product.productName.toLowerCase().contains(searchQuery.value);
      }).toList();
    }
  }

  final CreateOrderController createOrderController =
      Get.find<CreateOrderController>();
  DatabaseHelper databaseHelper = DatabaseHelper();
 

  @override
  void onInit() {
    super.onInit();
    company = Get.arguments[0];
    totalAmount = Get.arguments[1];
    fetchProducts();
  }

  final RxMap<Product, int> productQuantities = <Product, int>{}.obs;

  void addProductQuantity(Product product, int quantity) {
    productQuantities[product] = quantity;
    double total = 0;
    productQuantities.forEach((product, qty) {
      total += product.tradePrice * qty;
    });
    companyTotal.value = total;
  }
}
