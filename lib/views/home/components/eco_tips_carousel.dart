import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EcoTipsCarousel extends StatelessWidget {
  const EcoTipsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tips = [
      {
        'title': 'Kurangi Penggunaan Plastik',
        'description':
            'Gunakan tas kain untuk belanja agar mengurangi sampah plastik.',
        'image': 'assets/images/plastik.jpg',
      },
      {
        'title': 'Daur Ulang Kertas',
        'description':
            'Manfaatkan kertas bekas untuk keperluan lain, seperti kertas catatan.',
        'image': 'assets/images/paper.jpg',
      },
      {
        'title': 'Hemat Energi',
        'description':
            'Matikan lampu dan peralatan listrik ketika tidak digunakan.',
        'image': 'assets/images/energy.jpg',
      },
    ];

    return CarouselSlider.builder(
      itemCount: tips.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 4),
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, realIndex) {
        final tip = tips[index];

        return LayoutBuilder(
          builder: (context, constraints) {
            final double imageHeight = constraints.maxHeight * 0.5;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.asset(
                      tip['image']!,
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003D3D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tip['description']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
