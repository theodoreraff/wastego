import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastego/views/recycle/request_pickup_page.dart';
import '../../widgets/custom_button.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  final Map<String, int> itemCounts = {
    'Kertas': 0,
    'Botol': 0,
    'Besi': 0,
    'Kardus': 0,
  };

  final Map<String, IconData> itemIcons = {
    'Kertas': LucideIcons.file,
    'Botol': LucideIcons.beer,
    'Besi': LucideIcons.packageCheck,
    'Kardus': LucideIcons.box,
  };

  void increment(String key) {
    setState(() {
      itemCounts[key] = itemCounts[key]! + 1;
    });
  }

  void decrement(String key) {
    setState(() {
      if (itemCounts[key]! > 0) {
        itemCounts[key] = itemCounts[key]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recycle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...itemCounts.keys.map((key) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(itemIcons[key], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => decrement(key),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      itemCounts[key].toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () => increment(key),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Menghitung',
              backgroundColor: const Color(0xFFB8FF00),
              textColor: Colors.black,
              onPressed: () {
                // TODO: implementasi perhitungan
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Meminta Penjemputan',
              backgroundColor: const Color(0xFF003D3D),
              textColor: const Color(0xFFB8FF00),
              icon: Icons.local_shipping_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestPickupPage(itemCounts: itemCounts),
                  ),
                ); // TODO: implementasi permintaan penjemputan
              },
            ),
          ],
        ),
      ),
    );
  }
}
