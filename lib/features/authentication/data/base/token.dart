import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> storeToken(String token) async {

  await storage.write(key: 'token', value: token);
}
