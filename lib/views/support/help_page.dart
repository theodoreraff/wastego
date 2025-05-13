import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wastego/widgets/custom_button.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  // Open default email app
  Future<void> _sendEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@wastego.id',
      queryParameters: {
        'subject': 'Laporan Masalah Aplikasi WasteGo',
        'body':
        'Halo tim WasteGo,\n\nSaya ingin melaporkan masalah berikut:\n\n[Tuliskan masalah Anda di sini]',
      },
    ).toString();

    final ok = await launchUrlString(emailUri, mode: LaunchMode.externalApplication);
    if (!ok) {
      debugPrint('Could not launch email client');
    }
  }

  // Open WhatsApp chat with predefined message
  Future<void> _openWhatsApp() async {
    final phone = '6281234567890';
    final message = Uri.encodeComponent('Halo tim WasteGo, saya butuh bantuan.');
    final whatsappUrl = 'https://wa.me/$phone?text=$message';

    final ok = await launchUrlString(whatsappUrl, mode: LaunchMode.externalApplication);
    if (!ok) {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SvgPicture.asset(
                  'assets/images/questions.svg',
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Bingung harus mulai dari mana?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Tenang, kami di sini untuk bantu kamu. Kirim tiket atau hubungi bantuan langsung untuk penanganan cepat.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Buat Tiket',
                      onPressed: _sendEmail,
                      backgroundColor: const Color(0xFF003539),
                      textColor: const Color(0xFFAFEE00),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Panggil Bantuan',
                      onPressed: _openWhatsApp,
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF003539),
                      icon: Icons.help_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const Text(
                    'Riwayat Pengaduan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  DropdownButton<String>(
                    value: '2024',
                    onChanged: (String? newValue) {
                      // TODO: Handle year change
                    },
                    items: <String>['2024', '2023', '2022', '2021']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: const Text(
                    'Tempat Sampah Tidak Diambil',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Pengambilan Terlewatkan'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF003539),
                  ),
                  onTap: () {
                    // TODO: Handle detail view
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
