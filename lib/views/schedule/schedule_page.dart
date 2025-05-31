import 'dart:async';
import 'package:flutter/material.dart';
// Geolocator is now in CurrentLocationMapWidget
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Still needed for LatLng, MarkerId etc.
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/models/schedule_model.dart';
import 'package:wastego/core/providers/schedule_provider.dart';
import 'package:wastego/widgets/current_location_map_widget.dart';
import 'package:wastego/views/schedule/widgets/schedule_list.dart'; // Added import

/// A page displaying the user's waste pickup schedule.
/// It shows current location via a map widget, and a list of schedules.
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Completer<GoogleMapController> _mapControllerCompleter = Completer();
  GoogleMapController? _mapController;
  Set<Marker> _scheduleMarkers = {}; // Renamed from _markers
  BitmapDescriptor? _wasteIcon; // For custom schedule marker icon

  // Default location (e.g., center of a city, if current location fails for the map widget)
  static const LatLng _defaultFallbackLocation = LatLng(
    -7.257472,
    112.752088,
  ); // Surabaya
  // _currentMapCenter is now managed by CurrentLocationMapWidget
  // _currentPosition is now managed by CurrentLocationMapWidget
  // _isFetchingLocation is now managed by CurrentLocationMapWidget
  // _locationError is now managed by CurrentLocationMapWidget

  @override
  void initState() {
    super.initState();
    _loadScheduleMarkerIcon(); // Renamed and simplified
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ScheduleProvider>(
          context,
          listen: false,
        ).fetchSchedules().then((_) {
          // After schedules are fetched, update markers
          if (mounted) _updateScheduleMarkers();
        });
      }
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadScheduleMarkerIcon() async {
    // Placeholder for loading custom icons for schedules.
    // Example: _wasteIcon = await BitmapDescriptor.fromAssetImage(...);
    // For now, let it be null to use the default marker for schedules.
    // If you have a custom icon for schedules, load it here.
    // e.g., _wasteIcon = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(size: Size(48, 48)), 'assets/icons/waste_schedule_pin.png');
    if (mounted) setState(() {});
  }

  // This method now only animates the map, typically when a schedule is tapped.
  // The map controller is obtained from the CurrentLocationMapWidget.
  void _animateMapToSchedulePosition(LatLng position, {double zoom = 15.0}) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
  }

  // This method now only updates markers for schedules.
  // User's current location marker is handled by CurrentLocationMapWidget.
  void _updateScheduleMarkers() {
    if (!mounted) return;
    Set<Marker> newScheduleMarkers = {};
    final scheduleProvider = Provider.of<ScheduleProvider>(
      context,
      listen: false,
    );

    for (var schedule in scheduleProvider.schedules) {
      if (schedule.latitude != null && schedule.longitude != null) {
        newScheduleMarkers.add(
          Marker(
            markerId: MarkerId('schedule_${schedule.date.toIso8601String()}'),
            position: LatLng(schedule.latitude!, schedule.longitude!),
            icon:
                _wasteIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
            infoWindow: InfoWindow(
              title: schedule.address ?? 'Pickup Location',
              snippet: 'Time: ${schedule.time ?? 'N/A'}',
            ),
            onTap: () => _onScheduleTapped(schedule),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        _scheduleMarkers = newScheduleMarkers;
      });
    }
  }

  void _onScheduleTapped(ScheduleModel schedule) async {
    if (schedule.latitude != null && schedule.longitude != null) {
      final LatLng location = LatLng(schedule.latitude!, schedule.longitude!);
      _animateMapToSchedulePosition(location); // Uses the page's map controller

      // Optionally, show InfoWindow if mapController is available
      final GoogleMapController? controller =
          await _mapControllerCompleter.future;
      controller?.showMarkerInfoWindow(
        MarkerId('schedule_${schedule.date.toIso8601String()}'),
      );
    } else {
      if (mounted && ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location data not available for this schedule.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  // Permission/Service dialogs are now handled by CurrentLocationMapWidget.
  // _showPermissionDeniedSnackbar, _showPermissionDeniedDialog, _showLocationServiceDisabledDialog are removed.

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    // Update schedule markers when schedules change
    // This check ensures we don't call setState during build if schedules are already processed.
    if (scheduleProvider.schedules.isNotEmpty &&
        _scheduleMarkers.length !=
            scheduleProvider.schedules
                .where((s) => s.latitude != null && s.longitude != null)
                .length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateScheduleMarkers();
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Text(
              "Pilih Lokasi Drop-off",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Subtle size
                color: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.8), // Subtle color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            // Map and list should take available space
            flex: 2, // Give map more space initially
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                ),
                clipBehavior:
                    Clip.antiAlias, // Important for rounded corners on map
                child: CurrentLocationMapWidget(
                  initialCenter: _defaultFallbackLocation,
                  scheduleMarkers: _scheduleMarkers,
                  onMapCreated: (GoogleMapController controller) {
                    if (!mounted) return;
                    if (!_mapControllerCompleter.isCompleted) {
                      _mapControllerCompleter.complete(controller);
                    }
                    _mapController = controller;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            // List of schedules
            flex: 3, // Give list more space
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  scheduleProvider.isLoading &&
                          scheduleProvider.schedules.isEmpty
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                      : ScheduleList(
                        schedules: scheduleProvider.schedules,
                        onScheduleTapped: _onScheduleTapped,
                      ),
            ),
          ),
          const SizedBox(height: 16), // Padding at the bottom
        ],
      ),
      // FloatingActionButton is now managed by CurrentLocationMapWidget
    );
  }

  // _buildMapArea method is now removed as its logic is in CurrentLocationMapWidget
}
