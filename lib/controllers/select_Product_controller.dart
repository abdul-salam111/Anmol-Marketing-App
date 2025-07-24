import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/data/models/post_models/create_order_for_local.dart';
import 'package:anmol_marketing/data/repositories/products_repository.dart'
    show ProductsRepository;
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProductController extends GetxController {
  // Selected company's total order amount
  RxDouble companyTotal = 0.0.obs;

  // Overall total order amount (shared with CreateOrderController)
  RxDouble totalAmount = 0.0.obs;

  // Products and filtered products
  RxList<GetProductsModel> products = <GetProductsModel>[].obs;
  RxList<GetProductsModel> filteredProducts = <GetProductsModel>[].obs;

  // Arguments from navigation
  late GetCompaniesModel company;
  OrderCompany? orderCompany;

  // UI state variables
  RxString searchQuery = "".obs;
  RxBool isLoading = false.obs;

  // Quantity map: Product -> Quantity
  final RxMap<GetProductsModel, int> productQuantities =
      <GetProductsModel, int>{}.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Reference to CreateOrderController for updating shared values
  final CreateOrderController createOrderController =
      Get.find<CreateOrderController>();

  // Called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    resetState();

    // Get and validate navigation arguments
    if (Get.arguments != null && Get.arguments.length >= 2) {
      if (Get.arguments[0] is GetCompaniesModel) {
        company = Get.arguments[0];
      } else if (Get.arguments[0] is OrderCompany) {
        orderCompany = Get.arguments[0];
        company = GetCompaniesModel(
          companyId: orderCompany!.companyId,
          companyLogo: orderCompany!.companyLogo,
          companyName: orderCompany!.companyName,
        );
      }
      totalAmount = Get.arguments[1];
    }

    fetchProducts();
  }

  // Called when the controller is destroyed
  @override
  void onClose() {
    resetState();
    super.onClose();
  }

  /// Reset all controller data
  void resetState() {
    companyTotal.value = 0.0;
    products.clear();
    filteredProducts.clear();
    productQuantities.clear();
    searchQuery.value = "";
    isLoading.value = false;
    company = GetCompaniesModel(); // Reset company object
    orderCompany = null;
  }

  /// Fetch products for the selected company
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.clear();
      filteredProducts.clear();
      productQuantities.clear();

      // Fetch company products from API
      products.value = await ProductsRepository.getCompanyProducts(
        company.companyId!.toString(),
      );

      // Pre-fill product quantities if it's an existing order
      if (orderCompany != null) {
        for (var orderedProduct in orderCompany!.products) {
          final matchingProduct = products.firstWhereOrNull(
            (p) => p.productId == orderedProduct.productId,
          );
          if (matchingProduct != null) {
            productQuantities[matchingProduct] = orderedProduct.quantity;
          }
        }

        companyTotal.value = orderCompany!.companyTotal;
      }

      // Assign to filteredProducts for search
      filteredProducts.assignAll(products);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error fetching products: $e');
    }
  }

  /// Filter products by search query
  void searchProduct(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products.where((product) {
        return product.productName!.toLowerCase().contains(searchQuery.value);
      }).toList();
    }
  }

  /// Update quantity of a selected product
  void updateProductQuantity(GetProductsModel product, int quantity) {
    // Save the current total BEFORE updating
    final previousCompanyTotal = companyTotal.value;

    // Update or remove product from the map
    if (quantity <= 0) {
      productQuantities.remove(product);
    } else {
      productQuantities[product] = quantity;
    }

    // Recalculate the company total
    calculateTotals();

    // Update the shared grand total by adjusting the difference
    updateGrandTotalAmount(previousCompanyTotal);
  }

  /// Recalculate company total from selected products
  void calculateTotals() {
    double companyTotalValue = 0.0;

    productQuantities.forEach((product, qty) {
      companyTotalValue += product.tradePrice! * qty;
    });

    companyTotal.value = companyTotalValue;
  }

  /// Save order to local database
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

      // Check if an order already exists for this company
      final existingOrders = await _databaseHelper.getAllOrders();
      final existingOrder = existingOrders.firstWhereOrNull(
        (order) => order.companies.any((c) => c.companyId == company.companyId),
      );

      if (existingOrder != null) {
        isNewOrder = false;
        orderId = existingOrder.orderId;

        final companyExists = await _databaseHelper.doesCompanyExistInOrder(
          orderId,
          company.companyId!,
        );

        if (companyExists) {
          await _databaseHelper.updateOrderCompany(
            orderId: orderId,
            company: company,
            companyTotal: companyTotalValue,
            totalProducts: totalProductsCount,
          );

          await _databaseHelper.deleteOrderProducts(
            orderId,
            company.companyId!,
          );
        } else {
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

        await _databaseHelper.addOrderCompany(
          orderId: orderId,
          company: company,
          companyTotal: companyTotalValue,
          totalProducts: totalProductsCount,
        );
      }

      // Add all products to order
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

      // Update order totals if existing order
      if (!isNewOrder) {
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

      // Remove company from catalog (if it exists)
      final existsInCatalog = createOrderController.companies.any(
        (comp) => comp.companyId == company.companyId,
      );

      if (existsInCatalog) {
        await _databaseHelper.deleteCompanyById(company.companyId!);
      }

      // Refresh order page data and navigate back
      await createOrderController.refreshCreateOrderPageData();

      Get.offNamed(AppRoutes.navbar);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(
            isNewOrder
                ? 'Item added successfully!'
                : 'Item updated successfully!',
          ),

          duration: Duration(seconds: 2), // Optional
        ),
      );
    } catch (e) {
      print('Error saving order: $e');
      Get.snackbar('Error', 'Failed to save order: ${e.toString()}');
    }
  }

  void updateGrandTotalAmount(double previousCompanyTotal) {
    totalAmount.value =
        totalAmount.value - previousCompanyTotal + companyTotal.value;
  }
}
