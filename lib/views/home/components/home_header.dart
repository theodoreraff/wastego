import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Navbar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo WasteGo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Waste'),
                        TextSpan(
                          text: 'Go',
                          style: TextStyle(
                            color: Color(0xFF8BC34A),
                          ), // Warna hijau
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Notifikasi & Avatar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.bell),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png', // Ganti dengan gambar profil
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Banner
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: 360,
              height: 168,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/banner.svg',
                    width: double.infinity,
                    height: 168,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 16,
                    top: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Selamat Pagi, John',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Poin: 500 Eco',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'ID: WGO-001234',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
