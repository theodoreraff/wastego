import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../../../widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool isLoading = false;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> handleSendOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Email tidak boleh kosong.');
      return;
    }
    if (!_isValidEmail(email)) {
      _showMessage('Format email tidak valid.');
      return;
    }

    setState(() => isLoading = true);
    try {
      final response = await ApiService.forgotPassword(email);
      final message = response['message'] ?? 'OTP berhasil dikirim ke email.';

      _showMessage(message, isError: false);

      // Simpan email untuk digunakan di halaman verifikasi OTP
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('reset_password_email', email);

      // Navigasi ke halaman verifikasi OTP,
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamed(
          context,
          '/verify-otp',
          // Tidak perlu mengirim email sebagai argumen, kita akan ambil dari SharedPreferences
          // arguments: {'email': email},
        );
      });
    } catch (e) {
      if (e.toString().contains("not found") || e.toString().contains("404")) {
        _showMessage("Email tidak terdaftar.");
      } else {
        _showMessage("Terjadi kesalahan. Coba lagi.");
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
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
              'Masukkan email akunmu dan kami akan mengirim OTP untuk reset password.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'contoh@email.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Kirim OTP',
              isLoading: isLoading,
              onPressed: isLoading ? null : handleSendOtp,
            ),
          ],
        ),
      ),
    );
  }
}
