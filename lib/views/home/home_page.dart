import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Added
import 'package:wastego/core/providers/profile_provider.dart'; // Added
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

  // User data for points, other data will come from ProfileProvider
  int balancePoint = 0;
  bool isLoading = true; // Start with loading true

  // Fetch points (and potentially other non-profileProvider data)
  Future<void> fetchHomePageData() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      // Assuming points might still come from a direct API call or another source
      // For this example, let's simulate fetching points.
      // In a real app, this might be part of the initial user data load.
      final response =
          await ApiService.getUserProfile(); // Or a specific points endpoint
      if (!mounted) return;

      final profileData =
          response['profile'] ?? {}; // Adjust if API structure is different
      setState(() {
        balancePoint = profileData['balancePoint'] ?? 0;
      });

      // Also ensure ProfileProvider has data, or trigger its fetch
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      if (profileProvider.username.isEmpty) {
        // Check if profile data is missing
        await profileProvider.fetchProfile();
      }
    } catch (e) {
      debugPrint('Gagal mengambil data HomePage: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data: ${e.toString()}')),
        );
      }
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch data when the page loads
    // Consider if ProfileProvider is already fetching data globally (e.g. in main.dart)
    // If not, you might need to fetch it here or ensure it's fetched before this page loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchHomePageData();
    });
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
      body: Consumer<ProfileProvider>(
        // Consume ProfileProvider
        builder: (context, profileProvider, child) {
          // Use profileProvider.isLoading for parts managed by it,
          // and local isLoading for parts like balancePoint if fetched separately.
          final overallIsLoading =
              isLoading ||
              (profileProvider.isLoading && profileProvider.username.isEmpty);

          return overallIsLoading
              ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF003539)),
              )
              : RefreshIndicator(
                color: const Color(0xFF003539),
                onRefresh: () async {
                  await fetchHomePageData(); // Refreshes points
                  await profileProvider
                      .fetchProfile(); // Refreshes profile data
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Combined header + menu
                      HomeTopSection(
                        points: balancePoint, // Only points is needed now
                      ),
                      const SizedBox(height: 5),

                      // Waste stats
                      const HomeStats(totalSampah: 0),

                      // Carousel of eco tips
                      const EcoTipsCarousel(),
                    ],
                  ),
                ),
              );
        },
      ),
      // Custom bottom navigation bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
