import 'package:flutter/material.dart';

class RequestPickupPage extends StatelessWidget {
  final Map<String, int> itemCounts;

  const RequestPickupPage({super.key, required this.itemCounts});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Form Penjemputan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alamat Penjemputan'),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Masukkan alamat lengkap...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Catatan Tambahan (Opsional)'),
            const SizedBox(height: 8),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Contoh: Harap jemput sebelum jam 5 sore.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Rangkuman Sampah:'),
            ...itemCounts.entries
                .where((entry) => entry.value > 0)
                .map((entry) => Text('${entry.key}: ${entry.value}')),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: simpan ke database atau kirim ke backend
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text("Berhasil!"),
                        content: const Text(
                          "Permintaan penjemputan telah dikirim.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Kirim Permintaan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D3D),
                foregroundColor: const Color(0xFFB8FF00),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
