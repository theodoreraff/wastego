import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _setLoading(true);

    try {
      // Simulasi login logic
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('Login success: $email');
    } catch (e) {
      debugPrint('Login failed: $e');
    }

    _setLoading(false);
  }

  Future<void> register(String name, String email, String password) async {
    _setLoading(true);

    try {
      // Simulasi register logic
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('Register success: $name, $email');
    } catch (e) {
      debugPrint('Register failed: $e');
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
