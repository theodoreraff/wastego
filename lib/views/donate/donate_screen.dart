import 'package:flutter/material.dart';
import 'package:wastego/core/models/donate_model.dart';
import 'package:wastego/views/donate/detail_donate_screen.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  String selectedStatus = 'Ongoing';

  @override
  Widget build(BuildContext context) {
    List<Donate> filteredDonateList =
        donateList.where((donate) => donate.status == selectedStatus).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            const Text(
              "Donate",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: filteredDonateList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/undraw_environment_iaus.png',
                          height: 120,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: buildRichText(
                            'Kita dapat membuat Bumi menjadi tempat yang lebih baik, satu tindakan satu waktu',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Our Campaigns',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedStatus,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: const SizedBox(),
                          items:
                              ['Ongoing', 'Completed', 'Upcoming'].map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStatus = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              final Donate donate = filteredDonateList[index - 1];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DetailDonateScreen(donateItem: donate),
                    ),
                  );
                },
                child: listItem(donate),
              );
            }
          },
        ),
      ),
    );
  }

  TextSpan buildRichText(String text) {
    return TextSpan(
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 32, 170, 36),
      ),
      children: [
        buildTextSpan('Kita dapat membuat ', Colors.black),
        buildTextSpan('Bumi', Color(0xFF319F43)),
        buildTextSpan(' menjadi tempat yang lebih ', Colors.black),
        buildTextSpan('baik ', Color(0xFFFF6584)),
        buildTextSpan(', ', Colors.black),
        buildTextSpan('satu ', Color(0xFFFF6584)),
        buildTextSpan('tindakan satu ', Colors.black),
        buildTextSpan('waktu', Color(0xFFFF6584)),
      ],
    );
  }

  TextSpan buildTextSpan(String text, Color color) {
    return TextSpan(text: text, style: TextStyle(color: color));
  }
}

Widget listItem(Donate donateItem) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(donateItem.imageAsset),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              right: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  donateItem.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  donateItem.titleDescription,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
