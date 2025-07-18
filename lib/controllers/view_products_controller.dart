
import 'package:anmol_marketing/controllers/catalogue_controller.dart';
import 'package:get/get.dart';

class ViewProductsController extends GetxController {
  RxString searchQuery="".obs;
  
  List<ViewProduct> allProducts = [
    ViewProduct(
      name: "Actidil Elixir",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    ViewProduct(
      name: "Amoxil 250 mg Cap.",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    ViewProduct(
      name: "Ampiclox Drops",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    ViewProduct(
      name: "Angised Tablets",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
  ];

  RxList<ViewProduct> filteredProducts = <ViewProduct>[].obs;
  late CompanyModel company;
  @override
  void onInit() {
    super.onInit();
    company=Get.arguments;
    filteredProducts.assignAll(allProducts); // Initialize with all products
    
    // Setup debounce for search (300ms delay)
    debounce(
      searchQuery.value.obs,
      (_) => searchProducts(searchQuery.value.toString().trim()),
      time: const Duration(milliseconds: 300),
    );
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(allProducts);
    } else {
      final results = allProducts.where((product) => 
        product.name.toLowerCase().contains(query.toLowerCase()) ||
        product.pack.toLowerCase().contains(query.toLowerCase())
      ).toList();
      filteredProducts.assignAll(results);
    }
  }

 
}

class ViewProduct {
  final String name;
  final String pack;
  final int tradePrice;
  final int availableStock;
  int quantity;

  ViewProduct({
    required this.name,
    required this.pack,
    required this.tradePrice,
    required this.availableStock,
    this.quantity = 0,
  });
}
