import 'dart:convert';
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
    if (!mounted) return;
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
      if (mounted) {
        setState(() {
          errorMessage = null;
        });
      }
    }
  }

  String _parseGenericError(String errorStringFull) {
    String errorStringLc = errorStringFull.toLowerCase();
    String displayError;

    if (errorStringLc.contains('invalid credentials') ||
        errorStringLc.contains('user not found') ||
        errorStringLc.contains('unauthorized') ||
        errorStringLc.contains('wrong password') ||
        errorStringLc.contains('password yang anda masukkan salah')) {
      displayError = 'Login gagal: Email atau password salah.';
    } else if (errorStringLc.contains('network') ||
        errorStringLc.contains('socketexception') ||
        errorStringLc.contains('timeout') ||
        errorStringLc.contains('host lookup') ||
        errorStringLc.contains('failed host lookup')) {
      displayError =
          'Login gagal: Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
    } else {
      displayError =
          'Login gagal: ${errorStringFull.replaceFirst("Exception: ", "")}';
    }
    return displayError;
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

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

    if (mounted) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
    }

    try {
      final response = await ApiService.login(email, password);
      final dynamic tokenData = response['token'];

      if (tokenData != null && tokenData is String && tokenData.isNotEmpty) {
        await ApiService.saveToken(tokenData);
        if (mounted) {
          final profileProvider = Provider.of<ProfileProvider>(
            context,
            listen: false,
          );
          await profileProvider.fetchProfile();
          _showMessage('Login berhasil!', isError: false);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage =
                response['message'] as String? ??
                'Login gagal: Token tidak ditemukan atau tidak valid.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        String displayError;
        String errorStringFull = e.toString();

        try {
          int jsonStartIndex = errorStringFull.indexOf('{');
          int jsonEndIndex = errorStringFull.lastIndexOf('}');

          if (jsonStartIndex != -1 &&
              jsonEndIndex != -1 &&
              jsonStartIndex < jsonEndIndex) {
            String jsonSubstring = errorStringFull.substring(
              jsonStartIndex,
              jsonEndIndex + 1,
            );
            var decodedJson = jsonDecode(jsonSubstring);

            if (decodedJson is Map) {
              if (decodedJson.containsKey('message') &&
                  decodedJson['message'] is String) {
                displayError = decodedJson['message'] as String;
              } else if (decodedJson.containsKey('error') &&
                  decodedJson['error'] is String) {
                displayError = decodedJson['error'] as String;
              } else {
                displayError = _parseGenericError(errorStringFull);
              }
            } else {
              displayError = _parseGenericError(errorStringFull);
            }
          } else {
            displayError = _parseGenericError(errorStringFull);
          }
        } catch (jsonError) {
          displayError = _parseGenericError(errorStringFull);
        }

        setState(() {
          errorMessage = displayError;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
    emailController.removeListener(_clearError);
    passwordController.removeListener(_clearError);
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
          onSubmitted: (_) {
            if (!isLoading) FocusScope.of(context).requestFocus(passwordFocus);
          },
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
                if (mounted) {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 8),

        if (errorMessage != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
          ),
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
