import 'package:flutter/material.dart';
import 'package:wastego/core/models/schedule_model.dart';
import 'package:wastego/views/schedule/widgets/date_indicator.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;
  final String dayString;
  final String dateString;
  final VoidCallback onTap;

  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.dayString,
    required this.dateString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3, // Keep a subtle elevation
      color: Colors.white, // Card background to white
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12, // Adjusted padding
        ),
        leading: DateIndicator(dateText: dateString),
        title: Text(
          dayString,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary, // Dark green text
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule.time ?? "Waktu tidak tersedia",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700], // Darker grey for better contrast
              ),
            ),
            if (schedule.address != null && schedule.address!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  schedule.address!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600], // Slightly lighter grey
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        trailing: Container(
          width: 8,
          height: 40, // Or adjust to fit content
          decoration: BoxDecoration(
            color:
                schedule.latitude != null && schedule.longitude != null
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                    : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
