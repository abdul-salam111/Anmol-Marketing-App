import 'package:anmol_marketing/controllers/navbar_controller.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/post_models/create_order_for_local.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  final RxString searchQuery = "".obs;
  final RxList<GetCompaniesModel> filterCompanies = <GetCompaniesModel>[].obs;

  // Observables for UI binding
  RxInt totalProducts = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Data lists
  RxList<GetCompaniesModel> companies = <GetCompaniesModel>[].obs;
  RxList<OrderModel> orders = <OrderModel>[]
      .obs; // I am getting the grand total and total products from here in the fetch order see the code for getting these..actully this list have all the companies and grand total and total products
  RxList<OrderCompany> cartItems = <OrderCompany>[]
      .obs; //This list is just for companies and proudcts that are selected within those companeis this list derived from orders

  // Called once when the controller is ready
  @override
  void onReady() {
    super.onReady();
    refreshCreateOrderPageData();
    // Listen to changes in searchQuery and apply filtering
    ever(searchQuery, (value) {
      searchCompanies(value.trim());
    });
  }

  /// Filter companies based on search query
  void searchCompanies(String query) {
    if (query.isEmpty) {
      filterCompanies.value = companies;
    } else {
      final lowerQuery = query.toLowerCase();
      filterCompanies.value = companies
          .where((c) => c.companyName!.toLowerCase().contains(lowerQuery))
          .toList();
    }
  }

  /// Load all necessary data for Create Order Page
  Future<void> refreshCreateOrderPageData() async {
    await fetchCompanies();
    await fetchOrders();
  }

  /// Fetch companies from the local database
  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      errorMessage('');
      final localCompanies =
          await CompaniesRepository.fetchCompaniesFromLocal();
      companies.value = localCompanies;
      filterCompanies.addAll(companies);
    } catch (e) {
      errorMessage('Failed to load companies');
    } finally {
      isLoading(false);
    }
  }

  /// Fetch orders from the local database
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final orderList = await _databaseHelper.getAllOrders();
      totalAmount.value = orderList.fold(
        0.0,
        (sum, order) => sum + (order.grandTotal),
      );
      totalProducts.value = orderList.fold(
        0,
        (sum, order) => sum + (order.totalProducts),
      );

      cartItems.value = orderList.expand((order) => order.companies).toList();
    } catch (e) {
      errorMessage('Failed to load orders');
    } finally {
      isLoading(false);
    }
  }

  /// Clear all orders and reload companies from catalog
  Future<void> deleteAllOrder() async {
    try {
      // Navigate to home after clearing
      Get.find<NavbarController>().currentIndex.value = 0;

      try {
        //step 1: delete orders

        await _databaseHelper.clearAllOrders();

        // Step 2: Clear companies table
        await _databaseHelper.clearCompaniesTable();
        // Step 3: Re-fetch and insert catalog companies
        companies.value = await _databaseHelper.getCatalogCompanies();
        for (GetCompaniesModel company in companies) {
          if (company.companyId != null) {
            await _databaseHelper.insertCompany(company);
          }
        }
        refreshCreateOrderPageData();
      } catch (error) {
        print('Error updating companies: $error');
      }
    } catch (error) {
      print('Error deleting all orders: $error');
    }
  }
}
