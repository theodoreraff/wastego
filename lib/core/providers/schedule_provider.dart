import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for DateFormat
import 'package:wastego/core/models/schedule_model.dart';

class ScheduleProvider with ChangeNotifier {
  List<ScheduleModel> _schedules = [];
  bool _isLoading = false;

  List<ScheduleModel> get schedules => _schedules;
  bool get isLoading => _isLoading;

  Future<void> fetchSchedules() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // New hardcoded schedule list
    final List<Map<String, dynamic>> dummySchedulesData = [
      {
        "locationName": "TPST Bantar Gebang",
        "latitude": -6.349800,
        "longitude": 106.979400,
        "address": "Jl. Bantar Gebang Setu No.1, Bekasi, Jawa Barat",
        "pickupTime": "2025-06-05 08:00", // YYYY-MM-DD HH:mm
        "specialInstructions": "Antar ke pintu barat, cek suhu kendaraan.",
      },
      {
        "locationName": "Bank Sampah Induk Depok",
        "latitude": -6.387000,
        "longitude": 106.823400,
        "address": "Jl. Raya Sawangan No.12, Pancoran Mas, Depok",
        "pickupTime": "2025-06-06 09:30",
        "specialInstructions": "Gunakan jalur belakang dekat masjid.",
      },
      {
        "locationName": "Titik Pengumpulan Pasar Minggu",
        "latitude": -6.268600,
        "longitude": 106.843100,
        "address": "Jl. Raya Ragunan No.24, Pasar Minggu, Jakarta Selatan",
        "pickupTime": "2025-06-07 10:00",
        "specialInstructions": "Parkir di belakang kios sayur, area loading.",
      },
      {
        "locationName": "TPS Terpadu Meruya",
        "latitude": -6.204500,
        "longitude": 106.746800,
        "address": "Jl. Meruya Utara No.45, Kembangan, Jakarta Barat",
        "pickupTime": "2025-06-08 07:45",
        "specialInstructions": "Laporkan ke petugas sebelum bongkar muatan.",
      },
      {
        "locationName": "Drop Point WasteGo Cibubur",
        "latitude": -6.358000,
        "longitude": 106.887700,
        "address": "Komplek Citra Gran, Jl. Alternatif Cibubur No.3, Bekasi",
        "pickupTime": "2025-06-09 11:15",
        "specialInstructions": "Gunakan aplikasi untuk check-in ke petugas.",
      },
    ];

    _schedules =
        dummySchedulesData.map((item) {
          // Parse the pickupTime string to DateTime
          DateTime parsedDate;
          String? pickupTimeStr;
          try {
            parsedDate = DateFormat(
              "yyyy-MM-dd HH:mm",
            ).parse(item["pickupTime"]);
            pickupTimeStr = DateFormat(
              "HH:mm a",
            ).format(parsedDate); // Format to "08:00 AM"
          } catch (e) {
            // Fallback if parsing fails, though with hardcoded data it shouldn't
            print("Error parsing date: ${item["pickupTime"]} - $e");
            parsedDate =
                DateTime.now(); // Should not happen with valid hardcoded data
            pickupTimeStr = null;
          }

          return ScheduleModel(
            // locationName is not directly in ScheduleModel, address field will be used.
            // If locationName is crucial for display, ScheduleModel needs an update.
            // For now, the address field from the dummy data is used.
            date: parsedDate,
            time: pickupTimeStr,
            latitude: item["latitude"] as double?,
            longitude: item["longitude"] as double?,
            address: item["address"] as String?,
            specialInstructions: item["specialInstructions"] as String?,
          );
        }).toList();

    _isLoading = false;
    notifyListeners();
  }

  String translateDayToIndonesian(String englishDay) {
    switch (englishDay) {
      case 'Monday':
        return 'Senin';
      case 'Tuesday':
        return 'Selasa';
      case 'Wednesday':
        return 'Rabu';
      case 'Thursday':
        return 'Kamis';
      case 'Friday':
        return 'Jumat';
      case 'Saturday':
        return 'Sabtu';
      case 'Sunday':
        return 'Minggu';
      default:
        return englishDay;
    }
  }
}
