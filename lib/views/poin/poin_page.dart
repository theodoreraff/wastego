import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wastego/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';

/// A page displaying the user's current points balance and options to earn or redeem points.
/// Currently, it shows a message for zero points and encourages recycling.
class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final int totalPoints = 0; // Placeholder for user's total points.

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            Text(
              'Poin Kamu',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                  child: SvgPicture.asset(
                    'assets/images/poin.svg',
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Kamu belum punya poin nih!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  '🌱 Yuk, mulai daur ulang dan kumpulkan poin pertamamu. Setiap aksi kecilmu buat bumi makin bersih, lho!',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Tukar Poin',
                        onPressed: () {
                          // Show a snackbar if the user has no points to redeem.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Wah, kamu belum punya poin untuk ditukar nih!',
                              ),
                            ),
                          );
                        },
                        backgroundColor: const Color(0xFF003539),
                        textColor: const Color(0xFFAFEE00),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'Ajak Teman',
                        onPressed: () {
                          // Share an invitation message to friends.
                          Share.share(
                            'Ayo daur ulang bareng Wastego! Dapatkan poin bonus dengan mengajak teman kamu. Yuk, cek aplikasinya di: https://wastego.app.link/invite',
                            subject: 'Undangan Wastego',
                          );
                        },
                        backgroundColor: const Color.fromARGB(
                          255,
                          217,
                          216,
                          216,
                        ),
                        textColor: const Color(0xFF003539),
                        icon: Icons.person_add,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '♻️ Bagikan semangat Wastego! Ajak teman dan keluarga buat jadi pahlawan daur ulang juga!',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
