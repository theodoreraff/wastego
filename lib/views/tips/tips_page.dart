import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wastego/core/models/tips_model.dart';
import 'package:wastego/views/tips/detail_tips.dart';
import 'package:wastego/views/tips/menu_tips.dart';
import 'package:wastego/widgets/custom_button.dart';

/// A page displaying environmental tips, featuring an expert's introduction
/// and a list of tips with a "More" button.
class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            const Text(
              "Tips",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount:
              tipsList.length + 2, // Account for header and "More" button.
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  _headerSection(context),
                  const SizedBox(
                    height: 10,
                  ), // <-- jarak antara header dan tips
                ],
              );
            } else if (index <= tipsList.length) {
              final Tips tips = tipsList[index - 1]; // Get tip from list.
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTipsScreen(tipsItem: tips),
                      ),
                    ),
                child: _tipsItem(tips), // Display individual tip item.
              );
            } else if (index == tipsList.length + 1) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Lebih Banyak', // "More" button.
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuTipsScreen(),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFFAFEE00),
                    textColor: const Color(0xFF003539),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            } else {
              return const SizedBox.shrink(); // Fallback for unexpected index.
            }
          },
        ),
      ),
    );
  }

  /// Builds the header section with expert information.
  Widget _headerSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60.0),
          child: Image.asset(
            'assets/images/adam.jpeg',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ready to make the world greener?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF32A824),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Here are expert tips from Dr. Adam Smith!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003539),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Environmental Expert and Sustainability Advocate',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'adam.smith@gmail.com',
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(
                      emailUri,
                      mode: LaunchMode.externalApplication, // ✅ Ini penting!
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak dapat membuka aplikasi email'),
                      ),
                    );
                  }
                },

                child: const Text(
                  'Reach Out: adam.smith@gmail.com',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF32A824),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a single tips item card.
  Widget _tipsItem(Tips tipsItem) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2,
      margin: const EdgeInsets.all(3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(tipsItem.imageAsset),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tipsItem.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    tipsItem.titleDescription,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
