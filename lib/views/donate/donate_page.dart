import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> donationPlatforms = [
      {
        'name': 'Kitabisa',
        'logo': 'assets/images/logo_kitabisa.png',
        'description':
            'Platform galang dana dan donasi online terpercaya di Indonesia.',
        'url': 'https://kitabisa.com/',
      },
      {
        'name': 'BenihBaik',
        'logo': 'assets/images/logo_benihbaik.png',
        'description': 'Lembaga filantropi untuk membantu sesama.',
        'url': 'https://benihbaik.com/',
      },
      {
        'name': 'WeCare.id',
        'logo': 'assets/images/logo_wecare.png',
        'description':
            'Platform penggalangan dana khusus untuk pasien dengan penyakit kronis.',
        'url': 'https://wecare.id/',
      },
      {
        'name': 'Give.asia',
        'logo': 'assets/images/logo_giveasia.png',
        'description':
            'Platform donasi online untuk berbagai kampanye sosial di Asia.',
        'url': 'https://give.asia/',
      },
      {
        'name': 'GlobalGiving',
        'logo': 'assets/images/logo_globalgiving.png',
        'description':
            'Menghubungkan organisasi nirlaba, donor, dan perusahaan di hampir setiap negara.',
        'url': 'https://www.globalgiving.org/',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            Text(
              'Donasi',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Dukung platform donasi terpercaya dan bantu wujudkan masa depan yang lebih bersih dan hijau.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: donationPlatforms.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final platform = donationPlatforms[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Optionally enable this line if logos are available
                            // Image.asset(platform['logo']!, height: 40, width: 40),
                            // const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                platform['name']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF003539),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (platform['description'] != null &&
                            platform['description']!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            platform['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFAFEE00),
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () => _launchURL(platform['url']!),
                            child: const Text('Donate Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
