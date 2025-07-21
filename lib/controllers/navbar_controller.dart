import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<GetCompaniesModel> companies = <GetCompaniesModel>[].obs;
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> fetchCompanies() async {
    try {
      final localCompanies = await databaseHelper.getCompanies();
      if (localCompanies.isNotEmpty) {
        // If companies exist locally, use them
        companies.value = localCompanies;
      } else {
        // If no local companies, fetch from API
        final apiCompanies = await CompaniesRepository.getCompaniesList();
        companies.value = apiCompanies;
        // Store the fetched companies locally
        for (GetCompaniesModel company in apiCompanies) {
          await databaseHelper.insertCompany(company);
        }
      }
    } catch (e) {
      print('Error fetching companies: $e');
      // You might want to add error handling here
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }
}
