import 'package:flutter/material.dart';

class AuthTabSwitcher extends StatelessWidget {
  final bool isLogin;

  const AuthTabSwitcher({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTab(
            label: 'Masuk',
            selected: isLogin,
            onTap: () {
              if (!isLogin) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
          _buildTab(
            label: 'Daftar',
            selected: !isLogin,
            onTap: () {
              if (isLogin) {
                Navigator.pushReplacementNamed(context, '/register');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
