import 'package:flutter/material.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: const ListTile(
        title: Text('Versi Aplikasi'),
        trailing: Text('1.0.1', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
