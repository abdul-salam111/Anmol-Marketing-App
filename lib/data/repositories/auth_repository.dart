import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/data.dart';
import 'package:anmol_marketing/data/models/post_models/register_user_model.dart';

class AuthRepository {
  static final dioHeloper = DioHelper();

  static Future<GetLoginResponse> loginUser(
    LoginUserModel loginUserModel,
  ) async {
    try {
      final response = await dioHeloper.postApi(
        url: ApiKeys.loginUrl,
        isAuthRequired: true,
        authToken: AppConstants.staticToken,
        requestBody: loginUserModel,
      );
      return GetLoginResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> signupUser(RegisterUserModel registerUserModel) async {
    try {
      await dioHeloper.postApi(
        url: ApiKeys.registerUser,
        isAuthRequired: true,
        authToken: AppConstants.staticToken,
        requestBody: registerUserModel,
      );
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
