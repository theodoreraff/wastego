import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wastego/views/recycle/request_pickup_page.dart';
import 'package:wastego/views/recycle/info_page.dart';
import '../../widgets/custom_button.dart';

/// A page where users can input the weight of different recyclable items,
/// get an estimated exchange value, and request a pickup.
class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  // Stores the current weight for each item.
  final Map<String, double> itemWeights = {
    'Kertas': 0.0,
    'Botol': 0.0,
    'Besi': 0.0,
    'Kardus': 0.0,
  };

  // Prices per kg for each item.
  final Map<String, double> itemPricesPerKg = {
    'Kertas': 1200.0,
    'Botol': 1800.0,
    'Besi': 3500.0,
    'Kardus': 1300.0,
  };

  // Icons for each item.
  final Map<String, IconData> itemIcons = {
    'Kertas': LucideIcons.file,
    'Botol': LucideIcons.beer,
    'Besi': LucideIcons.packageCheck,
    'Kardus': LucideIcons.box,
  };

  final Map<String, FocusNode> focusNodes = {};

  // Text controllers for inputting item weights.
  final Map<String, TextEditingController> controllers = {};
  late SharedPreferences prefs;
  String? idToken; // User authentication token.

  @override
  void initState() {
    super.initState();
    initPreferences();
    // Initialize a TextEditingController for each item.
    for (var key in itemWeights.keys) {
      controllers[key] = TextEditingController();
      focusNodes[key] = FocusNode();

      // Pasang listener untuk validasi saat kehilangan fokus
      focusNodes[key]!.addListener(() {
        if (!focusNodes[key]!.hasFocus) {
          // Saat kehilangan fokus, cek dan validasi nilai
          final text = controllers[key]!.text;
          double value = double.tryParse(text) ?? 0.0;
          if (value > 1000) {
            value = 1000.0;

            // Update controller text dan state
            controllers[key]!.text =
                value % 1 == 0 ? value.toInt().toString() : value.toString();

            setState(() {
              itemWeights[key] = value;
            });

            // Update SharedPreferences
            prefs.setDouble('weight_$key', value);
          }
        }
      });
    }
  }

  /// Initializes SharedPreferences and loads saved item weights and user token.
  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    idToken = prefs.getString('idToken'); // Load token.

    for (var key in itemWeights.keys) {
      await prefs.remove('weight_$key');
    }
    setState(() {
      // Load saved weights or default to 0.0.
      for (var key in itemWeights.keys) {
        itemWeights[key] = 0.0;
        controllers[key]?.text = '';
      }
    });
  }

  @override
  void dispose() {
    // Dispose all TextEditingControllers.
    for (var controller in controllers.values) {
      controller.dispose();
    }
    for (var node in focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  /// Displays an alert dialog for various warnings.
  void showAlert(String action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Tunggu dulu!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            action == 'estimasi'
                ? 'Masukkan berat barang untuk melihat estimasi nilai tukar.'
                : 'Belum ada barang yang ditambahkan untuk dijemput, ayo isi beratnya!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF003D3D),
              ),
              child: const Text(
                'Oke',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Shows a bottom sheet with the estimated value of the selected items.
  void showEstimationSheet() {
    final totalKg = itemWeights.values.fold(0.0, (sum, weight) => sum + weight);
    if (totalKg == 0) {
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
                ...itemWeights.entries
                    .where((entry) => entry.value > 0)
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${entry.key} (${entry.value.toStringAsFixed(2)} kg)',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rp${(entry.value * itemPricesPerKg[entry.key]!).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp${itemWeights.entries.map((e) => e.value * itemPricesPerKg[e.key]!).reduce((a, b) => a + b).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '*Estimasi harga dapat berubah tergantung kondisi barang.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
    );
  }

  /// Sends a request to the backend to get a pickup estimate or initiate a pickup.
  Future<void> sendPickupRequest() async {
    final totalKg = itemWeights.values.fold(0.0, (sum, weight) => sum + weight);
    if (totalKg == 0) {
      showAlert('penjemputan');
      return;
    }

    if (idToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Token tidak ditemukan. Silakan login ulang.'),
        ),
      );
      return;
    }

    // Prepare request body with waste details.
    Map<String, dynamic> requestBody = {
      'wasteDetails': itemWeights.map(
        (key, value) => MapEntry(key.toLowerCase(), value.toInt()),
      ),
    };

    try {
      final response = await http.post(
        Uri.parse('https://fahmi.led.my.id/api/waste-pickup/estimate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Navigate to the RequestPickupPage on success.
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RequestPickupPage(itemWeights: itemWeights),
            ),
          );
        }
      } else {
        // Show error from the server.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal mengirim permintaan: ${response.reasonPhrase}',
            ),
          ),
        );
      }
    } catch (e) {
      // Show general error message.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'Daur Ulang',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.info_outline, size: 25),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InfoPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: const Text(
                  '🌍 Mari daur ulang barang bekasmu!\n'
                  'Masukkan berat barang yang ingin Anda daur ulang untuk mendapatkan estimasi penukaran. '
                  'Semakin banyak barang yang Anda masukkan, semakin besar estimasi yang akan Anda terima.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                'Isi berat barang dalam kilogram (kg) untuk masing-masing kategori yang tersedia.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Dynamically build input fields for each recyclable item.
              ...itemWeights.keys.map((key) {
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
                      SizedBox(
                        width: 65,
                        child: StatefulBuilder(
                          builder: (context, setInnerState) {
                            final controller = controllers[key]!;
                            final hasText = controller.text.isNotEmpty;
                            return TextField(
                              controller: controller,
                              focusNode: focusNodes[key],
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: hasText ? null : 'kg',
                                labelText: hasText ? 'kg' : null,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF003D3D),
                                    width: 2,
                                  ),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onChanged: (value) async {
                                double parsed = double.tryParse(value) ?? 0.0;
                                setState(() {
                                  itemWeights[key] = parsed;
                                });
                                setInnerState(() {});
                                await prefs.setDouble(
                                  'weight_$key',
                                  parsed,
                                ); // Save weight to SharedPreferences.
                              },
                            );
                          },
                        ),
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
                text: 'Minta Penjemputan',
                backgroundColor: const Color(0xFF003D3D),
                textColor: const Color(0xFFB8FF00),
                icon: Icons.local_shipping_outlined,
                onPressed: sendPickupRequest,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
