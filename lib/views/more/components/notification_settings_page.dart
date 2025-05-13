import 'package:flutter/material.dart';
import 'package:wastego/widgets/notification_toggle_tile.dart';
import 'package:wastego/widgets/custom_button.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool reminderPickup = true;
  bool promoNotifications = false;
  bool systemUpdates = true;
  String selectedTime = 'Pagi (07:00)';

  final List<String> notificationTimes = [
    'Pagi (07:00)',
    'Siang (12:00)',
    'Sore (17:00)',
  ];

  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan Notifikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Jenis Notifikasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          NotificationToggleTile(
            title: 'Pengingat Jadwal Pengangkutan',
            value: reminderPickup,
            onChanged: (val) => setState(() => reminderPickup = val),
          ),
          NotificationToggleTile(
            title: 'Promo & Reward',
            value: promoNotifications,
            onChanged: (val) => setState(() => promoNotifications = val),
          ),
          NotificationToggleTile(
            title: 'Update Sistem Aplikasi',
            value: systemUpdates,
            onChanged: (val) => setState(() => systemUpdates = val),
          ),
          const SizedBox(height: 24),
          const Text(
            'Waktu Pengingat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedTime,
            decoration: InputDecoration(
              labelText: 'Pilih Waktu',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            items: notificationTimes
                .map((time) => DropdownMenuItem(
              value: time,
              child: Text(
                time,
                style: TextStyle(fontSize: 16),
              ),
            ))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => selectedTime = val);
              }
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Simpan Pengaturan',
            icon: Icons.save,
            onPressed: () {
              showCustomSnackBar('Pengaturan notifikasi disimpan');
            },
          ),
        ],
      ),
    );
  }
}
