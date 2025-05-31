import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/models/schedule_model.dart';
import 'package:wastego/core/providers/schedule_provider.dart';
import 'package:wastego/views/schedule/widgets/schedule_card.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleModel> schedules;
  final Function(ScheduleModel) onScheduleTapped;

  const ScheduleList({
    super.key,
    required this.schedules,
    required this.onScheduleTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return const Center(child: Text("Belum ada jadwal penjemputan."));
    }

    // Access ScheduleProvider for date formatting logic if it's still needed here
    // However, it's better if formatting is done before passing to ScheduleCard
    // For simplicity, I'll assume SchedulePage still handles the formatting for now.
    // If ScheduleProvider is needed for translateDayToIndonesian, it must be accessible.
    final scheduleProvider = Provider.of<ScheduleProvider>(
      context,
      listen: false,
    );

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        // It's generally better to pass formatted strings to simple display widgets,
        // or have the ScheduleCard handle its own formatting if it needs context.
        final day = scheduleProvider.translateDayToIndonesian(
          DateFormat.EEEE().format(schedule.date),
        );
        final date = DateFormat('dd').format(schedule.date);

        return ScheduleCard(
          schedule: schedule,
          dayString: day,
          dateString: date,
          onTap: () => onScheduleTapped(schedule),
        );
      },
    );
  }
}
