import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://waste-api.up.railway.app';

  // -----------------------------
  // LOGIN USER
  // -----------------------------
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login gagal: ${response.body}');
    }
  }

  // -----------------------------
  // REGISTER USER (STEP 1 - TANPA NAMA/PHONE)
  // -----------------------------
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register-user');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": "",            // Kosong sementara
        "email": email,
        "phone": "",           // Kosong sementara
        "password": password,
        "confirmPassword": confirmPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Gagal register');
    }
  }

  // -----------------------------
  // UPDATE PROFIL USER (STEP 2 - SETELAH ONBOARDING)
  // -----------------------------
  static Future<void> updateUserProfile({
    required String uid,
    required String name,
    required String phone,
    required String address,
    String? token, // Optional: jika pakai auth token
  }) async {
    final url = Uri.parse('$baseUrl/user/update/$uid');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "address": address,
      }),
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Gagal update profil');
    }
  }
}
