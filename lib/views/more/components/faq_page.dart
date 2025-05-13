import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF003539);
    final TextStyle questionStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: primaryColor,
    );
    final TextStyle answerStyle = const TextStyle(
      fontSize: 15,
      color: Colors.black87,
      height: 1.6,
    );
    final TextStyle introStyle = const TextStyle(
      fontSize: 15.5,
      color: Colors.black87,
      height: 1.7,
    );

    final List<Map<String, String>> faqItems = [
      {
        'question': 'Bagaimana cara memesan layanan pengangkutan?',
        'answer':
        'Pilih jadwal dan jenis sampah di halaman utama aplikasi, lalu konfirmasi pesanan kamu.',
      },
      {
        'question': 'Apa saja jenis sampah yang bisa diangkut?',
        'answer':
        'Kami menerima sampah rumah tangga, sampah organik, dan beberapa jenis sampah elektronik kecil.',
      },
      {
        'question': 'Apakah ada biaya tambahan?',
        'answer':
        'Tidak ada biaya tersembunyi. Semua biaya akan ditampilkan secara transparan sebelum kamu menyelesaikan pesanan.',
      },
      {
        'question': 'Bagaimana sistem reward bekerja?',
        'answer':
        'Kamu akan mendapatkan poin dari aktivitas seperti pengangkutan rutin. Poin ini bisa ditukar dengan reward tertentu di aplikasi.',
      },
      {
        'question': 'Bagaimana cara mengganti metode pembayaran?',
        'answer':
        'Kamu bisa masuk ke Pengaturan > Metode Pembayaran untuk menambahkan atau mengubah metode pembayaran kamu.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Frequently Asked Question'),

      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildIntroText(introStyle),
          const SizedBox(height: 20),
          ...faqItems.map((item) => _buildFAQItem(
            question: item['question']!,
            answer: item['answer']!,
            questionStyle: questionStyle,
            answerStyle: answerStyle,
          )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildIntroText(TextStyle introStyle) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Punya pertanyaan?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003539),
            ),
          ),
          TextSpan(
            text:
            '\nSantai, kami di sini buat bantu kamu. Kadang, hal kecil bikin bingung. '
                'Di sini kami kumpulkan jawaban dari pertanyaan yang paling sering ditanyain pengguna Waste Go — '
                'biar kamu bisa lanjut pakai aplikasi tanpa ribet. Yuk, cek jawabannya di bawah ini 👇',
            style: introStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required TextStyle questionStyle,
    required TextStyle answerStyle,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          collapsedIconColor: const Color(0xFF003539),
          iconColor: const Color(0xFF003539),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(question, style: questionStyle),
          children: [
            Text(answer, style: answerStyle),
          ],
        ),
      ),
    );
  }
}
