import 'package:flutter/material.dart';
import '../../widgets/comming_soon.dart';
import '../../widgets/custom_button.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
                title: 'Pusat Bantuan WasteGo Segera Hadir! 💡',
                description:
                    'WasteHeroes! 🚀 kami sedang merancang pusat bantuan yang lebih lengkap dan mudah dipahami. Di sini, kamu bisa mendapatkan semua informasi yang kamu butuhkan untuk memaksimalkan pengalaman menggunakan WasteGo. Nantikan update dan jadilah bagian dari perubahan besar!',
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
