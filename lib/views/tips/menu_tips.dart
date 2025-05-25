import 'package:flutter/material.dart';
import 'package:wastego/core/models/tips_model.dart';
import 'package:wastego/views/tips/detail_tips.dart';

/// A screen displaying a full list of environmental tips.
class MenuTipsScreen extends StatelessWidget {
  const MenuTipsScreen({super.key});

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
              'Menu Tips',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tipsList.length,
          itemBuilder: (context, index) {
            final Tips tips = tipsList[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the detail screen when a tip is tapped.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTipsScreen(tipsItem: tips),
                  ),
                );
              },
              child: _TipsListItem(tips), // Use a private widget for list item.
            );
          },
        ),
      ),
    );
  }
}

/// A private widget to build a single tip list item card.
/// Renamed from `listItem` for better encapsulation and convention.
class _TipsListItem extends StatelessWidget {
  final Tips tipsItem;

  const _TipsListItem(this.tipsItem);

  @override
  Widget build(BuildContext context) {
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
                mainAxisSize: MainAxisSize.min,
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
