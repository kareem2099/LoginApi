import 'dart:convert';
import 'package:http/http.dart';
import 'dart:io';

import '../../data/constant/const.dart';

class UserService {
  Future<Map<String, dynamic>> updateUser({
    required String token,
    required String name,
    required String phone,
    required String location,
    File? profilePic,
  }) async {
    try {
      var request = MultipartRequest('PATCH', Uri.parse(apiUpdate));
      request.headers['Authorization'] = 'Bearer $token';
      // request.headers['token'] = token;
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['location'] = location;

      if (profilePic != null) {
        request.files.add(await MultipartFile.fromPath('profilePic', profilePic.path));
      }

      var response = await request.send();

      print('Response status: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(responseBody),
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to update user: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }
}