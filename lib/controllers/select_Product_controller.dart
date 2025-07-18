import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/models/get_models/cart_product.dart';
import 'package:get/get.dart';

class SelectProductController extends GetxController {
  RxString searchQuery = "".obs;

  List<Product> allProducts = [
    Product(
      name: "Actidil Elixir",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    Product(
      name: "Amoxil 250 mg Cap.",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    Product(
      name: "Ampiclox Drops",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
    Product(
      name: "Angised Tablets",
      pack: "1x10",
      tradePrice: 150,
      availableStock: 20,
    ),
  ];

  RxList<Product> filteredProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
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
      final results = allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.pack.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      filteredProducts.assignAll(results);
    }
  }

  RxDouble companyTotal = 0.0.obs;
  RxDouble orderTotal = 0.0.obs;

  final CreateOrderController createOrderController =
      Get.find<CreateOrderController>();

 void increaseQuantity(Product product) {
    product.quantity.value++;
    updateTotals();
    updateCartTotals();
    update(); // Notify listeners
  }

  void decreaseQuantity(Product product) {
    if (product.quantity.value > 0) {
      product.quantity.value--;
      updateTotals();
      updateCartTotals();
      update(); // Notify listeners
    }
  }

  void updateTotals() {
    companyTotal.value = filteredProducts.fold(0.0, (sum, product) {
      return sum + (product.tradePrice * product.quantity.value);
    });
    orderTotal.value = companyTotal.value;
  }

  void updateCartTotals() {
    final createOrderController = Get.find<CreateOrderController>();
    
    // Calculate total products (sum of all quantities)
    createOrderController.totalProducts.value = filteredProducts.fold(0, (sum, product) {
      return sum + product.quantity.value;
    });
    
    // Calculate total amount (sum of price * quantity)
    createOrderController.totalAmount.value = filteredProducts.fold(0.0, (sum, product) {
      return sum + (product.tradePrice * product.quantity.value);
    });
  }

  void addToCart(CartProducts cartProduct) {
    final createOrderController = Get.find<CreateOrderController>();
    final exists = createOrderController.cartItems.any(
      (product) => product.productId == cartProduct.productId,
    );

    if (!exists) {
      createOrderController.cartItems.add(cartProduct);
      updateCartTotals(); // Update totals when adding to cart
    } else {
      AppToasts.showErrorToast(Get.context!, "Product already exists");
    }
  }

}

class Product {
  final String name;
  final String pack;
  final int tradePrice;
  final int availableStock;
  RxInt quantity;

  Product({
    required this.name,
    required this.pack,
    required this.tradePrice,
    required this.availableStock,
    int quantity = 0,
  }) : quantity = quantity.obs;
}
