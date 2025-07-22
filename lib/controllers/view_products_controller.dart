import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/data/repositories/products_repository.dart';
import 'package:get/get.dart';

class ViewProductsController extends GetxController {
  // Fetch products by company id from api
  RxList<GetProductsModel> products = <GetProductsModel>[].obs;
  RxList<GetProductsModel> filteredProducts =
      <GetProductsModel>[].obs; // For search results
  late GetCompaniesModel company;
  RxString searchQuery = "".obs;
  RxBool isLoading = false.obs;

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      products.value = await ProductsRepository.getCompanyProducts(
        company.companyId!.toString(),
      );
      filteredProducts.assignAll(products);
   
      isLoading.value = false;
    }  catch (e) {
      isLoading.value = false;

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
        return product.productName!.toLowerCase().contains(searchQuery.value);
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
