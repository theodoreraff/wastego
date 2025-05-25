import 'package:flutter/material.dart';
import 'package:wastego/core/models/donate_model.dart';

class DonateHistoryScreen extends StatelessWidget {
  const DonateHistoryScreen({super.key, required this.donateItem});
  final Donate donateItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8), // Atur sesuai kebutuhan
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 24),
          ),
        ),
        titleSpacing: 0,
        title: Text(
          'Riwayat Donasi',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: donateItem.donationHistory.length,
                  itemBuilder: (context, index) {
                    final donation = donateItem.donationHistory[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/Frame_131.png"),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  donation.name,
                                  style: const TextStyle(
                                    fontSize: 14,

                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  donation.amount,
                                  style: const TextStyle(
                                    fontSize: 14,

                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            donation.donationDate,
                            style: const TextStyle(
                              fontSize: 14,

                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
