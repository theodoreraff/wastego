import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wastego/widgets/custom_button.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poin Anda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon/Ilustrasi terkait poin
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SvgPicture.asset(
                  'assets/images/poin.svg',
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Poin Anda: 1000',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Luar biasa! Anda sudah mengumpulkan banyak poin! 🎉\nAyo, kumpulkan lebih banyak dan dapatkan hadiah menarik!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Action Button untuk Redeem
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Tukar Poin Sekarang',
                      onPressed: () {
                        // TODO: Implementasi untuk menukar poin
                      },
                      backgroundColor: const Color(0xFF003539),
                      textColor: const Color(0xFFAFEE00),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Undang Teman',
                      onPressed: () {
                        // TODO: Implementasi untuk undang teman dan mendapatkan poin bonus
                      },
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF003539),
                      icon: Icons.person_add,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Riwayat Poin
              Row(
                children: [
                  const Text(
                    'Riwayat Poin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  DropdownButton<String>(
                    value: '2024',
                    onChanged: (String? newValue) {
                      // Handle year selection
                    },
                    items: <String>['2024', '2023', '2022', '2021']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Riwayat Poin List
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: const Text(
                    'Daur Ulang Sampah',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Mendapatkan 100 Poin'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF003539),
                  ),
                  onTap: () {
                    // Handle tap for more details
                  },
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: const Text(
                    'Partisipasi Event "Daur Sampah"',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Mendapatkan 500 Poin'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF003539),
                  ),
                  onTap: () {
                    // Handle tap for more details
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Footer - Encouragement for next step
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Ingin lebih banyak poin? Cobalah tantangan baru atau bagikan Wastego dengan teman-temanmu!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
