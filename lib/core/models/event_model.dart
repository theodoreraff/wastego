class Event {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String rsvpUrl;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.rsvpUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      rsvpUrl: json['rsvpUrl'],
    );
  }
}
