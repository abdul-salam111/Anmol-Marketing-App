import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class CatalogueController extends GetxController {
  final searchQuery = "".obs;
  RxList<Company> companies = <Company>[].obs;
  RxList<Company> filterCompanies = <Company>[].obs;
  DataService dataService = DataService();
  RxBool isLoading = false.obs;
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
    
    // Initialize filterCompanies with empty list
    filterCompanies.value = [];
    
    ever(searchQuery, (value) {
      searchCompanies(value.trim());
    });
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      errorMessage('');
      filterCompanies.value = []; // Clear while loading

      final localCompanies = await databaseHelper.getCompanies();
      
      if (localCompanies.isNotEmpty) {
        companies.value = localCompanies;
        filterCompanies.value = localCompanies;
        return;
      }

      final apiCompanies = await dataService.getCompanies();
      companies.value = apiCompanies;
      filterCompanies.value = apiCompanies;
      
    
    } catch (e) {
      errorMessage.value = 'Failed to load companies';
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchCompanies(String query) {
    if (query.isEmpty) {
      filterCompanies.value = companies.toList();
    } else {
      final queryLower = query.toLowerCase();
      filterCompanies.value = companies.where((c) => 
        c.companyName.toLowerCase().contains(queryLower)
      ).toList();
    }
  }

  @override
  void onClose() {
    searchQuery.close();
    super.onClose();
  }
}