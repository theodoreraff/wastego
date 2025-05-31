class ScheduleModel {
  final DateTime date;
  final String? time;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? specialInstructions;

  ScheduleModel({
    required this.date,
    this.time,
    this.latitude,
    this.longitude,
    this.address,
    this.specialInstructions,
  });
}
