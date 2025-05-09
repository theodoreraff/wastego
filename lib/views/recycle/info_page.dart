import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daur Ulang'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Kenapa Daur Ulang Itu Penting?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D3D),
              ),
            ),
            const SizedBox(height: 10),

            // Deskripsi
            const Text(
              'Daur ulang adalah salah satu cara untuk mengurangi sampah dan menghemat sumber daya alam. '
              'Dengan mendaur ulang, kita mengurangi penggunaan bahan baku baru, mengurangi energi yang dibutuhkan untuk produksi, '
              'dan meminimalisir polusi lingkungan. Mari kita bersama-sama berpartisipasi dalam menjaga bumi untuk generasi mendatang.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Manfaat Daur Ulang
            const Text(
              'Manfaat Daur Ulang:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D3D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Menghemat Sumber Daya Alam.\n'
              '2. Mengurangi Emisi Karbon.\n'
              '3. Mengurangi Polusi dan Sampah.\n'
              '4. Menciptakan Lapangan Kerja.\n'
              '5. Mengurangi Kebutuhan Energi.\n',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Ajakan untuk ikut serta
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
              'Setiap langkah kecil yang Anda ambil untuk mendaur ulang memiliki dampak besar bagi planet ini. '
              'Mari kita mulai dari sekarang dengan mendaur ulang barang-barang yang sudah tidak terpakai di rumah kita. '
              'Bersama, kita dapat menciptakan perubahan yang nyata!',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),

            // Button
            Center(
              child: CustomButton(
                text: 'Kembali ke Halaman Utama',
                backgroundColor: const Color(0xFF003D3D),
                textColor: const Color(0xFFB8FF00),
                icon: Icons.arrow_back,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
