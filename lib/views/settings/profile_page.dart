import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/profile_option_tile.dart';
import '../more/coming_soon_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToComingSoon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Banner
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                const _ProfileBanner(),
                Positioned(
                  bottom: -30,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'WasteHeroes User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Surabaya, Jawa Timur',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              'ID No: BN3123510308',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Menu Navigasi
            ProfileOptionTile(
              title: 'Pengaturan Akun',
              onTap: () => _navigateToComingSoon(context),
            ),
            ProfileOptionTile(
              title: 'Lihat Statistik',
              onTap: () => _navigateToComingSoon(context),
            ),
            ProfileOptionTile(
              title: 'Kupon dan Hadiah',
              onTap: () => _navigateToComingSoon(context),
            ),
            ProfileOptionTile(
              title: 'Alamat Tersimpan',
              onTap: () => _navigateToComingSoon(context),
            ),
            ProfileOptionTile(
              title: 'Umpan Balik dan Saran',
              onTap: () => _navigateToComingSoon(context),
            ),

            // Tombol Logout
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12,
              ),
              child: ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lime[400],
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileBanner extends StatelessWidget {
  const _ProfileBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: double.infinity,
          height: 168,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/banner.svg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
