import 'package:flutter/material.dart';

class RecycleHistoryPage extends StatelessWidget {
  const RecycleHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recycleHistory = [
      {
        'date': '14 April 2025',
        'status': 'Menunggu Penjemputan',
        'items': {'Kertas': 2, 'Botol': 1},
      },
      {
        'date': '10 April 2025',
        'status': 'Selesai',
        'items': {'Kardus': 3, 'Besi': 1},
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Permintaan')),
      body: ListView.builder(
        itemCount: recycleHistory.length,
        itemBuilder: (context, index) {
          final item = recycleHistory[index];
          return ListTile(
            title: Text(item['date']),
            subtitle: Text(item['status']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Arahkan ke detail
            },
          );
        },
      ),
    );
  }
}
