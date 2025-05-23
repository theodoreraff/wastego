import 'package:flutter/material.dart';
import 'components/home_top_section.dart';
import 'components/home_stats.dart';
import 'components/eco_tips_carousel.dart';
import '../../widgets/bottom_nav.dart';

/// Displays user info, menu shortcuts, stats, and eco tips.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Simulated user data (to be replaced with real data from backend/API)
  // TODO: Replaced Backend/API
  final String _userName = 'WasteHero';
  final int _points = 145000;
  final String _userId = 'WGO-001234';

  /// Handles navigation between tabs.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/help');
        break;
      case 2:
        Navigator.pushNamed(context, '/points');
        break;
      case 3:
        Navigator.pushNamed(context, '/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Combined header + menu
            HomeTopSection(
              userName: _userName,
              points: _points,
              userId: _userId,
            ),

            const SizedBox(height: 5),

            // Waste stats
            const HomeStats(totalSampah: 0),

            // Carousel of eco tips
            const EcoTipsCarousel(),
          ],
        ),
      ),

      // Custom bottom navigation bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}