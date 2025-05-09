import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wastego/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

            // Tombol Logout menggunakan CustomButton
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12,
              ),
              child: CustomButton(
                text: 'Keluar',  // Pastikan 'text' tidak kosong
                onPressed: () => _logout(context),
                backgroundColor: const Color(0xFFB8FF00),
                textColor: Colors.black,
                isLoading: false,
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

  // Menampilkan BottomSheet dan Dialog
  void _showSharePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.share, size: 48, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Bagikan WasteHeroes!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ajak temanmu jadi pahlawan lingkungan 🌱',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Bagikan Sekarang',  // Tambahkan teks yang sesuai
                icon: Icons.send,
                backgroundColor: const Color(0xFFB8FF00),
                textColor: Colors.black,
                isLoading: false,
                onPressed: () async {
                  Navigator.pop(context); // tutup popup
                  final box = context.findRenderObject() as RenderBox?;
                  try {
                    await SharePlus.instance.share(
                      ShareParams(
                        text:
                        'Hai! Cek aplikasi keren WasteHeroes ini. Yuk jadi pahlawan lingkungan! 🌱🌍\n\nDownload sekarang dan mulai ubah dunia: [link aplikasi]',
                        sharePositionOrigin: box!.localToGlobal(Offset.zero) &
                        box.size,
                      ),
                    );
                  } catch (e) {
                    // Menampilkan Dialog ketika share gagal dengan animasi dan desain menarik
                    _showFailureDialog(context);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function untuk menampilkan dialog error dengan desain animasi
  void _showFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Oh No!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gagal membagikan aplikasi.\nCoba lagi nanti.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Tutup',  // Tambahkan teks yang sesuai
                  textColor: Colors.white,
                  isLoading: false,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                  tooltip: 'Kembali',
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      tooltip: 'Bagikan aplikasi',
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () => _showSharePopup(context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
