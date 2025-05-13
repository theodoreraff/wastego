import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Pastikan ini sudah di-import

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Memuat file SVG
        SvgPicture.asset(
          image,
          width: 200,  // Menyesuaikan ukuran gambar
          height: 200, // Menyesuaikan ukuran gambar
          placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),  // Menambahkan indikator loading saat file SVG sedang dimuat
        ),
        const SizedBox(height: 20),  // Jarak antar elemen
        Text(
          title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
