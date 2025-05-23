import 'package:flutter/material.dart';
import '../coming_soon_page.dart';
import './setting_tile.dart';
import './notification_settings_page.dart';
import './faq_page.dart';
import './about_page.dart';

class SettingList extends StatelessWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      // {
      //   'title': 'Pengaturan Notifikasi',
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const NotificationSettingsPage()),
      //     );
      //   },
      // },
      // {
      //   'title': 'Metode Pembayaran',
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
      //     );
      //   },
      // },
      // {
      //   'title': 'Pengaturan Bahasa',
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const FAQPage()),
      //     );
      //   },
      // },
      {
        'title': 'Frequently Asked Question',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FAQPage()),
          );
        },
      },
      // Optional: Aktifkan jika diperlukan
      // {
      //   'title': 'FAQs',
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const ComingSoonScreen()),
      //     );
      //   },
      // },
      {
        'title': 'Tentang Aplikasi',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutWasteGoPage()),
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
