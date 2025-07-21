import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products_model.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class ViewProductsController extends GetxController {
  // Fetch products by company id from api

  RxList<Product> products = <Product>[].obs;
  RxList<Product> filteredProducts = <Product>[].obs; // For search results
  late GetCompaniesModel company;
  RxString searchQuery = "".obs;

  Future<void> fetchProducts() async {
    try {
      // products.value = await dataService.getCompanyProducts(int.parse(company.companyId));
      // filteredProducts.addAll(products);
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

  @override
  void onInit() {
    super.onInit();
    company = Get.arguments;
    fetchProducts();
    // Setup debounce for search (300ms delay)
    debounce(
      searchQuery.value.obs,
      (_) => searchProduct(searchQuery.value.toString().trim()),
      time: const Duration(milliseconds: 300),
    );
  }
}
