import 'package:flutter/material.dart';
import 'package:wastego/core/models/blog_model.dart';

class DetailBlogScreen extends StatelessWidget {
  const DetailBlogScreen({super.key, required this.blogItem});

  final Blog blogItem;

  List<Widget> buildNumberedList(String steps) {
    final lines = steps.trim().split('\n');

    List<Widget> items = [];
    int currentNumber = 0;

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      final stepMatch = RegExp(r'^(\d+)\.\s+(.*)').firstMatch(line);
      if (stepMatch != null) {
        currentNumber = int.parse(stepMatch.group(1)!);
        final stepText = stepMatch.group(2)!;

        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$currentNumber.",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    stepText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        items.add(
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                line.startsWith(RegExp(r'^[•\-*]'))
                    ? const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    )
                    : const Text(''),
                Expanded(
                  child: Text(
                    line.replaceFirst(RegExp(r'^[•\-*]\s*'), ''),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
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
              width: screenWidth * 0.8,
              child: Text(
                blogItem.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.048,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                softWrap: true, // Pastikan teks boleh wrap
                overflow: TextOverflow.visible, // Biarkan teks tampil penuh
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  blogItem.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: Colors.black87),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 6),
                      Text(
                        blogItem.author,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        blogItem.uploadDate,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Materials Required :',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                blogItem.materials,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Steps :',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...buildNumberedList(blogItem.steps),
            ],
          ),
        ),
      ),
    );
  }
}
