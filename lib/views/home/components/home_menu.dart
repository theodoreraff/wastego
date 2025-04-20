import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastego/routes/app_routes.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
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

    // Get screen width to adjust font size dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate font sizes based on screen width
    double labelFontSize = screenWidth * 0.04;
    double iconSize = screenWidth * 0.07;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 8,
      ),
      child: SizedBox(
        width: screenWidth * 0.9,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 104 / 75,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];

            return GestureDetector(
              onTap: () {
                if (item["label"] == "Jadwal") {
                  Navigator.pushNamed(context, AppRoutes.schedule);
                } else if (item["label"] == "Recycle") {
                  Navigator.pushNamed(context, AppRoutes.recycle);
                } else if (item["label"] == "Events") {
                  Navigator.pushNamed(context, AppRoutes.events);
                } else if (item["label"] == "Tips") {
                  Navigator.pushNamed(context, AppRoutes.tips);
                } else if (item["label"] == "Blog") {
                  Navigator.pushNamed(context, AppRoutes.blog);
                } else if (item["label"] == "Donasi") {
                  Navigator.pushNamed(context, AppRoutes.donate);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item["icon"], size: iconSize, color: item["color"]),
                    const SizedBox(height: 6),
                    Text(
                      item["label"],
                      style: TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
