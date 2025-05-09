import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(
                0xFF2A9D8F,
              ),
              Color(0xFF264653),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons
                    .recycling, // Ikon yang lebih relevan dengan waste management
                size: 120,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              const Text(
                'Fitur ini sedang dalam tahap pengembangan.\nHarap tunggu pembaruan kami!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Tunggu Pembaruan',
                backgroundColor: const Color(
                  0xFF1D3557,
                ), // Biru tua yang elegan
                textColor: Colors.white,
                icon: Icons.update,
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
