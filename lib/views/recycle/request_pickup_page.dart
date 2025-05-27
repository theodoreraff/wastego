import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/custom_button.dart';
import '../../core/services/api_service.dart';

/// A page for users to request waste pickup or drop-off.
/// Users can specify their address, add notes, and confirm selected waste items.
class RequestPickupPage extends StatefulWidget {
  final Map<String, double> itemWeights;

  const RequestPickupPage({super.key, required this.itemWeights});

  @override
  State<RequestPickupPage> createState() => _RequestPickupPageState();
}

class _RequestPickupPageState extends State<RequestPickupPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isPickup = true; // Determines if it's a pickup or drop-off request.
  bool _isLoading = false;

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  /// Submits the pickup/drop-off request to the API.
  Future<void> _submitPickupRequest() async {
    final selectedItems =
        widget.itemWeights.entries.where((e) => e.value > 0).toList();

    if (_addressController.text.trim().isEmpty) {
      _showAlertDialog(
        'Alamat Kosong',
        'Silakan masukkan alamat yang lengkap.',
      );
      return;
    }

    if (selectedItems.isEmpty) {
      _showAlertDialog(
        'Tidak Ada Sampah Dipilih',
        'Silakan pilih minimal satu jenis sampah.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final Map<String, double> wasteDetails = {
        for (var item in selectedItems) item.key.toLowerCase(): item.value,
      };

      final String address = _addressController.text.trim();

      await ApiService.requestPickup(
        wasteDetails: wasteDetails,
        address: address,
        note: _noteController.text.trim(),
        isPickup: _isPickup,
      );

      _showSuccessDialog(address, selectedItems);
    } catch (e) {
      _showAlertDialog('Error', e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Shows a generic alert dialog with a title and content.
  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  /// Shows a success dialog after a successful pickup request.
  void _showSuccessDialog(
    String address,
    List<MapEntry<String, double>> selectedItems,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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
                      Expanded(
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children:
                        selectedItems
                            .map((item) => _buildSuccessItemRow(item))
                            .toList(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003D3D),
                      foregroundColor: const Color(0xFFB8FF00),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst),
                    label: const Text('Selesai'),
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  /// Builds a row for each item in the success dialog.
  Widget _buildSuccessItemRow(MapEntry<String, double> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(_getItemIcon(item.key), size: 20, color: Colors.green),
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
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        widget.itemWeights.entries.where((e) => e.value > 0).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            Text(
              'Permintaan Penjemputan',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _InfoBox(), // Information about pickup/drop-off.
                const SizedBox(height: 8),
                Center(
                  child: _PickupModeToggle(
                    isPickup: _isPickup,
                    onChanged: (value) {
                      setState(() {
                        _isPickup = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Text(
                  '📍 ${_isPickup ? 'Alamat Penjemputan' : 'Alamat Drop Off'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _LabeledTextField(
                  labelText:
                      _isPickup ? "Alamat Penjemputan" : "Alamat Drop Off",
                  hintText: "Contoh: Jl. Raya No.10",
                  iconData:
                      _isPickup
                          ? Icons.home_outlined
                          : Icons.location_on_outlined,
                  controller: _addressController,
                ),
                const Divider(height: 32),
                const Text(
                  '♻️ Daftar Sampah yang Dipilih',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                if (selectedItems.isEmpty)
                  const _EmptyItemBox() // Message if no items are selected.
                else
                  Column(
                    children:
                        selectedItems
                            .map((item) => _WasteItemCard(item: item))
                            .toList(),
                  ),
                const SizedBox(height: 24),
                CustomButton(
                  text:
                      _isPickup
                          ? 'Konfirmasi Penjemputan'
                          : 'Konfirmasi Drop Off',
                  backgroundColor: const Color(0xFF003D3D),
                  textColor: const Color(0xFFB8FF00),
                  icon: Icons.local_shipping_outlined,
                  onPressed: _submitPickupRequest,
                ),
              ],
            ),
          ),
          if (_isLoading) // Show loading overlay when submitting.
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  /// Returns an appropriate icon based on the waste item key.
  IconData _getItemIcon(String key) {
    switch (key.toLowerCase()) {
      case 'plastik':
        return Icons.local_drink_outlined;
      case 'kertas':
        return Icons.description_outlined;
      case 'logam':
        return Icons.settings_outlined;
      case 'kaca':
        return Icons.wine_bar_outlined;
      default:
        return Icons.delete_outline;
    }
  }
}

/// A small informational box explaining pickup/drop-off modes.
class _InfoBox extends StatelessWidget {
  const _InfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: Colors.green),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '🔄 Pilih *Pickup* jika kamu ingin kami menjemput sampah ke rumahmu.\n'
              '🚗 Pilih *Drop Off* jika kamu ingin mengantar langsung ke bank sampah.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

/// A toggle switch for selecting between "Pickup" and "Drop Off" modes.
class _PickupModeToggle extends StatelessWidget {
  final bool isPickup;
  final ValueChanged<bool> onChanged;

  const _PickupModeToggle({required this.isPickup, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeChip(
            label: "Pickup",
            selected: isPickup,
            onTap: () => onChanged(true),
          ),
          const SizedBox(width: 8),
          _ModeChip(
            label: "Drop Off",
            selected: !isPickup,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

/// A customizable chip for the mode toggle.
class _ModeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF003D3D) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? const Color(0xFFB8FF00) : Colors.grey.shade400,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFFB8FF00) : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// A reusable text field with a label, hint, and icon.
class _LabeledTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;

  const _LabeledTextField({
    required this.labelText,
    required this.hintText,
    required this.iconData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, color: Colors.grey.shade600),
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      maxLines: labelText.contains('Catatan') ? 3 : 1,
    );
  }
}

/// A widget displayed when no waste items are selected.
class _EmptyItemBox extends StatelessWidget {
  const _EmptyItemBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      child: const Text(
        'Tidak ada sampah yang dipilih.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}

/// A card displaying a single selected waste item with its weight.
class _WasteItemCard extends StatelessWidget {
  final MapEntry<String, double> item;

  const _WasteItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(_getItemIcon(item.key), color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(item.key, style: const TextStyle(fontSize: 16))),
          Text(
            '${item.value.toStringAsFixed(2)} kg',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Returns an appropriate icon based on the waste item key.
  IconData _getItemIcon(String key) {
    switch (key.toLowerCase()) {
      case 'plastik':
        return Icons.local_drink_outlined;
      case 'kertas':
        return Icons.description_outlined;
      case 'logam':
        return Icons.settings_outlined;
      case 'kaca':
        return Icons.wine_bar_outlined;
      default:
        return Icons.delete_outline;
    }
  }
}
