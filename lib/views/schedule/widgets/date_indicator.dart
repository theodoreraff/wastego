import 'package:flutter/material.dart';

class DateIndicator extends StatelessWidget {
  final String dateText;

  const DateIndicator({super.key, required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary, // Accent color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        dateText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color:
              Theme.of(context).colorScheme.onSecondary, // Text color on accent
        ),
      ),
    );
  }
}
