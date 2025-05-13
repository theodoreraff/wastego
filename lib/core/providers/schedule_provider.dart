import 'package:flutter/material.dart';
import 'package:wastego/core/models/schedule_model.dart';

class ScheduleProvider with ChangeNotifier {
  List<ScheduleModel> _schedules = [];
  bool _isLoading = false;

  List<ScheduleModel> get schedules => _schedules;
  bool get isLoading => _isLoading;

  Future<void> fetchSchedules() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading

    _schedules = List.generate(9, (index) {
      DateTime date = DateTime(2025, 7, index + 1);
      String? time;

      if ([0, 4, 6, 8].contains(index)) {
        time = switch (index) {
          6 => "6:00 AM",
          8 => "5:30 AM",
          _ => "5:00 AM",
        };
      }

      return ScheduleModel(date: date, time: time);
    });

    _isLoading = false;
    notifyListeners();
  }
}
