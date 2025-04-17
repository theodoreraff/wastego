import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../routes/app_routes.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final int points;
  final String userId;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.points,
    required this.userId,
  });

  // Greeting Function
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) {
      return 'Selamat Pagi';
    } else if (hour >= 11 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            // Navbar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo WasteGo
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 38,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Waste',
                              style: TextStyle(color: Color(0xFF003539)),
                            ),
                            TextSpan(
                              text: 'Go',
                              style: TextStyle(color: Color(0xFFAFEE00)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Avatar & Notification
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.bell),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.notification);
                        },
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.profile);
                        },
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 32,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: double.infinity,
                  height: 168,
                  child: Stack(
                    children: [
                      // Background SVG
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/images/banner.svg',
                          fit: BoxFit.cover,
                          alignment: Alignment.topLeft,
                        ),
                      ),

                      // Greeting & user info
                      Positioned(
                        left: 16,
                        top: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_getGreeting()}, $userName',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Poin: $points Eco',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'ID: $userId',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
