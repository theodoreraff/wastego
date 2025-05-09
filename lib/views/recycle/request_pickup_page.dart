import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/custom_button.dart';

class RequestPickupPage extends StatefulWidget {
  final Map<String, double> itemWeights;

  const RequestPickupPage({super.key, required this.itemWeights});

  @override
  State<RequestPickupPage> createState() => _RequestPickupPageState();
}

class _RequestPickupPageState extends State<RequestPickupPage> {
  final TextEditingController addressController = TextEditingController();
  bool _isPickup = true;

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  void submitPickupRequest() {
    final selectedItems = widget.itemWeights.entries.where((e) => e.value > 0).toList();

    if (_isPickup && addressController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Alamat Kosong'),
          content: const Text('Silakan masukkan alamat penjemputan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final alamat = _isPickup ? addressController.text : "Jl. Kita Masih Panjang, Jawa Selatan";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animation/success.json',
                height: 150,
                repeat: false,
              ),
              const SizedBox(height: 16),
              const Text(
                'Permintaan Berhasil!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003D3D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kami telah menerima permintaan kamu. Terima kasih telah berkontribusi untuk lingkungan 🌱',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Colors.teal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alamat,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(getItemIcon(item.key), size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${item.key}: ${item.value.toStringAsFixed(2)} kg',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D3D),
                  foregroundColor: const Color(0xFFB8FF00),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Selesai'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = widget.itemWeights.entries.where((e) => e.value > 0).toList();
    const String bankSampahAddress = "Jl. Kita Masih Panjang, Jawa Selatan";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Permintaan Penjemputan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '🔄 Pilih *Pickup* jika kamu ingin kami menjemput sampah ke rumahmu.\n'
                    '🚗 Pilih *Drop Off* jika kamu ingin mengantar langsung ke bank sampah.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildModeChip("Pickup", _isPickup, true),
                    const SizedBox(width: 8),
                    _buildModeChip("Drop Off", !_isPickup, false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📍 Alamat Penjemputan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _isPickup
                      ? TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat lengkap...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    maxLines: 2,
                  )
                      : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.teal),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            bankSampahAddress,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),
            const Text(
              '♻️ Daftar Sampah yang Dipilih',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (selectedItems.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Belum ada item yang dipilih.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Column(
                children: selectedItems.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(getItemIcon(item.key), color: Colors.green),
                        const SizedBox(width: 12),
                        Expanded(child: Text(item.key, style: const TextStyle(fontSize: 16))),
                        Text('${item.value.toStringAsFixed(2)} kg',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
            CustomButton(
              text: _isPickup ? 'Konfirmasi Penjemputan' : 'Konfirmasi Drop Off',
              backgroundColor: const Color(0xFF003D3D),
              textColor: const Color(0xFFB8FF00),
              icon: Icons.local_shipping_outlined,
              onPressed: submitPickupRequest,
            ),
          ],
        ),
      ),
    );
  }

  IconData getItemIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('plastik')) return Icons.local_drink;
    if (lower.contains('kertas')) return Icons.description;
    if (lower.contains('elektronik')) return Icons.devices_other;
    if (lower.contains('logam')) return Icons.build;
    if (lower.contains('kaca')) return Icons.wine_bar;
    return Icons.recycling;
  }

  Widget _buildModeChip(String label, bool selected, bool isPickup) {
    return ChoiceChip(
      label: Row(
        children: [
          Icon(
            isPickup ? Icons.directions_car : Icons.location_on_outlined,
            size: 18,
            color: selected ? Colors.white : Colors.black54,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      selectedColor: const Color(0xFF003D3D),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black54,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _isPickup = isPickup),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
