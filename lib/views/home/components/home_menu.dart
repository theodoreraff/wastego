import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Data menu dengan warna spesifik
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": LucideIcons.clock,
        "label": "Jadwal",
        "color": const Color(0xFF1E1E1E),
      },
      {
        "icon": LucideIcons.recycle,
        "label": "Recycle",
        "color": const Color(0xFF2CCC86),
      },
      {
        "icon": LucideIcons.calendar,
        "label": "Events",
        "color": const Color(0xFFAB67F3),
      },
      {
        "icon": LucideIcons.lightbulb,
        "label": "Tips",
        "color": const Color(0xFFCC9B00),
      },
      {
        "icon": LucideIcons.fileText,
        "label": "Blog",
        "color": const Color(0xFF3DBEE5),
      },
      {
        "icon": LucideIcons.heartHandshake,
        "label": "Donasi",
        "color": const Color(0xFFF367E8),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: 360,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F2F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item["icon"], size: 28, color: item["color"]),
                  const SizedBox(height: 6),
                  Text(
                    item["label"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Warna teks tetap hitam
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
