import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/services/api_service.dart';
import '../../../views/auth/forgot_password_page.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/providers/profile_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isLoading = false;
  bool isPasswordVisible = false;
  String? errorMessage;

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

  void _clearError() {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
  }

  // START CODE TES
  String formatUid(String rawUid) {
    final int numericUid = rawUid.hashCode.abs() % 1000000;
    final formattedNumber = numericUid.toString().padLeft(6, '0');
    return 'WGO-$formattedNumber';
  }
  // END CODE TES

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Validasi input tetap sama
    if (email.isEmpty) {
      _showMessage('Email tidak boleh kosong.');
      return;
    }
    if (!_isValidEmail(email)) {
      _showMessage('Format email tidak valid.');
      return;
    }
    if (password.isEmpty) {
      _showMessage('Password tidak boleh kosong.');
      return;
    }
    if (password.length < 6) {
      _showMessage('Password minimal 6 karakter.');
      return;
    }
    if (password.contains(' ')) {
      _showMessage('Password tidak boleh mengandung spasi.');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await ApiService.login(email, password);

      final token = response['token'];
      if (token != null) {
        await ApiService.saveToken(token);

        // final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
        //         await profileProvider.fetchProfile();
        
        // START CODE TES
        final user = response['user'];
        final username = user?['username'] ?? 'User';
        final poin = user?['poin'] ?? 0;
        final rawUid = user?['uid'] ?? 'unknown';
        final uidFormatted = formatUid(rawUid);

        _showMessage(
          'Login berhasil!\nUsername: $username\nPoin: $poin\nUID: $uidFormatted',
          isError: false,
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
        // END CODE TES
      } else {
        setState(() {
          errorMessage = 'Login gagal: Token tidak ditemukan.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Login gagal: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_clearError);
    passwordController.addListener(_clearError);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Alamat Email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: emailController,
          focusNode: emailFocus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSubmitted:
              (_) => FocusScope.of(context).requestFocus(passwordFocus),
          decoration: InputDecoration(
            hintText: 'Masukkan Email',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 24),

        const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          focusNode: passwordFocus,
          obscureText: !isPasswordVisible,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => isLoading ? null : handleLogin(),
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
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 8),

        if (errorMessage != null) ...[
          Text(
            errorMessage!,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],

        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap:
                isLoading
                    ? null
                    : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage(),
                        ),
                      );
                    },
            child: Text(
              'Lupa Password?',
              style: TextStyle(
                color: isLoading ? Colors.grey : Colors.black,
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
          onPressed: isLoading ? null : handleLogin,
        ),
      ],
    );
  }
}
