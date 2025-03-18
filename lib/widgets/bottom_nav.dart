import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: "Beranda"),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.headphones),
          label: "Bantuan",
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.receipt),
          label: "Billing",
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.moreHorizontal),
          label: "More",
        ),
      ],
    );
  }
}
