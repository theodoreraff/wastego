import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeStats extends StatelessWidget {
  final int totalSampah;
  final int targetSampah;

  const HomeStats({
    super.key,
    required this.totalSampah,
    this.targetSampah = 200,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double titleSize = screenWidth * 0.04;
    final double labelSize = screenWidth * 0.035;
    final double valueSize = screenWidth * 0.045;

    final double progress = (totalSampah / targetSampah).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3A6351), Color(0xFFAFEE00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Campaign title & message
          Text(
            "#buangajadulu",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(1.5, 1.5),
                  blurRadius: 3,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),
          Text(
            "Setiap sampah yang kamu kelola, punya nilai lebih. Yuk, dukung bumi!",
            style: TextStyle(
              fontSize: labelSize,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),

          /// Waste stat row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Total Sampah Kamu:",
                    style: TextStyle(
                      fontSize: labelSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                "$totalSampah Kg",
                style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Progress bar only
          LinearPercentIndicator(
            lineHeight: 6.0,
            percent: progress,
            animation: true,
            barRadius: const Radius.circular(6),  // radius lebih kecil
            backgroundColor: Colors.white.withOpacity(0.2),
            progressColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
