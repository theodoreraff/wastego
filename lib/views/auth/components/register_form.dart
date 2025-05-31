import 'package:flutter/material.dart';
import '../../../../widgets/custom_button.dart';
import '../../../core/services/api_service.dart'; // Will be used by AuthProvider
import 'package:provider/provider.dart'; // Added Provider
import 'package:wastego/core/providers/auth_provider.dart'; // Added AuthProvider
import 'package:wastego/core/providers/profile_provider.dart'; // Added ProfileProvider

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _agreeToTerms = false;
  bool isLoading = false;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty) {
      _showError('Username tidak boleh kosong.');
      return;
    }

    if (email.isEmpty) {
      _showError('Email tidak boleh kosong.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showError('Format email tidak valid.');
      return;
    }

    if (password.isEmpty) {
      _showError('Password tidak boleh kosong.');
      return;
    }

    if (password.length < 6) {
      _showError('Password minimal 6 karakter.');
      return;
    }

    if (password.contains(' ')) {
      _showError('Password tidak boleh mengandung spasi.');
      return;
    }

    if (confirmPassword.isEmpty) {
      _showError('Konfirmasi password tidak boleh kosong.');
      return;
    }

    if (password != confirmPassword) {
      _showError('Password dan konfirmasi tidak sama.');
      return;
    }

    if (!_agreeToTerms) {
      _showError('Anda harus menyetujui syarat dan ketentuan.');
      return;
    }

    setState(() => isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );

      await authProvider.register(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        profileProvider: profileProvider,
      );

      if (mounted) {
        _showSuccess('Registrasi berhasil! Mengarahkan ke Beranda...');
        // Navigate to home page after successful registration
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
        });
      }
    } catch (e) {
      if (mounted)
        _showError(
          'Registrasi gagal: ${e.toString().replaceFirst("Exception: ", "")}',
        );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              hintText: 'Masukkan Username',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Alamat Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Masukkan Email',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Kata Sandi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              hintText: 'Masukkan Password',
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed:
                    () => setState(() => _passwordVisible = !_passwordVisible),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Konfirmasi Kata Sandi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _confirmPasswordController,
            obscureText: !_confirmPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Masukkan Ulang Password',
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed:
                    () => setState(
                      () => _confirmPasswordVisible = !_confirmPasswordVisible,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                onChanged:
                    (value) => setState(() => _agreeToTerms = value ?? false),
              ),
              const Expanded(
                child: Text('Saya menyetujui syarat dan ketentuan'),
              ),
            ],
          ),
          const SizedBox(height: 5),

          CustomButton(
            text: 'Daftar',
            isLoading: isLoading,
            onPressed: _agreeToTerms && !isLoading ? _handleRegister : null,
          ),
        ],
      ),
    );
  }
}
