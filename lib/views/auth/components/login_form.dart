import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

 final List<Map<String, String>> dummyUsers = [
    {'email': 'wastego@gmail.com', 'password': 'admin123'},
    {'email': 'user1@gmail.com', 'password': 'user123'},
  ];

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;

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

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);

      final user = dummyUsers.firstWhere(
        (user) => user['email'] == email,
        orElse: () => {},
      );

      if (user.isEmpty) {
        _showError('Anda belum memiliki akun.');
      } else if (user['password'] != password) {
        _showError('Email atau password salah.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login berhasil!')),
        );
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    });
    //   setState(() => isLoading = true);
    // Future.delayed(const Duration(seconds: 1), () {
    //   setState(() => isLoading = false);
    //   Navigator.pushReplacementNamed(context, '/home');
    // });
  }

  void handleForgotPassword() {
    _showError('Fitur lupa password belum diimplementasi.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Alamat Email', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'Masukkan Email',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        ),
        const SizedBox(height: 24),

        const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Masukkan Password',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: handleForgotPassword,
            child: const Text(
              'Lupa Password?',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),
        CustomButton(
          text: 'Masuk',
          isLoading: isLoading,
          onPressed: handleLogin,
        ),
      ],
    );
  }
}
