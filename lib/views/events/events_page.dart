import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/providers/event_provider.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
        ), // Menghapus 'const' karena 'Text' bukan const constructor
        centerTitle: false,
        leading:
            BackButton(), // Menghapus 'const' karena 'BackButton' bukan const constructor
      ),
      body: FutureBuilder(
        future: Provider.of<EventProvider>(context, listen: false).loadEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return Consumer<EventProvider>(
            builder: (context, provider, child) {
              final events = provider.events;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Lokasi Kamu:", // Menghapus 'const' karena 'Text' bukan const constructor
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_outlined, size: 18),
                          SizedBox(width: 8),
                          Text("Surabaya, Jawa Timur"),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // TODO: Aksi pilih lokasi
                      },
                      child: Text(
                        "Pilih Lokasi",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Semua Event:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: "July",
                          items: [
                            DropdownMenuItem(
                              value: "July",
                              child: Text("July"),
                            ),
                            DropdownMenuItem(
                              value: "August",
                              child: Text("August"),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            // TODO: Handle bulan change
                          },
                          underline: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...events.map((event) => _buildEventItem(event)).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEventItem(event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Tanggal
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              event.date, // Contoh: "02"
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(width: 12),
          // Info Event
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "${event.time} • ${event.location}",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          // Tombol RSVP
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFB6FF16), // Hijau terang
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              // TODO: Aksi RSVP
            },
            child: Text("RSVP"),
          ),
        ],
      ),
    );
  }
}
