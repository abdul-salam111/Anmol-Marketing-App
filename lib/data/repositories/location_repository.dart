import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/data.dart';

class LocationRepository {
  static final dioHelper = DioHelper();

  static Future<List<LocationModel>> getLocations() async {
  try {
    final response = await dioHelper.getApi(
      url: ApiKeys.getlocations,
      isAuthRequired: true,
      authToken: AppConstants.staticToken,
    );
    if (response is List) {
      return response.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      throw Exception("Expected a list but got ${response.runtimeType}");
    }
  } catch (error) {
    rethrow;
  }
}

}
