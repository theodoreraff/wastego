import 'package:flutter/material.dart';
import 'components/auth_tab_switcher.dart';
import 'components/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.asset('assets/images/logotext.png', height: 100),
            ),
            const SizedBox(height: 24),
            const AuthTabSwitcher(isLogin: false),
            const SizedBox(height: 24),
            const RegisterForm(),
          ],
        ),
      ),
    );
  }
}
