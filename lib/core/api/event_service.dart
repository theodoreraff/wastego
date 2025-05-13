import 'package:wastego/core/models/event_model.dart';

class EventService {
  Future<List<Event>> fetchEvents() async {
    // Simulasi delay fetch data
    await Future.delayed(const Duration(seconds: 1));

    return [
      Event(
        id: 'indo-waste-2025',
        title: "The 15th Indonesia's No.1 International Waste and Recycling Technology and Solution Event",
        date: '13',
        time: '13–15 August 2025',
        location: 'JIEXPO Kemayoran, Jakarta, Indonesia',
        rsvpUrl: 'https://indowaste.com/',
      )
    ];
  }
}
