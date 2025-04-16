import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      {'title': 'Pengaturan Privasi', 'onTap': () {}},
      {'title': 'Pengaturan Notifikasi', 'onTap': () {}},
      {'title': 'Metode Pembayaran', 'onTap': () {}},
      {'title': 'Pengaturan Bahasa', 'onTap': () {}},
      {'title': 'Pengaturan Data', 'onTap': () {}},
      {'title': 'Informasi Hukum', 'onTap': () {}},
      {'title': 'FAQs', 'onTap': () {}},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Lainnya'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...settings.map(
            (item) => SettingTile(
              title: item['title'] as String,
              onTap: item['onTap'] as VoidCallback,
            ),
          ),
          const SizedBox(height: 12),
          const VersionTile(),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class VersionTile extends StatelessWidget {
  const VersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: const ListTile(
        title: Text('Versi Aplikasi'),
        trailing: Text('1.0.1', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
