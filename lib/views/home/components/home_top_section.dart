import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../routes/app_routes.dart';

/// A widget that displays the top section of the Home screen,
/// including logo, user greeting, points, ID, and navigation menu.
class HomeTopSection extends StatefulWidget {
  final String userName;
  final int points;
  final String userId;

  const HomeTopSection({
    super.key,
    required this.userName,
    required this.points,
    required this.userId,
  });

  @override
  HomeTopSectionState createState() => HomeTopSectionState();
}

class HomeTopSectionState extends State<HomeTopSection> with SingleTickerProviderStateMixin {
  // Animation controllers for fade-in and scale transitions
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Start the animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) return 'Selamat Pagi';
    if (hour >= 11 && hour < 15) return 'Selamat Siang';
    if (hour >= 15 && hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context) {
    // Responsive layout based on screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic font and icon sizes
    final double greetingFontSize = screenWidth * 0.05;
    final double userInfoFontSize = screenWidth * 0.032;
    final double labelFontSize = screenWidth * 0.037;
    final double iconSize = screenWidth * 0.07;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            /// Top bar with logo and action icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo and app name
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.09,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, _) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 12),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(text: 'Waste', style: TextStyle(color: Color(0xFF003539))),
                          TextSpan(text: 'Go', style: TextStyle(color: Color(0xFFAFEE00))),
                        ],
                      ),
                    ),
                  ],
                ),

                // Notification and profile
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.bell),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.notification),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.png',
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, _) => const Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Greeting card showing user info and points
            FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.18,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SvgPicture.asset(
                            'assets/images/banner.svg',
                            fit: BoxFit.cover,
                            alignment: Alignment.topLeft,
                            placeholderBuilder: (_) => Container(color: Colors.grey.shade300),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_getGreeting()}, ${widget.userName} ',
                                style: TextStyle(
                                  fontSize: greetingFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Points: ${widget.points} Eco',
                                style: TextStyle(fontSize: userInfoFontSize, color: Colors.white),
                              ),
                              Text(
                                'ID: ${widget.userId}',
                                style: TextStyle(fontSize: userInfoFontSize, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Grid menu of quick navigation options
            SizedBox(
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
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, item.route),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F2F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: iconSize, color: item.color),
                          const SizedBox(height: 6),
                          Text(
                            item.label,
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
          ],
        ),
      ),
    );
  }

  /// List of grid menu items.
  List<_MenuItem> get _menuItems => const [
    _MenuItem(icon: LucideIcons.clock, label: "Schedule", color: Color(0xFF1E1E1E), route: AppRoutes.schedule),
    _MenuItem(icon: LucideIcons.recycle, label: "Recycle", color: Color(0xFF2CCC86), route: AppRoutes.recycle),
    _MenuItem(icon: LucideIcons.calendar, label: "Events", color: Color(0xFFAB67F3), route: AppRoutes.events),
    _MenuItem(icon: LucideIcons.lightbulb, label: "Tips", color: Color(0xFFCC9B00), route: AppRoutes.tips),
    _MenuItem(icon: LucideIcons.fileText, label: "Blog", color: Color(0xFF3DBEE5), route: AppRoutes.blog),
    _MenuItem(icon: LucideIcons.heartHandshake, label: "Donate", color: Color(0xFFF367E8), route: AppRoutes.donate),
  ];
}

/// Public class that defines a menu item.
class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final String route;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });
}
