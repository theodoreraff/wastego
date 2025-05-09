import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String message;
  final DateTime date;
  final IconData icon;
  final Color color;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    required this.icon,
    required this.color,
  });
}
