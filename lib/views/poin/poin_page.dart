import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wastego/widgets/custom_button.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height to dynamically adjust padding/margins
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Points'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon/Illustration related to points
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                  child: SvgPicture.asset(
                    'assets/images/poin.svg',
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const Text(
                  'Your Points: 1000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Amazing! You have collected a lot of points! 🎉\nKeep collecting more and get exciting rewards!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // Action Buttons for Redeem and Invite Friends
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Redeem Points Now',
                        onPressed: () {
                          // TODO: Implement point redemption functionality
                        },
                        backgroundColor: const Color(0xFF003539),
                        textColor: const Color(0xFFAFEE00),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'Invite Friends',
                        onPressed: () {
                          // TODO: Implement functionality to invite friends and earn bonus points
                        },
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF003539),
                        icon: Icons.person_add,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Points History Section
                Row(
                  children: [
                    const Text(
                      'Points History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: '2024',
                      onChanged: (String? newValue) {
                        // Handle year selection
                      },
                      items: <String>['2024', '2023', '2022', '2021']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Points History List
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: const Text(
                      'Recycle Waste',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Earned 100 Points'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF003539),
                    ),
                    onTap: () {
                      // Handle tap for more details
                    },
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: const Text(
                      'Participation in "Waste Recycling" Event',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Earned 500 Points'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF003539),
                    ),
                    onTap: () {
                      // Handle tap for more details
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Footer
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Want more points? Try new challenges or share Wastego with your friends!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
