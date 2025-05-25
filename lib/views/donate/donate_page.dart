import 'package:flutter/material.dart';
import 'package:wastego/core/models/donate_model.dart';
import 'package:wastego/views/donate/detail_donate.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String selectedStatus = 'Ongoing';

  @override
  Widget build(BuildContext context) {
    List<Donate> filteredDonateList =
        donateList.where((donate) => donate.status == selectedStatus).toList();

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
          'Donasi',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount:
              filteredDonateList.isEmpty ? 1 : filteredDonateList.length + 1,
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
                        'Kampanye Kami',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 140,
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
                                      fontSize: 16,

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
                  if (filteredDonateList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "Tidak ada kampanye yang tersedia",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  donateItem.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  donateItem.titleDescription,
                  style: const TextStyle(
                    fontSize: 12,

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
