import 'package:flutter/material.dart';
import 'package:wastego/core/models/event_model.dart';
import 'package:wastego/core/services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService _eventService = EventService();
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> loadEvents() async {
    try {
      _events = await _eventService.fetchEvents();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading events: $e");
      rethrow;
    }
  }
}