import 'package:flutter/material.dart';

class HomeStats extends StatelessWidget {
  final int totalSampah;

  const HomeStats({super.key, required this.totalSampah});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.05;
    double subtitleFontSize = screenWidth * 0.035;
    double totalSampahFontSize = screenWidth * 0.06;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 140),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF3A6351), Color(0xFFAFEE00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#buangjadiuang",
              style: TextStyle(
                fontSize: titleFontSize, // Smaller title font size
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Terima kasih telah membuat dunia lebih hijau!",
              style: TextStyle(
                fontSize: subtitleFontSize, // Smaller subtitle font size
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.recycling, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Total Sampah kamu",
                      style: TextStyle(
                        fontSize: 14, // Static smaller font size for label
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  totalSampah.toString(),
                  style: TextStyle(
                    fontSize:
                        totalSampahFontSize, // Smaller font size for totalSampah
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
