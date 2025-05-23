import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wastego/core/models/event_model.dart';
import 'package:wastego/core/providers/event_provider.dart';

/// A page displaying a list of environmental events. Users can filter events
/// and RSVP for them.
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String selectedStatus = 'Ongoing'; // Filter for event status.
  bool _isLoading = false; // Manages loading state for event data.

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Load events when the page initializes.
  }

  /// Loads events from the [EventProvider] and handles loading state.
  Future<void> _loadEvents() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<EventProvider>(context, listen: false).loadEvents();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load events: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator.
          : Consumer<EventProvider>(
        builder: (context, provider, _) {
          final events = provider.events;

          // Filter events based on selected status (currently only 'Ongoing' shows all).
          final filteredEvents = events.where((event) {
            if (selectedStatus == 'Ongoing') return true; // Shows all events for 'Ongoing' filter.
            if (selectedStatus == 'Completed') return false; // Placeholder for 'Completed' filter.
            return true; // Default to showing all.
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterDropdown(), // Dropdown to select event status.
                const SizedBox(height: 16),
                if (filteredEvents.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "No events available.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ...filteredEvents.map(_buildEventItem).toList(), // Display filtered events.
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the dropdown for filtering events by status.
  Widget _buildFilterDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "All Events:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStatus,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: ['Ongoing', 'Completed'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedStatus = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a single event item card.
  Widget _buildEventItem(Event event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              event.date, // Display event date.
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title, // Event title.
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "${event.time} • ${event.location}", // Event time and location.
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB6FF16),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              final url = event.rsvpUrl.trim();
              if (url.isNotEmpty) {
                final uri = Uri.parse(url);
                try {
                  // Launch the RSVP URL in an external application.
                  final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
                  if (!success && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open browser.')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to open link: $e')),
                    );
                  }
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('RSVP URL is empty.')),
                  );
                }
              }
            },
            child: const Text("RSVP"),
          ),
        ],
      ),
    );
  }
}