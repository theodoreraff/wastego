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
        title: const Text(
          'Jadwal Penjemputan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
        scrolledUnderElevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            scheduleProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Color(0xFF003539),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Surabaya, Jawa Timur",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF003539),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLocationFilterButton(),
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

                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 5,
                                      color: Colors.white,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                        leading: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFAFEE00),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                          schedule.time ?? "-",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 8,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                schedule.time != null
                                                    ? const Color(0xFF003539)
                                                    : Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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

  Widget _buildLocationFilterButton() {
    return GestureDetector(
      onTap: () {
        // Implement filter location action here
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
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
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
              ), // Warna aksen hijau
            ),
          ],
        ),
      ),
    );
  }
}
