import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/providers/schedule_provider.dart';

class SchedulePage extends StatefulWidget {
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScheduleProvider>(context, listen: false).fetchSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            scheduleProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lokasi Kamu:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 20),
                        SizedBox(width: 4),
                        Text("Surabaya, Jawa Timur"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Pilih Lokasi"),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<ScheduleProvider>(
                            context,
                            listen: false,
                          ).fetchSchedules();
                        },
                        child:
                            scheduleProvider.schedules.isEmpty
                                ? const Center(child: Text("Belum ada jadwal."))
                                : ListView.builder(
                                  itemCount: scheduleProvider.schedules.length,
                                  itemBuilder: (context, index) {
                                    final schedule =
                                        scheduleProvider.schedules[index];
                                    final day = DateFormat.EEEE().format(
                                      schedule.date,
                                    );
                                    final date = DateFormat(
                                      'dd',
                                    ).format(schedule.date);

                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(date),
                                      ),
                                      title: Text(day),
                                      subtitle: Text(schedule.time ?? "-"),
                                      trailing: Container(
                                        width: 8,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color:
                                              schedule.time != null
                                                  ? Colors.green[800]
                                                  : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
