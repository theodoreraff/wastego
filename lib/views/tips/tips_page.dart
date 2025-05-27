import 'package:flutter/material.dart';
import 'package:wastego/core/models/tips_model.dart';
import 'package:wastego/views/tips/detail_tips.dart';
import 'package:wastego/views/tips/menu_tips.dart';
import 'package:wastego/widgets/custom_button.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Tips',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tipsList.length + 1, // tanpa header, hanya tips + tombol
          itemBuilder: (context, index) {
            if (index < tipsList.length) {
              final Tips tips = tipsList[index];
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTipsScreen(tipsItem: tips),
                      ),
                    ),
                child: _tipsItem(tips),
              );
            } else if (index == tipsList.length) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Lebih Banyak',
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
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    tipsItem.titleDescription,
                    style: const TextStyle(
                      fontSize: 12,
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
