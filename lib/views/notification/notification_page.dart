import 'package:flutter/material.dart';
import '../../widgets/comming_soon.dart';
import '../../widgets/custom_button.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: ComingSoonWidget(
                title: 'Notifikasi WasteGo Sedang Dalam Perjalanan! 🌱',
                description:
                    'Hai WasteHeroes! 🚀 Fitur notifikasi sedang kami kembangkan agar kamu selalu mendapatkan update langsung tentang aksi pengelolaan sampahmu. Bersama-sama, kita akan membuat WasteGo lebih cepat dan lebih baik! Terus dukung kami, perubahan besar dimulai dari langkah kecil!',
              ),
            ),
            CustomButton(
              text: 'Kembali',
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
