import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://10.0.2.2:5000/api/auth';

class AuthService {
  /// Fungsi untuk login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return {'success': true, 'data': data};
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Login gagal. Coba lagi.',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Respon dari server tidak dalam format JSON.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }
}
