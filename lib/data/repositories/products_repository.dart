

import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/data.dart';

import 'package:anmol_marketing/services/storage.dart';

class ProductsRepository {
  static final _dioHelper = DioHelper();

  static Future<List<GetProductsModel>> getCompanyProducts(
    String companyId,
  ) async {
    try {
      final response = await _dioHelper.postApi(
        url: ApiKeys.getCompanyProductsList,
        isAuthRequired: true,
        authToken: await storage.userToken,
        requestBody: {"CompanyId": companyId},
      );
    

      List<GetProductsModel> productsList;
      if (response is List) {
        productsList = response
            .map((company) => GetProductsModel.fromJson(company))
            .toList();
        return productsList;
      } else {
        throw Exception("Expected a list but got ${response.runtimeType}");
      }
    } catch (error) {
      rethrow;
    }
  }
}
