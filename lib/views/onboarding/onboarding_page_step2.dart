import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wastego/views/home/home_page.dart';
import '../../widgets/custom_button.dart';


class OnboardingPageStep2 extends StatefulWidget {
  const OnboardingPageStep2({super.key});

  @override
  State<OnboardingPageStep2> createState() => _OnboardingPageStep2State();
}

class _OnboardingPageStep2State extends State<OnboardingPageStep2> {
  List<String> countryCodes = ['+62', '+1', '+44', '+81', '+91'];
  String selectedCode = '+62';

  File? _pickedImage;
  bool isNextLoading = false;

  void _choosePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _next() {
    setState(() {
      isNextLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isNextLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 150),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipOval(
                    child:
                        _pickedImage != null
                            ? Image.file(
                              _pickedImage!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              'assets/images/profile.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),

                const SizedBox(height: 5),
                Center(
                  child: Text(
                    "Your Profile Picture",
                    style: TextStyle(fontSize: 18, color: Color(0xFF003539)),
                  ),
                ),
                const SizedBox(height: 15),

                CustomButton(
                  text: 'Pilih Foto Profil',
                  onPressed: _choosePicture,
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF003539),
                  borderColor: Colors.black,
                  borderWidth: 1.0,
                  elevation: 0,
                  textStyle: const TextStyle(
                    color: Color(0xFF003539),

                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),

                CustomButton(
                  text: 'Ambil Foto Profil',
                  onPressed: _takePicture,
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF003539),
                  borderColor: Colors.black,
                  borderWidth: 1.0,
                  elevation: 0,
                  textStyle: const TextStyle(
                    color: Color(0xFF003539),

                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),

                CustomButton(
                  text: 'Lewati',
                  isLoading: isNextLoading,
                  onPressed: !isNextLoading ? _next : null,
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF003539),
                  borderColor: Colors.black,
                  borderWidth: 1.0,
                  elevation: 0,
                  textStyle: const TextStyle(
                    color: Color(0xFF003539),

                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
