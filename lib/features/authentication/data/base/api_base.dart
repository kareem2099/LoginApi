import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBase {

  Future<dynamic> PostRequest(
      {required String URL, required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse(URL),
        body: jsonEncode(body),
        headers: {"content-type": "application/json"},
      );
      return [responseJson(response), response.statusCode];
    } catch (e) {
      return e;
    }
  }

Future<dynamic> PatchRequest(
    {required String URL, required String token, required Map<String, dynamic> body}) async {
  try {
    final response = await http.patch(
      Uri.parse(URL),
      body: jsonEncode(body),
      headers: {"content-type": "application/json","Authorization" : "Bearer $token"
      },
    );
    return [responseJson(response), response.statusCode];
  } catch (e) {
    return e;
  }
}
  Future<dynamic> deleteRequest(
      {required String URL, required String token}) async {
    try {
      final response = await http.patch(
        Uri.parse(URL),
        headers: {"Authorization" : "Bearer $token"
        },
      );
      return [responseJson(response), response.statusCode];
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getRequest(
      {required String URL, required String token}) async {
    try {
      final response = await http.patch(
        Uri.parse(URL),
        headers: {"Authorization" : "Bearer $token"
        },
      );
      return [responseJson(response), response.statusCode];
    } catch (e) {
      return e;
    }
  }
}

dynamic responseJson(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 400:
      return jsonDecode(response.body);
    default:
      return Exception("status Error ${response.statusCode}, ${response.body}");
  }
}
