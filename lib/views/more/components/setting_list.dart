import 'package:flutter/material.dart';
import '../coming_soon_page.dart';
import './setting_tile.dart';

class SettingList extends StatelessWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      {
        'title': 'Pengaturan Privasi',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'Pengaturan Notifikasi',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'Metode Pembayaran',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'Pengaturan Bahasa',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'Pengaturan Data',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'Informasi Hukum',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
      {
        'title': 'FAQs',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
          );
        },
      },
    ];

    return Column(
      children: [
        ...settings.map(
          (item) => SettingTile(
            title: item['title'] as String,
            onTap: item['onTap'] as VoidCallback,
          ),
        ),
      ],
    );
  }
}
