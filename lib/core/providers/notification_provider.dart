import 'dart:async';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  bool _isLoading = true;
  List<NotificationModel> _notifications = [];

  bool get isLoading => _isLoading;
  List<NotificationModel> get notifications => _notifications;

  NotificationProvider() {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 2));

    _notifications = [
      NotificationModel(
        title: "Jadwal Penjemputan Hari Ini",
        message: "Petugas akan menjemput sampahmu pukul 10:00 WIB.",
        date: DateTime.now().subtract(const Duration(hours: 2)),
        icon: Icons.local_shipping,
        color: Colors.green.shade700,
      ),
      NotificationModel(
        title: "Tukar Poin Berhasil!",
        message: "Kamu berhasil menukar 100 poin dengan voucher belanja.",
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: Icons.card_giftcard,
        color: Colors.orange,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
