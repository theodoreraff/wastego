import 'package:flutter/material.dart';
import 'package:wastego/core/models/tips_model.dart';

/// A screen to display the detailed content of a single environmental tip.
/// It shows an image, a description, and a numbered list of steps.
class DetailTipsScreen extends StatelessWidget {
  const DetailTipsScreen({super.key, required this.tipsItem});

  final Tips tipsItem;

  /// Builds a list of widgets from a string of steps, parsing numbered and unnumbered lines.
  List<Widget> buildNumberedList(String steps) {
    final lines = steps.trim().split('\n');
    List<Widget> items = [];

    for (var line in lines) {
      final match = RegExp(r'^(\d+)\.\s+(.*)').firstMatch(line);
      final textStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5, 
      );

      if (match != null) {
        // Numbered line
        final number = match.group(1)!;
        final text = match.group(2)!;
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 28, child: Text("$number.", style: textStyle)),
                Expanded(child: Text(text, style: textStyle)),
              ],
            ),
          ),
        );
      } else {
        // Unnumbered line (misalnya judul langkah)
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              line,
              style: textStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
            Container(
              width: screenWidth * 0.82,
              child: Text(
                tipsItem.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.050,
                  fontWeight: FontWeight.w600,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  tipsItem.imageAsset,
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  tipsItem.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              // Dynamically build and insert the numbered list of steps.
              ...buildNumberedList(tipsItem.steps),
            ],
          ),
        ),
      ),
    );
  }
}
