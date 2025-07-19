import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/post_models/create_order.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  RxInt totalProducts = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final DataService _dataService = DataService();

  RxList<Company> companies = <Company>[].obs;

  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      errorMessage('');

      // 1. Try local database first
      final localCompanies = await _databaseHelper.getCompanies();

      if (localCompanies.isNotEmpty) {
        companies.value = localCompanies;
      }
      // 2. Fallback to API if local is empty
      else {
        final apiCompanies = await _dataService.getCompanies();
        companies.value = apiCompanies;
      }
    } catch (e) {
      errorMessage('Failed to load companies');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  RxList<OrdersModel> cartItems = RxList<OrdersModel>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCompanies();
  }
}
