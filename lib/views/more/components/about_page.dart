import 'package:flutter/material.dart';

class AboutWasteGoPage extends StatelessWidget {
  const AboutWasteGoPage({super.key});

  final Color primaryColor = const Color(0xFF003539);
  final Color textColor = Colors.black87;
  final Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Tentang WasteGo'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        children: [
          Text(
            'Kenalan dengan WasteGo 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Satu aksi kecilmu, dampaknya besar 🌱',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1, height: 1.5, color: Colors.black12),
          const SizedBox(height: 24),

          _buildSection(
            title: '🌍 Apa itu Waste Go?',
            content:
            'Waste Go adalah aplikasi pengelolaan sampah berbasis digital yang membantu kamu mengatur pengangkutan sampah secara terjadwal, bersih, dan efisien.',
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: '🚀 Kenapa Kami Hadir?',
            content:
            'Kami lahir dari keresahan terhadap masalah sampah dan lingkungan di masyarakat. '
                'Dengan pendekatan teknologi, kami ingin membuat pengelolaan sampah jadi lebih mudah dan menyenangkan.',
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: '💡 Visi Kami',
            content:
            'Menjadi platform pengelolaan sampah yang terpercaya, ramah lingkungan, dan mendorong kebiasaan hidup bersih dan bertanggung jawab.',
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: '🤝 Misi Kami',
            content:
            '• Mempermudah proses pengangkutan sampah rumah tangga\n'
                '• Mengedukasi masyarakat tentang pentingnya pengelolaan sampah\n'
                '• Memberikan insentif berupa reward atas partisipasi aktif pengguna',
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Terima kasih telah jadi bagian dari perjalanan Waste Go 💚',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.5,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15.5,
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
