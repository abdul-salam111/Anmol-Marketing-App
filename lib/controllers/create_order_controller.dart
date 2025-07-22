import 'package:anmol_marketing/controllers/navbar_controller.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/post_models/create_order.dart';
import 'package:get/get.dart';

import '../data/repositories/companies_repo.dart';

class CreateOrderController extends GetxController {
  RxInt totalProducts = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  RxList<GetCompaniesModel> companies = <GetCompaniesModel>[].obs;
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxList<OrderCompany> cartItems = <OrderCompany>[].obs;

  // Fetch companies from local database
  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      errorMessage('');
      final localCompanies = await _databaseHelper.getCompanies();

      if (localCompanies.isNotEmpty) {
        companies.value = localCompanies;
      }
    } catch (e) {
      errorMessage('Failed to load companies');
      print('Error fetching companies: $e');
    } finally {
      isLoading(false);
    }
  }

  // Fetch orders from local database
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final orderList = await _databaseHelper.getAllOrders();
      cartItems.value = orderList.expand((order) => order.companies).toList();

      isLoading(false);
    } catch (e) {
      errorMessage('Failed to load orders');
      print('Error fetching orders: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTotalAmount() async {
    try {
      final total = await _databaseHelper.getTotalAmount();
      totalAmount.value = total;
    } catch (e) {
      print('Error fetching total amount: $e');
      totalAmount.value = 0.0;
    }
  }

  Future<void> fetchTotalProducts() async {
    try {
      final total = await _databaseHelper.getTotalProducts();
      totalProducts.value = total;
    } catch (e) {
      print('Error fetching total products: $e');
      totalProducts.value = 0;
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchCompanies();
    fetchOrders();
    fetchTotalAmount(); // Load total amount
    fetchTotalProducts(); // Load total products
  }

  Future deleteAllOrder() async {
    try {
      Get.find<NavbarController>().currentIndex.value = 0;
      await fetchOrders();
      await fetchTotalAmount();
      await fetchTotalProducts();

    
      try {
        // First clear the existing companies table
        await _databaseHelper.clearCompaniesTable();

        // Then insert the new companies
        companies.value =await _databaseHelper.getCatalogCompanies();
        for (GetCompaniesModel company in companies) {
          if (company.companyId == null) {
            continue;
          }
          await _databaseHelper.insertCompany(company);
        }
      } catch (error) {
        print('Error updating companies: $error');
        // Handle error appropriately
      }
    } catch (error) {
      print(error);
    }
  }
}
