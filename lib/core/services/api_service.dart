import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Override SSL: hanya untuk testing/development
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ApiService {
  static const String baseUrl = 'https://fahmi.led.my.id';
  static const String tokenKey = 'idToken';

  static String? _token;
  static SharedPreferences? _prefs;

  /// Inisialisasi SharedPreferences dan load token jika ada
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString(tokenKey);
  }

  /// Mendapatkan token yang tersimpan
  static String? get token => _token;

  /// Simpan token ke SharedPreferences
  static Future<void> saveToken(String token) async {
    _token = token;
    await _prefs?.setString(tokenKey, token);
  }

  /// Hapus token saat logout
  static Future<void> clearToken() async {
    _token = null;
    await _prefs?.remove(tokenKey);
  }

  // -----------------------------
  // LOGIN USER
  // -----------------------------
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Simpan token jika tersedia di response
      if (data['token'] != null) {
        await saveToken(data['token']);
      }

      return data;
    } else {
      throw Exception('Login gagal: ${response.body}');
    }
  }

  // -----------------------------
  // REGISTER USER
  // -----------------------------
  static Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register-user');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Register gagal: ${response.body}');
    }
  }

  // -----------------------------
  // FORGOT PASSWORD
  // -----------------------------
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/forgot-password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengirim OTP: ${response.body}');
    }
  }

  // -----------------------------
  // VERIFY OTP
  // -----------------------------
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('OTP tidak valid: ${response.body}');
    }
  }

  // -----------------------------
  // RESET PASSWORD
  // -----------------------------
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'newPassword': newPassword}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Reset password gagal: ${response.body}');
    }
  }

  // -----------------------------
// REQUEST PICKUP
// -----------------------------
  static Future<void> requestPickup({
    required Map<String, double> wasteDetails,
    required String address,
    String? note,
    bool isPickup = true,
  }) async {
    if (_token == null) {
      throw Exception('User belum login');
    }

    final url = Uri.parse('$baseUrl/api/waste-pickup/request');

    final body = jsonEncode({
      'address': address,
      'note': note ?? '',
      'isPickup': isPickup,
      'wasteDetails': wasteDetails,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Gagal request pickup: ${response.body}');
    }
  }
  // -----------------------------
// UPDATE USERNAME
// -----------------------------
  static Future<void> updateUsername(String username) async {
    if (_token == null) throw Exception('User belum login');

    final url = Uri.parse('$baseUrl/api/user/username');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update username: ${response.body}');
    }
  }

// -----------------------------
// UPDATE PHONE NUMBER
// -----------------------------
  static Future<void> updatePhone(String phone) async {
    if (_token == null) throw Exception('User belum login');

    final url = Uri.parse('$baseUrl/api/user/phone');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update nomor HP: ${response.body}');
    }
  }

// -----------------------------
// UPDATE AVATAR (UPLOAD FILE)
// -----------------------------
  static Future<void> updateAvatar(File avatarFile) async {
    if (_token == null) throw Exception('User belum login');

    final url = Uri.parse('$baseUrl/api/user/avatar');
    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $_token'
      ..files.add(await http.MultipartFile.fromPath('avatar', avatarFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal update avatar: ${response.body}');
    }
  }
  // -----------------------------
// GET USER PROFILE
// -----------------------------
  static Future<Map<String, dynamic>> getUserProfile() async {
    if (_token == null) {
      throw Exception('User belum login');
    }

    final url = Uri.parse('$baseUrl/api/user/profile');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil profil user: ${response.body}');
    }
  }

}




