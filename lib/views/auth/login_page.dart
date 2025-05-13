import 'package:flutter/material.dart';
import 'components/login_form.dart';
import 'components/auth_tab_switcher.dart';

/// A stateless widget representing the login screen of the app.
/// Includes a logo, a tab switcher for login/register, and the login form.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main layout padding
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 60),

            // App logo centered on the screen
            Center(
              child: Image.asset(
                'assets/images/logotext.png',
                height: 100,
              ),
            ),

            const SizedBox(height: 24),

            // Tab switcher to toggle between Login and Register screens
            AuthTabSwitcher(isLogin: true),

            const SizedBox(height: 24),

            // Login form component
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
