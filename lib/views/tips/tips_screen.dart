import 'package:flutter/material.dart';
import 'package:wastego/core/models/tips_model.dart';
import 'package:wastego/views/tips/detail_tips_screen.dart';
import 'package:wastego/views/tips/menu_tips_screen.dart';
import 'package:wastego/widgets/custom_button.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
          itemCount: tipsList.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _headerSection(context);
            } else if (index <= tipsList.length) {
              final Tips tips = tipsList[index - 1];
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
            } else if (index == tipsList.length + 1) {
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
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                child: const Text(
                  'Reach Out: adam.smith@gmail.com',
                  style: TextStyle(
                    fontSize: 10,
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

  Widget _tipsItem(Tips tipsItem) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
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
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                right: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
}
