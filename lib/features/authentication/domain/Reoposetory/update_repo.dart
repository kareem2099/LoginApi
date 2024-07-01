import 'dart:convert';
import 'package:http/http.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      request.headers['Authorization'] = 'Bearer FOODAPI $token';

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

final _secureStorage =  FlutterSecureStorage();

Future<String?> getToken() async {
  return await _secureStorage.read(key: 'token');
}

void updateUserProfile() async {
  UserService userService = UserService();
  String? token = await getToken();

  if (token != null) { // Retrieve this from secure storage
    String name = 'kareem ehab';
    String phone = '01022876456';
    String location = '{"name":"Egypt","address":"meet halfa","coordinates":[1214451511,12541845]}';

    Map<String, dynamic> response = await userService.updateUser(
      token: token,
      name: name,
      phone: phone,
      location: location,
    );

    if (response['success']) {
      print('User updated successfully: ${response['data']}');
    } else {
      print('Error updating user: ${response['message']}');
    }
  } else {
    print('Token is missing');
  }
}
