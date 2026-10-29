import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Get saved JWT token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Check whether the user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout: delete the saved JWT token
  static Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}
