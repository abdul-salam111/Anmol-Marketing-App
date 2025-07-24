import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/repositories/companies_repo.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<GetCompaniesModel> companies = <GetCompaniesModel>[].obs;

  Future<void> fetchCompanies() async {
    try {
      companies.value = await CompaniesRepository.insertAndFetchCompanies();
    } catch (e) {
      print('Error fetching companies: $e');
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchCompanies();
  }
}
