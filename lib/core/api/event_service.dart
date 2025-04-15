import 'package:wastego/core/models/event_model.dart';

class EventService {
  Future<List<Event>> fetchEvents() async {
    // Simulasi ambil data dari API (nanti bisa diganti http.get atau dio)
    await Future.delayed(Duration(seconds: 1));
    return [
      Event(
        id: '1',
        title: 'Surabaya Cleaning Program',
        date: '02',
        time: 'Thu, 8 am',
        location: 'Keputih, Surabaya',
        address: '44621',
      ),
      // Tambah event lainnya sesuai kebutuhan
    ];
  }
}
