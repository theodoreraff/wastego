import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EcoTip {
  final String title;
  final String description;
  final String imagePath;

  const EcoTip({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class EcoTipsCarousel extends StatelessWidget {
  const EcoTipsCarousel({super.key});

  final List<EcoTip> tips = const [
    EcoTip(
      title: 'Kurangi Penggunaan Plastik',
      description: 'Gunakan tas kain untuk belanja agar mengurangi sampah plastik.',
      imagePath: 'assets/images/plastik.jpg',
    ),
    EcoTip(
      title: 'Daur Ulang Kertas',
      description: 'Manfaatkan kertas bekas untuk keperluan lain, seperti kertas catatan.',
      imagePath: 'assets/images/paper.jpg',
    ),
    EcoTip(
      title: 'Hemat Energi',
      description: 'Matikan lampu dan peralatan listrik ketika tidak digunakan.',
      imagePath: 'assets/images/energy.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenWidth * 0.56;

    return SizedBox(
      height: cardHeight,
      child: CarouselSlider.builder(
        itemCount: tips.length,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: const Duration(seconds: 4),
          viewportFraction: 0.95,
        ),
        itemBuilder: (context, index, realIndex) {
          final tip = tips[index];
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _buildTipCard(tip, screenWidth),
          );
        },
      ),
    );
  }


  Widget _buildTipCard(EcoTip tip, double screenWidth) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.5;
        final titleFontSize = screenWidth * 0.045;
        final descFontSize = screenWidth * 0.035;

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  tip.imagePath,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, _) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),

              // Wrap the text content with SingleChildScrollView to prevent overflow
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.title,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF003D3D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip.description,
                        style: TextStyle(
                          fontSize: descFontSize,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
