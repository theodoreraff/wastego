import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import 'onboarding_page_step2.dart';

class OnboardingPageStep1 extends StatefulWidget {
  const OnboardingPageStep1({super.key});

  @override
  State<OnboardingPageStep1> createState() => _OnboardingPageStep1State();
}

class _OnboardingPageStep1State extends State<OnboardingPageStep1> {
  List<String> countryCodes = ['+62', '+1', '+44', '+81', '+91'];
  String selectedCode = '+62';

  bool isLoading = false;

  void _handleRegister() {
  setState(() {
    isLoading = true;
  });

  Future.delayed(const Duration(seconds: 1), () {
    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPageStep2()),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nama Depan', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Masukkan Nama Depan',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Nama Belakang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Masukkan Nama Belakang',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Nomor Telepon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            DropdownButton<String>(
              value: selectedCode,
              underline: const SizedBox(), // hilangkan garis bawah default
              items:
                  countryCodes.map((String code) {
                    return DropdownMenuItem<String>(
                      value: code,
                      child: Text(code),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCode = value!;
                });
              },
            ),

            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Masukkan Nomor Telepon',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        const Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),

        Stack(
          children: [
            CustomButton(
              text: 'Pilih Lokasi',
              onPressed: () {},
              backgroundColor: Colors.white,
              textColor: Color(0xFF003539),
              borderColor: Colors.black,
              borderWidth: 1.0,
              elevation: 0,
              textStyle: const TextStyle(
                color: Color(0xFF003539),
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right, color: Colors.black, size: 30),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        CustomButton(
          text: 'Lanjut',
          isLoading: isLoading,
          onPressed: !isLoading ? _handleRegister : null,
        ),
      ],
    );
  }
}
