import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
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

  // User data
  String userId = '';
  String username = '';
  int balancePoint = 0;
  bool isLoading = false;

  // Ambil data profil dari server
  Future<void> fetchProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService.getUserProfile();
      debugPrint('Profile API response Home: $response');

      // Ambil data dari 'profile'
      final profile = response['profile'] ?? {};

      setState(() {
        userId = profile['uid']?.toString() ?? '';
        username = profile['username'] ?? '';
        balancePoint = profile['balancePoint'] ?? 0;
      });
    } catch (e) {
      debugPrint('Gagal mengambil profil: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile(); // Panggil saat halaman di-load
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            // Combined header + menu
            HomeTopSection(
              userName: username,
              points: balancePoint,
              userId: userId,
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