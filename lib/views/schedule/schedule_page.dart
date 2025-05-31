import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/models/schedule_model.dart';
import 'package:wastego/core/providers/schedule_provider.dart';

/// A page displaying the user's waste pickup schedule.
/// It shows current location, a filter button, a map, and a list of schedules.
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Completer<GoogleMapController> _mapControllerCompleter = Completer();
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor? _wasteIcon; // For custom marker icon

  // Default location (Surabaya)
  static const LatLng _defaultInitialLocation = LatLng(-7.257472, 112.752088);
  LatLng _currentMapCenter = _defaultInitialLocation;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcons();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScheduleProvider>(context, listen: false).fetchSchedules();
    });
  }

  Future<void> _loadMarkerIcons() async {
    // Placeholder for loading custom icons. For now, we'll use default.
    // Example: _wasteIcon = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(size: Size(48, 48)),
    //   'assets/icons/waste_bin_marker.png', // Replace with your actual asset
    // );
    // For now, let it be null to use the default marker.
    // If you add custom icons, ensure they are in your assets folder and pubspec.yaml
  }

  void _onScheduleTapped(ScheduleModel schedule) async {
    if (schedule.latitude != null && schedule.longitude != null) {
      final LatLng location = LatLng(schedule.latitude!, schedule.longitude!);
      setState(() {
        _currentMapCenter = location;
        _markers = {
          Marker(
            markerId: MarkerId(schedule.date.toIso8601String()),
            position: location,
            icon: _wasteIcon ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: schedule.address ?? 'Pickup Location',
              snippet:
                  'Time: ${schedule.time ?? 'N/A'}\nInstructions: ${schedule.specialInstructions ?? 'N/A'}',
            ),
          ),
        };
      });

      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: location, zoom: 15.0),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location data not available for this schedule.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            const Text(
              'Jadwal Penjemputan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Lokasi Kamu:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF003539),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, size: 20, color: Color(0xFF003539)),
                SizedBox(width: 4),
                Text(
                  "Surabaya, Jawa Timur", // Static location for now.
                  style: TextStyle(fontSize: 16, color: Color(0xFF003539)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildLocationFilterButton(),
            const SizedBox(height: 16),
            Container(
              height: 250, // Height for the map
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _currentMapCenter,
                    zoom: 12.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    if (!_mapControllerCompleter.isCompleted) {
                      _mapControllerCompleter.complete(controller);
                    }
                    _mapController = controller;
                    // You can apply custom map styles here if you have a JSON style string
                    // controller.setMapStyle(_mapStyleJsonString);
                  },
                  markers: _markers,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled:
                      false, // Set to true if you want to show user's current location on map
                  // Apply custom map style (green, blue, earth tones)
                  // style: _mapStyleJson, // You'd load this from a JSON file/string
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  scheduleProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : scheduleProvider.schedules.isEmpty
                      ? const Center(child: Text("Belum ada jadwal."))
                      : ListView.builder(
                        itemCount: scheduleProvider.schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = scheduleProvider.schedules[index];
                          final day = scheduleProvider.translateDayToIndonesian(
                            DateFormat.EEEE().format(schedule.date),
                          );
                          final date = DateFormat('dd').format(schedule.date);

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFAFEE00),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                day,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF003539),
                                ),
                              ),
                              subtitle: Text(
                                schedule.time ?? "Tap for details",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              trailing: Container(
                                width: 8,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      schedule.latitude != null &&
                                              schedule.longitude != null
                                          ? const Color(
                                            0xFF003539,
                                          ) // Active if location exists
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onTap: () => _onScheduleTapped(schedule),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the "Pilih Lokasi" button.
  Widget _buildLocationFilterButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fitur Pemilihan Lokasi Sedang Dikembangkan'),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF003539),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black12)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.location_on, color: Color(0xFFAFEE00), size: 20),
            SizedBox(width: 8),
            Text(
              'Pilih Lokasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFAFEE00),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
