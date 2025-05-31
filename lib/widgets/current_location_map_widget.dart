import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
// TODO: Potentially add a dependency for WasteGo theme colors if not passed via constructor

class CurrentLocationMapWidget extends StatefulWidget {
  final Set<Marker> scheduleMarkers; // To display markers from the parent page
  final Function(GoogleMapController) onMapCreated;
  final LatLng initialCenter; // Fallback if location cannot be determined

  const CurrentLocationMapWidget({
    super.key,
    this.scheduleMarkers = const {},
    required this.onMapCreated,
    required this.initialCenter,
  });

  @override
  State<CurrentLocationMapWidget> createState() =>
      _CurrentLocationMapWidgetState();
}

class _CurrentLocationMapWidgetState extends State<CurrentLocationMapWidget> {
  final Completer<GoogleMapController> _mapControllerCompleter = Completer();
  GoogleMapController? _mapController;
  BitmapDescriptor? _currentUserLocationIcon;

  LatLng? _currentMapCenter;
  Position? _currentPosition;

  bool _isFetchingLocation = true;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _currentMapCenter = widget.initialCenter;
    _loadMarkerIcons();
    _determineAndAnimateToCurrentPosition();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadMarkerIcons() async {
    try {
      // Ensure you have 'assets/icons/user_pin.png' or change the path
      _currentUserLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)), // Adjust size as needed
        'assets/icons/user_pin.png',
      );
    } catch (e) {
      _currentUserLocationIcon = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      );
    }
    if (mounted) setState(() {});
  }

  Future<void> _determineAndAnimateToCurrentPosition({
    bool forceRefresh = false,
  }) async {
    if (!mounted) return;
    setState(() {
      _isFetchingLocation = true;
      _locationError = null;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _locationError =
              'Location services are disabled. Please enable them.';
          _isFetchingLocation = false;
          _currentMapCenter = widget.initialCenter;
        });
        _showLocationServiceDisabledDialog();
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _locationError = 'Location permissions are denied.';
            _isFetchingLocation = false;
            _currentMapCenter = widget.initialCenter;
          });
          _showPermissionDeniedSnackbar();
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _locationError = 'Location permissions are permanently denied.';
          _isFetchingLocation = false;
          _currentMapCenter = widget.initialCenter;
        });
        _showPermissionDeniedDialog();
      }
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _currentMapCenter = LatLng(position.latitude, position.longitude);
          _isFetchingLocation = false;
          _locationError = null;
        });
        _animateMapToPosition(_currentMapCenter!);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationError = "Could not get current location: ${e.toString()}";
          _isFetchingLocation = false;
          _currentMapCenter = widget.initialCenter;
        });
      }
    }
  }

  void _animateMapToPosition(LatLng position, {double zoom = 16.0}) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    final Set<Marker> allMarkers = Set.from(widget.scheduleMarkers);
    if (_currentPosition != null && _currentUserLocationIcon != null) {
      allMarkers.add(
        Marker(
          markerId: const MarkerId('userCurrentLocation'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          icon: _currentUserLocationIcon!,
          infoWindow: const InfoWindow(title: 'Lokasi Anda Saat Ini'),
        ),
      );
    }
    return allMarkers;
  }

  void _showPermissionDeniedSnackbar() {
    if (!mounted || !ScaffoldMessenger.of(context).mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Location permission denied. Please enable it in settings.',
        ),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () => Geolocator.openAppSettings(),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => AlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
              'Location permissions are permanently denied. Please go to app settings to enable them.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Geolocator.openAppSettings();
                },
              ),
            ],
          ),
    );
  }

  void _showLocationServiceDisabledDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => AlertDialog(
            title: const Text('Location Services Disabled'),
            content: const Text(
              'Please enable location services for this app to function correctly.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Geolocator.openLocationSettings();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using Scaffold to easily provide FAB and SnackBar context
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _currentMapCenter ?? widget.initialCenter,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!mounted) return;
              if (!_mapControllerCompleter.isCompleted) {
                _mapControllerCompleter.complete(controller);
              }
              _mapController = controller;
              widget.onMapCreated(controller); // Notify parent
            },
            markers: _buildMarkers(),
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false, // Custom FAB will handle this
            myLocationEnabled: true, // Shows the blue dot
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
          if (_isFetchingLocation)
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          if (_locationError != null && !_isFetchingLocation)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _locationError!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed:
                          () => _determineAndAnimateToCurrentPosition(
                            forceRefresh: true,
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => _determineAndAnimateToCurrentPosition(forceRefresh: true),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          LucideIcons.locateFixed,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        tooltip: 'Refresh Lokasi',
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Or adjust as needed
    );
  }
}
