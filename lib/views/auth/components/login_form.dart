import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../widgets/custom_button.dart';

/// A stateful widget that builds the login form UI with
/// email/password fields and a custom login button.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers to capture input from email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // State variables for loading indicator and password visibility toggle
  bool isLoading = false;
  bool isPasswordVisible = false;

  /// Handles login logic with a simulated delay and success toast.
  void handleLogin() {
    setState(() => isLoading = true);

    // Simulate network request delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);

      // Show a toast message upon successful login
      Fluttertoast.showToast(
        msg: "Login Berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigate to home screen after short delay
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
  }

  /// Handles forgot password interaction (not implemented).
  void handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fitur lupa password belum diimplementasi."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email input label and field
        const Text(
          'Alamat Email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: emailController,
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

        // Password input label and field with visibility toggle
        const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
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
                // Toggle password visibility
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
        ),

        // Forgot password link
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

        // Login button with loading indicator
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
