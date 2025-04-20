import 'package:flutter/material.dart';
import 'components/home_header.dart';
import 'components/home_menu.dart';
import 'components/home_stats.dart';
import 'components/eco_tips_carousel.dart';
import '../../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Simulasi data user
  final String _userName = 'User';
  final int _points = 500;
  final String _userId = 'WGO-001234';

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
            HomeHeader(userName: _userName, points: _points, userId: _userId),
            const HomeMenu(),
            const SizedBox(height: 5),
            const HomeStats(totalSampah: 155),
            EcoTipsCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
