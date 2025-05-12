import 'package:flutter/material.dart';

/// A widget that displays a tab switcher for authentication screens,
/// allowing users to toggle between "Login" and "Register".
class AuthTabSwitcher extends StatelessWidget {
  /// Determines whether the "Login" tab is currently selected.
  final bool isLogin;

  /// Creates an [AuthTabSwitcher] with the current tab state.
  const AuthTabSwitcher({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container styling with light grey background and rounded corners.
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // "Login" tab
          _buildTab(
            label: 'Masuk',
            selected: isLogin,
            onTap: () {
              // Navigate to login screen if not already on it
              if (!isLogin) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
          // "Register" tab
          _buildTab(
            label: 'Daftar',
            selected: !isLogin,
            onTap: () {
              // Navigate to register screen if not already on it
              if (isLogin) {
                Navigator.pushReplacementNamed(context, '/register');
              }
            },
          ),
        ],
      ),
    );
  }

  /// Builds an individual tab with the given [label], [selected] state,
  /// and a [onTap] callback for user interaction.
  Widget _buildTab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // Trigger the callback when the tab is tapped
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            // Highlight the selected tab with a white background
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
