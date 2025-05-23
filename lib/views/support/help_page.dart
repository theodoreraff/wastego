import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wastego/widgets/custom_button.dart';

/// A help and support page providing options to contact support via email or WhatsApp.
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  /// Launches the default email application with a pre-filled support email.
  Future<void> _sendEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@wastego.id',
      queryParameters: {
        'subject': 'Laporan Masalah Aplikasi WasteGo',
        'body': 'Halo tim WasteGo,\n\nSaya mengalami kendala berikut:\n\n[Tuliskan masalah Anda di sini]',
      },
    ).toString();

    final ok = await launchUrlString(emailUri, mode: LaunchMode.externalApplication);
    if (!ok) {
      debugPrint('Tidak dapat membuka aplikasi email.');
    }
  }

  /// Launches WhatsApp with a pre-filled support message.
  Future<void> _openWhatsApp() async {
    final phone = '6287820763118'; // Replace with actual WhatsApp number
    final message = Uri.encodeComponent('Halo tim WasteGo, saya butuh bantuan.');
    final whatsappUrl = 'https://wa.me/$phone?text=$message';

    final ok = await launchUrlString(whatsappUrl, mode: LaunchMode.externalApplication);
    if (!ok) {
      debugPrint('Tidak dapat membuka WhatsApp.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/questions.svg',
              height: 160,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              'Ada yang Bisa Kami Bantu?',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kami siap membantu! Kamu bisa laporkan kendala melalui email, atau langsung chat kami via WhatsApp.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Laporkan Masalah',
                    onPressed: _sendEmail,
                    backgroundColor: const Color(0xFF003539),
                    textColor: const Color(0xFFAFEE00),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openWhatsApp,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF003539),
                      side: const BorderSide(color: Color(0xFF003539), width: 1.4),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Chat WhatsApp'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}