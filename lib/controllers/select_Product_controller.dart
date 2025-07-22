import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/data/models/post_models/create_order.dart';
import 'package:anmol_marketing/data/repositories/products_repository.dart'
    show ProductsRepository;
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:get/get.dart';

class SelectProductController extends GetxController {
  RxDouble companyTotal =
      0.0.obs; // total of the selected products in that company
  RxDouble totalAmount = 0.0.obs; // grand total of overall orders

  // Fetch products by company id from api
  RxList<GetProductsModel> products = <GetProductsModel>[].obs;
  RxList<GetProductsModel> filteredProducts =
      <GetProductsModel>[].obs; // For search results
  late GetCompaniesModel company;
  OrderCompany? orderCompany;
  RxString searchQuery = "".obs;
  RxBool isLoading = false.obs;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.clear(); // Clear existing products
      filteredProducts.clear();
      productQuantities.clear(); // Clear any existing quantities
      if (orderCompany == null) {
        products.value = await ProductsRepository.getCompanyProducts(
          company.companyId!.toString(),
        );
      } else {
        products.value = await ProductsRepository.getCompanyProducts(
          company.companyId!.toString(),
        );
        for (var orderedProduct in orderCompany!.products) {
          final matchingProduct = products.firstWhereOrNull(
            (p) => p.productId == orderedProduct.productId,
          );

          if (matchingProduct != null) {
            productQuantities[matchingProduct] = orderedProduct.quantity;
          }

          companyTotal.value = orderCompany!.companyTotal;
        }
      }

      filteredProducts.assignAll(products);
      print(orderCompany!.products.map((e) => e));
      isLoading.value = false;
    } catch (e) {
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
resetState();
    if (Get.arguments[0] is GetCompaniesModel) {
      company = Get.arguments[0];
    } else {
      orderCompany = Get.arguments[0];
      company = GetCompaniesModel(
        companyId: orderCompany!.companyId,
        companyLogo: orderCompany!.companyLogo,
        companyName: orderCompany!.companyName,
      );
    }
    totalAmount = Get.arguments[1];
    fetchProducts();

    debounce(
      searchQuery.value.obs,
      (_) => searchProduct(searchQuery.value.toString().trim()),
      time: const Duration(milliseconds: 300),
    );
  }

  CreateOrderController createOrderController =
      Get.find<CreateOrderController>();
  final RxMap<GetProductsModel, int> productQuantities =
      <GetProductsModel, int>{}.obs;

  Future<void> saveOrder() async {
    try {
      if (productQuantities.isEmpty) {
        Get.snackbar('Error', 'Please add at least one product');
        return;
      }

      // Calculate totals
      double companyTotalValue = 0.0;
      int totalProductsCount = productQuantities.length;

      productQuantities.forEach((product, qty) {
        companyTotalValue += product.tradePrice! * qty;
      });

      String orderId = '';
      bool isNewOrder = true;

      // Check if this company already has an order
      final existingOrders = await _databaseHelper.getAllOrders();
      final existingOrder = existingOrders.firstWhereOrNull(
        (order) => order.companies.any((c) => c.companyId == company.companyId),
      );

      if (existingOrder != null) {
        // Update existing order
        orderId = existingOrder.orderId;
        isNewOrder = false;

        // Check if company exists in this order
        final companyExists = await _databaseHelper.doesCompanyExistInOrder(
          orderId,
          company.companyId!,
        );

        if (companyExists) {
          // Update existing company in order
          await _databaseHelper.updateOrderCompany(
            orderId: orderId,
            company: company,
            companyTotal: companyTotalValue,
            totalProducts: totalProductsCount,
          );

          // Delete existing products for this company
          await _databaseHelper.deleteOrderProducts(
            orderId,
            company.companyId!,
          );
        } else {
          // Add new company to existing order
          await _databaseHelper.addOrderCompany(
            orderId: orderId,
            company: company,
            companyTotal: companyTotalValue,
            totalProducts: totalProductsCount,
          );
        }
      } else {
        // Create new order
        orderId = await _databaseHelper.createOrder(
          grandTotal: companyTotalValue,
          totalProducts: totalProductsCount,
        );

        if (orderId.isEmpty) throw Exception('Failed to create order');

        // Add company to order
        await _databaseHelper.addOrderCompany(
          orderId: orderId,
          company: company,
          companyTotal: companyTotalValue,
          totalProducts: totalProductsCount,
        );
      }

      // Add all products to the order
      for (final entry in productQuantities.entries) {
        final product = entry.key;
        final quantity = entry.value;

        await _databaseHelper.addOrderProduct(
          orderId: orderId,
          companyId: company.companyId!,
          product: product,
          quantity: quantity,
          totalPrice: product.tradePrice! * quantity,
        );
      }

      // Update order totals if it's an existing order
      if (!isNewOrder) {
        // Recalculate the grand total for the order
        final orderCompanies = await _databaseHelper.getOrderCompanies(orderId);
        double newGrandTotal = 0.0;
        int newTotalProducts = 0;

        for (var comp in orderCompanies) {
          newGrandTotal += comp['companyTotal'] as double;
          newTotalProducts += comp['totalProducts'] as int;
        }

        await _databaseHelper.updateOrderTotals(
          orderId: orderId,
          grandTotal: newGrandTotal,
          totalProducts: newTotalProducts,
        );
      }

      // Remove company from catalog if it exists
      final exists = createOrderController.companies.any(
        (comp) => comp.companyId == company.companyId,
      );

      if (exists) {
        await _databaseHelper.deleteCompanyById(company.companyId!);
      }
      await createOrderController.fetchOrders();
      await createOrderController.fetchTotalAmount();
      await createOrderController.fetchTotalProducts();

      Get.toNamed(AppRoutes.navbar);
      Get.snackbar(
        'Success',
        isNewOrder
            ? 'Order created successfully'
            : 'Order updated successfully',
      );
    } catch (e) {
      print('Error saving order: $e');
      Get.snackbar('Error', 'Failed to save order: ${e.toString()}');
    }
  }

  void updateProductQuantity(GetProductsModel product, int quantity) {
    if (quantity <= 0) {
      productQuantities.remove(product);
    } else {
      productQuantities[product] = quantity;
    }

    calculateTotals();
  }

  void calculateTotals() {
    double companyTotalValue = 0.0;

    productQuantities.forEach((product, qty) {
      companyTotalValue += product.tradePrice! * qty;
    });

    companyTotal.value = companyTotalValue;
    // Don't accumulate here - just set the current company's total
    // The CreateOrderController will handle summing all companies' totals
  }

   void resetState() {
    companyTotal.value = 0.0;
    products.clear();
    filteredProducts.clear();
    productQuantities.clear();
    searchQuery.value = "";
    isLoading.value = false;
  }
  @override
  void onClose() {
    resetState(); // Clean up when controller is closed
    super.onClose();
  }
}
