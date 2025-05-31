import 'package:flutter/material.dart';
import 'package:wastego/core/services/api_service.dart';
import 'package:wastego/core/providers/profile_provider.dart'; // To clear profile data on logout

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _token;
  String? _userId; // Internal DB ID
  String? _wgoId; // User-facing WGO-ID
  String? _username;
  String? _avatarUrl;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get userId => _userId; // Internal DB ID
  String? get wgoId => _wgoId; // User-facing WGO-ID
  String? get username => _username;
  String? get avatarUrl => _avatarUrl;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    // ApiService.init() should be called once at app startup (e.g., in main.dart)
    // await ApiService.init(); // Not needed here if called in main

    _token = ApiService.token;
    if (_token != null) {
      final userData = ApiService.loadUserData();
      _userId = userData['userId'];
      _wgoId = userData['wgoId']; // Load wgoId
      _username = userData['username'];
      _avatarUrl = userData['avatarUrl'];
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
      // Ensure all user-specific fields are cleared if not logged in
      _userId = null;
      _wgoId = null;
      _username = null;
      _avatarUrl = null;
    }
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    ProfileProvider profileProvider,
  ) async {
    _setLoading(true);
    try {
      final response = await ApiService.login(email, password);
      // ApiService.login now handles saving token and user data to SharedPreferences
      await _loadCurrentUser(); // Reload data from ApiService (which loads from SharedPreferences)
      await profileProvider
          .fetchProfile(); // Fetch full profile to ensure freshness

      // Optionally, directly use response if needed immediately, though _loadCurrentUser is more robust
      // final userData = response['user'];
      // if (userData != null) {
      //   _userId = userData['id']?.toString();
      //   _username = userData['username'];
      //   _avatarUrl = userData['avatarUrl'];
      // }
      // _token = ApiService.token;
      // _isLoggedIn = true;

      debugPrint(
        'Login success: $email. UserID: $_userId, Username: $_username, WGO ID: $_wgoId',
      );
    } catch (e) {
      debugPrint('Login failed: $e');
      _isLoggedIn = false;
      rethrow; // Rethrow to allow UI to catch and display error
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required ProfileProvider profileProvider,
  }) async {
    _setLoading(true);
    try {
      await ApiService.registerUser(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      // ApiService.registerUser now handles saving user data (no token from registration)
      await _loadCurrentUser(); // Reload user data from ApiService (token will be null)

      // After registration, the user is NOT logged in as no token is provided.
      // The user needs to proceed to login.
      // Therefore, do not fetch profile here as it requires a token.
      _isLoggedIn = false;

      debugPrint(
        'Register success (user data saved, proceed to login): $username, $email. UserID: $_userId, WGO ID: $_wgoId',
      );
    } catch (e) {
      debugPrint('Register failed: $e');
      _isLoggedIn = false;
      rethrow; // Rethrow to allow UI to catch and display error
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout(ProfileProvider profileProvider) async {
    _setLoading(true);
    try {
      await ApiService.clearAuthData();
      profileProvider.clearProfileData(); // Clear profile provider data
      _token = null;
      _userId = null;
      _wgoId = null; // Clear wgoId
      _username = null;
      _avatarUrl = null;
      _isLoggedIn = false;
      debugPrint('Logout success');
    } catch (e) {
      debugPrint('Logout failed: $e');
      // Optionally handle logout error
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
