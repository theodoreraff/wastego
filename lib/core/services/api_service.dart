import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

/// Custom Exception for session expiry
class SessionExpiredException implements Exception {
  final String message;
  SessionExpiredException(this.message);

  @override
  String toString() => 'SessionExpiredException: $message';
}

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
  static const String userIdKey = 'userId'; // This is the internal DB ID
  static const String wgoIdKey = 'wgoId'; // This is the user-facing WGO-ID
  static const String usernameKey = 'username';
  static const String avatarUrlKey = 'avatarUrl';

  static String? _token;
  static String? _userId; // Internal DB ID
  static String? _wgoId; // User-facing WGO-ID
  static String? _username;
  static String? _avatarUrl;

  static SharedPreferences? _prefs;

  /// Inisialisasi SharedPreferences dan load token serta user data jika ada
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString(tokenKey);
    _userId = _prefs?.getString(userIdKey);
    _wgoId = _prefs?.getString(wgoIdKey); // Load wgoId
    _username = _prefs?.getString(usernameKey);
    _avatarUrl = _prefs?.getString(avatarUrlKey);
  }

  /// Mendapatkan token yang tersimpan
  static String? get token => _token;
  static String? get userId => _userId; // Internal DB ID
  static String? get wgoId => _wgoId; // User-facing WGO-ID
  static String? get username => _username;
  static String? get avatarUrl => _avatarUrl;

  /// Simpan token ke SharedPreferences
  static Future<void> saveToken(String token) async {
    _token = token;
    await _prefs?.setString(tokenKey, token);
  }

  /// Simpan data pengguna ke SharedPreferences
  static Future<void> saveUserData({
    required String userId, // Internal DB ID
    String? wgoId, // User-facing WGO-ID
    required String username,
    String? avatarUrl,
  }) async {
    _userId = userId;
    _wgoId = wgoId; // Store wgoId
    _username = username;
    _avatarUrl = avatarUrl;

    await _prefs?.setString(userIdKey, userId);
    if (wgoId != null) {
      await _prefs?.setString(wgoIdKey, wgoId); // Save wgoId to prefs
    } else {
      await _prefs?.remove(wgoIdKey);
    }
    await _prefs?.setString(usernameKey, username);
    if (avatarUrl != null) {
      await _prefs?.setString(avatarUrlKey, avatarUrl);
    } else {
      await _prefs?.remove(avatarUrlKey);
    }
  }

  /// Memuat data pengguna dari SharedPreferences
  static Map<String, String?> loadUserData() {
    return {
      'userId': _prefs?.getString(userIdKey),
      'wgoId': _prefs?.getString(wgoIdKey), // Return wgoId
      'username': _prefs?.getString(usernameKey),
      'avatarUrl': _prefs?.getString(avatarUrlKey),
    };
  }

  /// Hapus token dan data pengguna saat logout
  static Future<void> clearAuthData() async {
    _token = null;
    _userId = null;
    _wgoId = null; // Clear wgoId
    _username = null;
    _avatarUrl = null;

    await _prefs?.remove(tokenKey);
    await _prefs?.remove(userIdKey);
    await _prefs?.remove(wgoIdKey); // Remove wgoId from prefs
    await _prefs?.remove(usernameKey);
    await _prefs?.remove(avatarUrlKey);
  }

  // -----------------------------
  // LOGIN USER
  // -----------------------------
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tokenData = data['token'] as String?;
      final apiUserData = data['user'] as Map<String, dynamic>?;

      if (tokenData != null) {
        await saveToken(tokenData);
      }

      String? finalUserId;
      String? finalUsername;
      // wgoId and avatarUrl are not expected in the direct login response.
      // They will be fetched by ProfileProvider later.

      if (apiUserData != null) {
        finalUserId = apiUserData['uid']?.toString();
        finalUsername = apiUserData['username'] as String?;
      }

      await saveUserData(
        userId: finalUserId ?? '', // Ensure userId is not null
        wgoId: null, // Not in login response
        username: finalUsername ?? '', // Ensure username is not null
        avatarUrl: null, // Not in login response
      );
      return data;
    } else {
      // Handle non-200 responses, including potential 401/403 for login failure
      if (response.statusCode == 401 || response.statusCode == 403) {
        // Though login itself failing with 401/403 might not mean session expired,
        // but rather invalid credentials. For consistency, we can treat it similarly
        // or have more specific error handling. For now, generic login failure.
        await clearAuthData(); // Clear any potentially stale data
        try {
          final errorData = jsonDecode(response.body);
          throw Exception(
            errorData['message'] ?? 'Login gagal: ${response.reasonPhrase}',
          );
        } catch (e) {
          throw Exception(
            'Login gagal: Status ${response.statusCode}, ${response.reasonPhrase}',
          );
        }
      }
      // For other errors
      try {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ?? 'Login gagal: ${response.reasonPhrase}',
        );
      } catch (e) {
        throw Exception(
          'Login gagal: Status ${response.statusCode}, ${response.reasonPhrase}',
        );
      }
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
        'username': username, // This username is for the registration body
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // No token is returned in the registration response based on the provided structure.

      final apiUserData = data['user'] as Map<String, dynamic>?;

      String? userIdValue;
      String? wgoIdValue;
      String? usernameValue;
      String?
      roleValue; // Though not explicitly saved by saveUserData currently
      // Avatar is not in the provided register response example for the 'user' object.
      // If it were, it would be: String? avatarValue;

      if (apiUserData != null) {
        userIdValue = apiUserData['uid']?.toString();
        wgoIdValue = apiUserData['wgoId'] as String?;
        usernameValue = apiUserData['username'] as String?;
        roleValue = apiUserData['role'] as String?;
        // if (apiUserData.containsKey('avatar')) {
        //   avatarValue = apiUserData['avatar'] as String?;
        // }
      }

      // Save the extracted user data.
      // Note: ApiService.saveUserData does not currently store 'role'.
      // Avatar is also not present in the 'user' object of your register response example.
      await saveUserData(
        userId: userIdValue ?? '', // Ensure userId is not null
        wgoId: wgoIdValue, // Can be null
        username: usernameValue ?? '', // Ensure username is not null
        avatarUrl:
            null, // Avatar not in register response 'user' object example
      );

      return data; // Return the original data
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ?? 'Register gagal: ${response.reasonPhrase}',
      );
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
      // If token is null, it's effectively a session issue.
      await clearAuthData();
      throw SessionExpiredException('User belum login. Silakan login kembali.');
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

    if (response.statusCode == 401 || response.statusCode == 403) {
      await clearAuthData();
      throw SessionExpiredException(
        'Sesi Anda telah berakhir. Silakan login kembali.',
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ??
            'Gagal request pickup: ${response.reasonPhrase}',
      );
    }
  }

  // -----------------------------
  // UPDATE USERNAME
  // -----------------------------
  static Future<void> updateUsername(String username) async {
    if (_token == null) {
      await clearAuthData();
      throw SessionExpiredException('User belum login. Silakan login kembali.');
    }

    final url = Uri.parse('$baseUrl/api/user/username');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode == 401 || response.statusCode == 403) {
      await clearAuthData();
      throw SessionExpiredException(
        'Sesi Anda telah berakhir. Silakan login kembali.',
      );
    }

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ??
            'Gagal update username: ${response.reasonPhrase}',
      );
    }
  }

  // -----------------------------
  // UPDATE PHONE NUMBER
  // -----------------------------
  static Future<void> updatePhone(String phone) async {
    if (_token == null) {
      await clearAuthData();
      throw SessionExpiredException('User belum login. Silakan login kembali.');
    }

    final url = Uri.parse('$baseUrl/api/user/phone');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode == 401 || response.statusCode == 403) {
      await clearAuthData();
      throw SessionExpiredException(
        'Sesi Anda telah berakhir. Silakan login kembali.',
      );
    }

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ??
            'Gagal update nomor HP: ${response.reasonPhrase}',
      );
    }
  }

  // -----------------------------
  // UPDATE AVATAR (UPLOAD FILE)
  // -----------------------------
  // Returns the new avatar URL or relevant user data from the response

  static Future<Map<String, dynamic>> updateAvatar(File avatarFile) async {
    if (_token == null) {
      print('[updateAvatar] Token null. User belum login.');
      await clearAuthData();
      throw SessionExpiredException('User belum login. Silakan login kembali.');
    }

    final url = Uri.parse('$baseUrl/api/user/avatar');
    print('[updateAvatar] Endpoint: $url');
    print('[updateAvatar] File path: ${avatarFile.path}');
    print('[updateAvatar] Token: $_token');

    // Cek ekstensi file
    final ext = avatarFile.path.split('.').last.toLowerCase();
    final allowedExtensions = ['jpg', 'jpeg', 'png'];
    if (!allowedExtensions.contains(ext)) {
      throw Exception('File harus berformat JPG, JPEG, atau PNG');
    }

    // Tentukan content-type sesuai ekstensi
    MediaType contentType;
    if (ext == 'png') {
      contentType = MediaType('image', 'png');
    } else {
      contentType = MediaType('image', 'jpeg'); // jpg dan jpeg sama MIME type
    }

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $_token'
      ..files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          avatarFile.path,
          contentType: contentType,
        ),
      );

    print('[updateAvatar] Sending PUT request...');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('[updateAvatar] Status Code: ${response.statusCode}');
    print('[updateAvatar] Response Body: ${response.body}');

    if (response.statusCode == 401 || response.statusCode == 403) {
      print('[updateAvatar] Token expired or unauthorized.');
      await clearAuthData();
      throw SessionExpiredException(
        'Sesi Anda telah berakhir. Silakan login kembali.',
      );
    }

    if (response.statusCode == 200) {
      print('[updateAvatar] Avatar update successful.');
      return jsonDecode(response.body);
    } else {
      try {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        print('[updateAvatar] Error: $errorMessage');
        throw Exception('Gagal update avatar: $errorMessage');
      } catch (e) {
        print('[updateAvatar] JSON parsing failed or unknown error: $e');
        throw Exception(
          'Gagal update avatar: Status ${response.statusCode}, ${response.reasonPhrase}',
        );
      }
    }
  }


  // -----------------------------
  // GET USER PROFILE
  // -----------------------------
  static Future<Map<String, dynamic>> getUserProfile() async {
    if (_token == null) {
      // This might be called when app starts and token is legitimately null.
      // Or if token was cleared due to previous 401/403.
      // Throwing SessionExpiredException here ensures consistent handling if called when unauthenticated.
      throw SessionExpiredException('User belum login. Silakan login kembali.');
    }

    final url = Uri.parse('$baseUrl/api/user/profile');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 401 || response.statusCode == 403) {
      await clearAuthData();
      throw SessionExpiredException(
        'Sesi Anda telah berakhir. Silakan login kembali.',
      );
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ??
              'Gagal mengambil profil user: ${response.reasonPhrase}',
        );
      } catch (e) {
        throw Exception(
          'Gagal mengambil profil user: Status ${response.statusCode}, ${response.reasonPhrase}',
        );
      }
    }
  }
}
