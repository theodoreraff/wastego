import 'package:wastego/core/models/event_model.dart';

class EventService {
  Future<List<Event>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Event(
        id: 'indo-waste-2025',
        title: "The 15th Indonesia's No.1 International Waste and Recycling Technology and Solution Event",
        date: '13',
        time: '13–15 August 2025',
        location: 'JIEXPO Kemayoran, Jakarta, Indonesia',
        rsvpUrl: 'https://indowaste.com/',
      ),
      Event(
        id: 'icwmre-2025',
        title: "International Conference on Waste Management, Recycling and Environment",
        date: '10',
        time: '10–11 July 2025',
        location: 'Bali, Indonesia',
        rsvpUrl: 'https://waset.org/waste-management-recycling-and-environment-conference-in-july-2025-in-bali',
      ),
      Event(
        id: 'icwmhp-2025',
        title: "International Conference on Waste Management and Handling Practices",
        date: '22',
        time: '22 October 2025',
        location: 'Jakarta Raya, Indonesia',
        rsvpUrl: 'https://allconferencealert.net/eventdetails.php?id=3206898',
      ),
      Event(
        id: 'icwmre-2025-oct',
        title: "International Conference on Waste Management, Recycling and Environment",
        date: '15',
        time: '15-16 July 2025',
        location: 'Bali, Indonesia',
        rsvpUrl: 'https://conferenceindex.org/event/international-conference-on-waste-management-recycling-and-environment-icwmre-2025-july-bali-id',
      ),
      Event(
        id: 'sustainability-forum-monash-2025',
        title: "Sustainability Forum 2025: Bridging The Sustainability Talent Gap to Achieve Net Zero 2060",
        date: '22',
        time: '22 Mei 2025, 08:00 - 13:00 WIB',
        location: 'Monash University, Indonesia - Auditorium Green Office Park 9, Jakarta',
        rsvpUrl: 'https://www.monash.edu/indonesia/industry-partnerships/sustainability-forum',
      ),
    ];
  }
}
