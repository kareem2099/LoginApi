import 'dart:convert';
import 'dart:io';

import 'package:auth_api/features/authentication/data/base/api_base.dart';
import 'package:auth_api/features/authentication/data/constant/const.dart';
import 'package:http/http.dart' as http;


class RegisterRepo {
  final ApiBase apiBase = ApiBase();

  Future<dynamic> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Map<String, dynamic> location,
    File? profilePic,
    required String confirmPassword, // Add profilePic parameter
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiReg));
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['password'] = password;
    request.fields['confirmPassword'] = password; // Assuming confirmPassword is the same as password
    request.fields['location'] = jsonEncode(location);

    if (profilePic != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePic', profilePic.path));
    }

    var response = await request.send();
    // Handle the StreamedResponse
    if (response.statusCode == 200 || response.statusCode == 400) {
      final responseBodyString = await response.stream.bytesToString(); // Read the stream into a string
      final responseBody = jsonDecode(responseBodyString); // Decode the JSON string
      return [responseBody, response.statusCode];
    } else {
      // Handle other status codes or errors
      return [response, response.statusCode];
    }
  }
}