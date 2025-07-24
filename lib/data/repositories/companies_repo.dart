import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:anmol_marketing/data/database/database_helper.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/services/storage.dart';

class CompaniesRepository {
  static final dioHelper = DioHelper();

  static Future<List<GetCompaniesModel>> getCompaniesList() async {
    try {
      final response = await dioHelper.getApi(
        url: ApiKeys.getCompaniesList,
        isAuthRequired: true,
        authToken: await storage.userToken,
      );
      List<GetCompaniesModel> companiesList;
      if (response is List) {
        companiesList = response
            .map((company) => GetCompaniesModel.fromJson(company))
            .toList();
        return companiesList;
      } else {
        throw Exception("Expected a list but got ${response.runtimeType}");
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Fetch companies from the catalog table in local DB for catalog
  static final DatabaseHelper databaseHelper = DatabaseHelper();
  static Future<List<GetCompaniesModel>> fetchCatalogCompanies() async {
    try {
      final localCompanies = await databaseHelper.getCatalogCompanies();

      if (localCompanies.isNotEmpty) {
        return localCompanies;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<GetCompaniesModel>> fetchCompaniesFromLocal() async {
    try {
      final localCompanies = await databaseHelper.getCompanies();

      if (localCompanies.isNotEmpty) {
        return localCompanies;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  //insert and get companies in local DB
 static Future<List<GetCompaniesModel>> insertAndFetchCompanies() async {
    try {
      final localCompanies = await databaseHelper.getCompanies();

      if (localCompanies.isNotEmpty) {
        // If companies exist locally, use them
        return localCompanies;
      } else {
        // If no local companies, fetch from API
        final apiCompanies = await CompaniesRepository.getCompaniesList();

        // Store the fetched companies locally
        for (GetCompaniesModel company in apiCompanies) {
          if (company.companyId == null) {
            continue;
          }
          await databaseHelper.insertCompany(company);
          await databaseHelper.insertCompaniesToCatalog(company);
        }
        return await databaseHelper.getCompanies();
      }
    } catch (error) {
      rethrow;
    }
  }
}
