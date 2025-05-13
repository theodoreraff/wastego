import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComingSoonWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? illustrationAsset;

  const ComingSoonWidget({
    super.key,
    this.title = 'Fitur Segera Hadir!',
    this.description =
        'Kami sedang mempersiapkan fitur keren untukmu. Tunggu sebentar lagi ya!',
    this.illustrationAsset = 'assets/images/construction.svg',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (illustrationAsset != null)
              SvgPicture.asset(
                illustrationAsset!,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 200,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
