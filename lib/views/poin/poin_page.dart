import 'package:flutter/material.dart';
import '../../widgets/comming_soon.dart';
import '../../widgets/custom_button.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

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
                title: 'Poin WasteGo Akan Segera Hadir!',
                description:
                    'Hai WasteHeroes! 🎉 Fitur poin sedang kami persiapkan agar kamu bisa mendapatkan lebih banyak penghargaan atas setiap aksi ramah lingkungan yang kamu lakukan. Terus dukung kami untuk membuat WasteGo menjadi lebih berarti!',
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
