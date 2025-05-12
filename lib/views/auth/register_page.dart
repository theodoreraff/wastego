import 'package:flutter/material.dart';
import 'components/auth_tab_switcher.dart';
import 'components/register_form.dart';

/// A stateless widget representing the user registration screen.
/// It includes a logo, a tab switcher for navigating between login and register,
/// and the registration form itself.
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Apply consistent padding around the body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 60),

            // Logo image centered at the top
            Center(
              child: Image.asset(
                'assets/images/logotext.png',
                height: 100,
              ),
            ),

            const SizedBox(height: 24),

            // Auth tab switcher set to register mode
            const AuthTabSwitcher(isLogin: false),

            const SizedBox(height: 24),

            // The registration form input fields and submit button
            const RegisterForm(),
          ],
        ),
      ),
    );
  }
}
