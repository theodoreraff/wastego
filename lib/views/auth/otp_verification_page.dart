import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/api_service.dart';
import '../../../widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('reset_password_email');
    print('Email dari SharedPreferences di OTP Page: $_email');
    if (_email == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email tidak ditemukan. Silakan coba lagi.'),
          duration: Duration(seconds: 5),
        ),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    // Pastikan email tidak null sebelum melanjutkan
    if (_email == null) {
      setState(() {
        _isLoading = false;
        _errorText = 'Email tidak tersedia.';
      });
      return; // Stop eksekusi jika email null
    }
    print('Email untuk verifikasi: $_email');
    print('OTP yang dimasukkan: ${_otpController.text}');

    try {
      final result = await ApiService.verifyOtp(
        email: _email!, // Gunakan email dari variabel _email
        otp: _otpController.text.trim(),
      );
      print('Hasil dari API Verifikasi OTP: $result'); // Debug: Print the API response
      if (result['success'] == true) {
        print('OTP is valid, navigating to reset password');
        if (!mounted) return;

        // Tampilkan Snackbar sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode OTP Valid, silahkan reset password anda')),
        );

        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          '/reset-password', // Pastikan rute ini sudah terdefinisi
          arguments: {'email': _email}, // Gunakan email yang sudah diambil
        );
      } else {
        print('OTP is invalid');
        setState(() {
          _errorText = result['message'] ?? 'OTP tidak valid.';
        });
      }
    } catch (e) {
      print('Error saat verifikasi OTP: ${e.toString()}');
      setState(() {
        _errorText = 'Terjadi kesalahan: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildOtpField() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: 6,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, letterSpacing: 10),
      decoration: InputDecoration(
        hintText: '------',
        counterText: '',
        errorText: _errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi OTP')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Masukkan 6-digit kode OTP yang dikirim ke email kamu',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildOtpField(),
            const SizedBox(height: 32),
            CustomButton(
              text: _isLoading ? 'Memverifikasi...' : 'Verifikasi',
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _verifyOtp,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                // TODO: Tambahkan logika untuk mengirim ulang OTP
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengirim ulang OTP...'),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Contoh pemanggilan API (ganti dengan implementasi sebenarnya)
                // ApiService.resendOtp(email: _email!).then((response) { ... });
              },
              child: const Text('Kirim ulang kode OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

