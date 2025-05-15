import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Daur Ulang'),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Informasi Harga Perkiraan per Kg',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D3D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Berikut adalah estimasi harga daur ulang untuk beberapa kategori yang tersedia. '
                  'Harga dapat bervariasi tergantung lokasi, kondisi barang, dan mitra bank sampah. '
                  'Gunakan informasi ini sebagai referensi, bukan acuan tetap.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              '📦 Kardus:\n- Rp 2.000 - Rp 3.000 / kg',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 8),
            const Text(
              '🧃 Botol Plastik:\n- PET (transparan): Rp 9.000 - Rp 13.500 / kg\n- Botol campuran: Rp 5.000 - Rp 7.000 / kg',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 8),
            const Text(
              '📄 Kertas:\n- Kertas koran: Rp 2.500 - Rp 3.500 / kg\n- Kertas campuran: Rp 1.500 - Rp 2.500 / kg',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 8),
            const Text(
              '🛠️ Besi:\n- Besi super: Rp 4.200 / kg\n- Besi biasa: Rp 3.000 / kg',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 14),
            const Text(
              '⚠️ *Catatan: Harga dapat berubah sewaktu-waktu dan hanya sebagai acuan awal. '
                  'Silakan cek ke bank sampah terdekat untuk info terkini.*',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
            ),

            const SizedBox(height: 14),
            const Text(
              'Ayo Bergabung dalam Gerakan Daur Ulang!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D3D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Setiap langkah kecil yang Anda ambil untuk mendaur ulang memiliki dampak besar bagi lingkungan. '
                  'Mulai dari rumah, kita bisa ciptakan perubahan nyata untuk masa depan yang lebih baik.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),

            Center(
              child: CustomButton(
                text: 'Kembali',
                backgroundColor: const Color(0xFF003D3D),
                textColor: const Color(0xFFB8FF00),
                icon: Icons.arrow_back,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
