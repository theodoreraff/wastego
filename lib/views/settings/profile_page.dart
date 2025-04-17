import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/profile_option_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Budiono Siregar',
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

            // Navigation Menu
            const ProfileOptionTile(title: 'Pengaturan Akun'),
            const ProfileOptionTile(title: 'Lihat Statistik'),
            const ProfileOptionTile(title: 'Kupon dan Hadiah'),
            const ProfileOptionTile(title: 'Alamat Tersimpan'),
            const ProfileOptionTile(title: 'Umpan Balik dan Saran'),

            // Button Logout
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12,
              ),
              child: ElevatedButton(
                onPressed: () {},
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
