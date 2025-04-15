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

  static const Color mainColor = Color(0xFF003539);

  Color _withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey.shade600,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              _buildNavItem(LucideIcons.home, "Beranda", currentIndex, 0),
              _buildNavItem(LucideIcons.headphones, "Bantuan", currentIndex, 1),
              _buildNavItem(LucideIcons.receipt, "Billing", currentIndex, 2),
              _buildNavItem(
                LucideIcons.moreHorizontal,
                "More",
                currentIndex,
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int currentIndex,
    int index,
  ) {
    final isSelected = currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSelected ? 36 : 32,
            height: isSelected ? 36 : 32,
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? _withOpacity(mainColor, 0.15)
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: isSelected ? 24 : 22,
                color: isSelected ? mainColor : Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? mainColor : Colors.grey.shade600,
            ),
            child: Text(label),
          ),
        ],
      ),
      label: '',
    );
  }
}
