import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> locations = [
    'Area 1',
    'Area 2',
    'Area 3',
    'Area 4',
    'Area 5',
  ];

  String? selectedLocation;
  XFile? profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        profileImage = image;
      });
    }
  }

  int currentStep = 1;

  void goToNextStep() {
    setState(() {
      currentStep = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentStep == 1 ? buildStepOne() : buildStepTwo(),
      ),
    );
  }

  Widget buildStepOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset('assets/images/logotext.png', height: 100)),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nama Depan',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nama Belakang',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nomor Telepon',
            prefixText: '+62 ',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Alamat'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: selectedLocation,
          hint: const Text('Pilih Lokasi'),
          onChanged: (value) {
            setState(() {
              selectedLocation = value;
            });
          },
          items:
              locations.map((location) {
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: goToNextStep,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Lanjut'),
          ),
        ),
      ],
    );
  }

  Widget buildStepTwo() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage:
                profileImage != null
                    ? FileImage(File(profileImage!.path))
                    : null,
            child:
                profileImage == null
                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                    : null,
          ),
          const SizedBox(height: 16),
          const Text('Your Profile Picture'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: const Text('Choose Existing Picture'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            child: const Text('Take a Picture'),
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: () {}, child: const Text('Skip')),
        ],
      ),
    );
  }
}
