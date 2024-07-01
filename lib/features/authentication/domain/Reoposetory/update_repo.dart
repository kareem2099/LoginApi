import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/constant/const.dart';


  Future<Map<String, dynamic>> updateUser({
    required String token,
    required String name,
    required String phone,
    required String location,
  }) async {
    final response = await http.patch(
      Uri.parse(apiUpdate),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'location': location,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }