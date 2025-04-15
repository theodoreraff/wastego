import 'package:flutter/material.dart';
import 'package:wastego/core/models/tips_model.dart';
import 'package:wastego/views/tips/detail_tips_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wastego/views/tips/menu_tips_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  _sendMails(String mail) async {
    final Uri kaunchUri = Uri(scheme: 'mailto', path: mail);
    if (await canLaunchUrl(kaunchUri)) {
      await launchUrl(kaunchUri);
    } else {
      debugPrint('Tidak bisa membuka Email App.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
          itemCount: tipsList.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/undraw_nature.png',
                          height: 120,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Helpful tips, courtesy of',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 32, 170, 36),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dr. Adam Smith, Ph.D.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Environmental Engineer & Sustainability Consultant',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            GestureDetector(
                              onTap: () {
                                _sendMails('Adam.Smith@gmail.com');
                              },
                              child: Text(
                                'Adam.Smith@gmail.com',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else if (index <= 5) {
              final Tips tips = tipsList[index - 1];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTipsScreen(tipsItem: tips),
                    ),
                  );
                },
                child: listItem(tips),
              );
            } else if (index == 6) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuTipsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAFEE00),
                        foregroundColor: Color(0xFF003539),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Lebih Banyak',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Widget listItem(Tips tipsItem) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              right: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tipsItem.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  tipsItem.titleDescription,
                  style: const TextStyle(
                    fontSize: 10,
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
