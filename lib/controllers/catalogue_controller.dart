import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class CatalogueController extends GetxController {
  // Search input from user
  final RxString searchQuery = "".obs;

  // All companies fetched from DB
  final RxList<GetCompaniesModel> companies = <GetCompaniesModel>[].obs;

  // Filtered companies shown in UI
  final RxList<GetCompaniesModel> filterCompanies = <GetCompaniesModel>[].obs;

  // Loading and error state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onReady() {
    super.onReady();
    fetchCompanies();

    // Listen to changes in searchQuery and apply filtering
    ever(searchQuery, (value) {
      searchCompanies(value.trim());
    });
  }

  /// Fetch companies from the catalog table in local DB
  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      filterCompanies.clear();
      final localCompanies = await CompaniesRepository.fetchCatalogCompanies();
      companies.value = localCompanies;
      filterCompanies.value = localCompanies;
    } catch (e) {
      errorMessage.value = 'Failed to load companies';
    } finally {
      isLoading.value = false;
    }
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

  @override
  void onClose() {
    searchQuery.close();
    super.onClose();
  }
}
