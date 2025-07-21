import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/data.dart';
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
}
