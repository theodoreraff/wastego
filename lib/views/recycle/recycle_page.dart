import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastego/views/recycle/request_pickup_page.dart';
import 'package:wastego/views/recycle/info_page.dart';
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

  void showAlert(String action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Tunggu dulu!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            action == 'estimasi'
                ? 'Yuk, tambahkan beberapa barang terlebih dahulu untuk melihat estimasi penukaran. Semakin banyak barang, semakin besar estimasi!'
                : 'Sepertinya kamu belum menambahkan barang untuk dijemput. Ayo, pilih barang yang ingin dijemput terlebih dahulu!',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Oke, Siap!'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF003D3D),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEstimationSheet() {
    final totalItems = itemCounts.values.fold(0, (sum, count) => sum + count);

    if (totalItems == 0) {
      showAlert('estimasi');
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Estimasi Penukaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                ...itemCounts.entries
                    .where((entry) => entry.value > 0)
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${entry.key} (${entry.value}x)'),
                            Text('Rp${entry.value * 1}'),
                          ],
                        ),
                      ),
                    ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Estimasi:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp${itemCounts.entries.map((e) => e.value * 1).reduce((a, b) => a + b)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '*Harga estimasi, bisa berubah tergantung kondisi barang.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
    );
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // Redirect ke InfoPage saat ikon info ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InfoPage()),
                );
              },
            ),
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
              text: 'Lihat Estimasi',
              backgroundColor: const Color(0xFFB8FF00),
              textColor: Colors.black,
              icon: Icons.calculate_outlined,
              onPressed: showEstimationSheet,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Meminta Penjemputan',
              backgroundColor: const Color(0xFF003D3D),
              textColor: const Color(0xFFB8FF00),
              icon: Icons.local_shipping_outlined,
              onPressed: () {
                final totalItems = itemCounts.values.fold(
                  0,
                  (sum, count) => sum + count,
                );
                if (totalItems == 0) {
                  showAlert('penjemputan');
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestPickupPage(itemCounts: itemCounts),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
