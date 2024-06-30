import 'package:auth_api/features/authentication/data/base/api_base.dart';
import 'package:auth_api/features/authentication/data/constant/const.dart';

class LoginRepo {
  final ApiBase apiBase = ApiBase();

  Future<dynamic> login({
    required String email,
    required String password
  }) async {
    Map<String, String> resBody = {
      "email": email, "password": password
    };
    final response = await apiBase.PostRequest(URL: apiLogin, body: resBody);
    print("the repo : $response");
    return response;
  }
}
