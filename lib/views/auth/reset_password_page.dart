import 'package:flutter/material.dart';
import 'package:wastego/core/services/api_service.dart';
import 'package:wastego/widgets/custom_button.dart';
import 'package:wastego/routes/app_routes.dart'; // Import AppRoutes

/// A page allowing users to reset their password after successful OTP verification.
class ResetPasswordPage extends StatefulWidget {
  // `token` and `email` are typically passed as arguments for password reset.
  final String? token;
  final String? email;

  const ResetPasswordPage({super.key, this.token, this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _emailFromArgs; // Store email received from arguments.

  @override
  void initState() {
    super.initState();
    // Load email from route arguments when the widget initializes.
    _loadEmailFromArguments();
  }

  /// Extracts the email from route arguments. If not found, it pops the page.
  void _loadEmailFromArguments() {
    // Access arguments passed during navigation.
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('email')) {
      setState(() {
        _emailFromArgs = arguments['email'] as String?;
        debugPrint('Email received in ResetPasswordPage: $_emailFromArgs');
      });
    } else {
      debugPrint('Email not received in ResetPasswordPage');
      // If email is missing, go back to the previous page.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  /// Validates the new password (e.g., minimum length).
  bool _isValidPassword(String password) {
    return password.length >= 6; // Password must be at least 6 characters long.
  }

  /// Displays a SnackBar message to the user.
  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Handles the password reset logic, including validation and API call.
  Future<void> _handleResetPassword() async {
    // Use the email loaded from arguments.
    if (_emailFromArgs == null) {
      _showMessage('Email not available. Please try again.', isError: true);
      return;
    }

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validate input fields.
    if (password.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Password and Confirm Password cannot be empty.');
      return;
    }

    if (!_isValidPassword(password)) {
      _showMessage('Password must be at least 6 characters.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Password and Confirm Password do not match.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Call the API service to reset the password.
      final response = await ApiService.resetPassword(email: _emailFromArgs!, newPassword: password);
      final message = response['message'] ?? 'Password reset successfully.';
      _showMessage(message, isError: false);

      // Navigate to the login page after a successful reset.
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    } catch (e) {
      _showMessage('An error occurred while resetting password. Please try again.');
      debugPrint('Error resetting password: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your new password.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text('New Password', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true, // Hide password text.
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: 'New password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Confirm New Password', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true, // Hide password text.
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: 'Confirm new password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Reset Password',
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _handleResetPassword, // Disable button while loading.
            ),
          ],
        ),
      ),
    );
  }
}