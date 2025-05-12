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
  final TextEditingController noteController = TextEditingController();
  bool _isPickup = true;

  @override
  void dispose() {
    addressController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void submitPickupRequest() {
    final selectedItems = widget.itemWeights.entries.where((e) => e.value > 0).toList();

    // Address validation
    if (addressController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Alamat Kosong'),
          content: const Text('Silakan masukkan alamat yang lengkap.'),
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

    final alamat = addressController.text;

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
              Lottie.asset('assets/animation/success.json', height: 150, repeat: false),
              const SizedBox(height: 16),
              const Text(
                'Permintaan Berhasil!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF003D3D)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Terima kasih telah berkontribusi untuk lingkungan 🌱',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.teal),
                  const SizedBox(width: 8),
                  Expanded(child: Text(alamat, style: const TextStyle(fontSize: 14))),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: selectedItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(getItemIcon(item.key), size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('${item.key}: ${item.value.toStringAsFixed(2)} kg',
                              style: const TextStyle(fontSize: 14)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.of(context)..pop()..pop(),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permintaan Penjemputan', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBox(),
            const SizedBox(height: 8),
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
            const SizedBox(height: 16),
            const Text('📍 Alamat Pengantaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _isPickup ? _buildPickupAddressFields() : _buildDropOffAddressFields(),
            const Divider(height: 32),
            const Text('♻️ Daftar Sampah yang Dipilih', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            if (selectedItems.isEmpty)
              _buildEmptyItemBox()
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

  Widget _buildInfoBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '🔄 Pilih *Pickup* jika kamu ingin kami menjemput sampah ke rumahmu.\n'
            '🚗 Pilih *Drop Off* jika kamu ingin mengantar langsung ke bank sampah.',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildPickupAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/map_placeholder.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.map, size: 48, color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(height: 12),
        _buildLabeledTextField("Alamat Lengkap", "Contoh: Jl. Raya No.10", Icons.home_outlined, addressController),
        const SizedBox(height: 16),
        _buildLabeledTextField("Catatan / Patokan Lokasi", "Contoh: Sebelah masjid hijau", Icons.note_alt_outlined, noteController),
      ],
    );
  }

  Widget _buildDropOffAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabeledTextField("Alamat Drop Off", "Contoh: Jl. Raya No.10", Icons.location_on_outlined, addressController),
        const SizedBox(height: 16),
        _buildLabeledTextField("Catatan / Patokan Lokasi", "Contoh: Sebelah taman kota", Icons.note_alt_outlined, noteController),
      ],
    );
  }

  Widget _buildLabeledTextField(String label, String hint, IconData icon, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildEmptyItemBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text('Belum ada item yang dipilih.', style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildModeChip(String label, bool selected, bool isPickup) {
    return ChoiceChip(
      label: Row(
        children: [
          Icon(isPickup ? Icons.directions_car : Icons.location_on_outlined,
              size: 18, color: selected ? Colors.white : Colors.black54),
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

  IconData getItemIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('plastik')) return Icons.local_drink;
    if (lower.contains('kertas')) return Icons.description;
    if (lower.contains('elektronik')) return Icons.devices_other;
    if (lower.contains('logam')) return Icons.build;
    if (lower.contains('kaca')) return Icons.wine_bar;
    return Icons.recycling;
  }
}
