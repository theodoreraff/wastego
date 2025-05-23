// import 'package:flutter/material.dart';
// import '../../widgets/custom_button.dart';
// import 'onboarding_page_step2.dart';
//
// class OnboardingPageStep1 extends StatefulWidget {
//   const OnboardingPageStep1({super.key});
//
//   @override
//   State<OnboardingPageStep1> createState() => _OnboardingPageStep1State();
// }
//
// class _OnboardingPageStep1State extends State<OnboardingPageStep1> {
//   // Controllers untuk input field
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//
//   // Variabel untuk dropdown kode negara
//   List<String> countryCodes = ['+62', '+1', '+44', '+81', '+91'];
//   String selectedCode = '+62';
//
//   // State
//   bool _agreeToTerms = false;
//   bool isLoading = false;
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   void _handleRegister() {
//     final firstName = _firstNameController.text.trim();
//     final lastName = _lastNameController.text.trim();
//     final phone = _phoneController.text.trim();
//
//     void _showError(String message) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(message)));
//     }
//
//     // Validasi nama depan
//     if (firstName.isEmpty) {
//       _showError('Nama depan tidak boleh kosong.');
//       return;
//     }
//     if (firstName.length > 30) {
//       _showError('Nama depan maksimal 30 karakter.');
//       return;
//     }
//
//     // Validasi nama belakang
//     if (lastName.isEmpty) {
//       _showError('Nama belakang tidak boleh kosong.');
//       return;
//     }
//     if (lastName.length > 30) {
//       _showError('Nama belakang maksimal 30 karakter.');
//       return;
//     }
//
//     // Validasi nomor telepon
//     if (phone.isEmpty) {
//       _showError('Nomor telepon tidak boleh kosong.');
//       return;
//     }
//     if (phone.contains(' ')) {
//       _showError('Nomor telepon tidak boleh mengandung spasi.');
//       return;
//     }
//     if (!RegExp(r'^\d+$').hasMatch(phone)) {
//       _showError('Nomor telepon hanya boleh berisi angka.');
//       return;
//     }
//     if (phone.length > 15) {
//       _showError('Nomor telepon maksimal 15 digit.');
//       return;
//     }
//
//     // Jika semua validasi lolos
//     setState(() => isLoading = true);
//
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() => isLoading = false);
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const OnboardingPageStep2()),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Nama Depan', style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         TextField(
//           controller: _firstNameController,
//           decoration: const InputDecoration(
//             hintText: 'Masukkan Nama Depan',
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.black),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 24),
//
//         const Text(
//           'Nama Belakang',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         TextField(
//           controller: _lastNameController,
//           decoration: const InputDecoration(
//             hintText: 'Masukkan Nama Belakang',
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.black),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 24),
//
//         const Text(
//           'Nomor Telepon',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             DropdownButton<String>(
//               value: selectedCode,
//               underline: const SizedBox(),
//               items:
//                   countryCodes.map((String code) {
//                     return DropdownMenuItem<String>(
//                       value: code,
//                       child: Text(code),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCode = value!;
//                 });
//               },
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   hintText: 'Masukkan Nomor Telepon',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 24),
//
//         const Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         Stack(
//           children: [
//             CustomButton(
//               text: 'Pilih Lokasi',
//               onPressed: () {},
//               backgroundColor: Colors.white,
//               textColor: const Color(0xFF003539),
//               borderColor: Colors.black,
//               borderWidth: 1.0,
//               elevation: 0,
//               textStyle: const TextStyle(
//                 color: Color(0xFF003539),
//                 fontWeight: FontWeight.normal,
//                 fontSize: 16,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 14),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Icon(Icons.chevron_right, color: Colors.black, size: 30),
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 10),
//
//         // Checkbox untuk syarat dan ketentuan
//         Row(
//           children: [
//             Checkbox(
//               value: _agreeToTerms,
//               onChanged: (value) {
//                 setState(() {
//                   _agreeToTerms = value ?? false;
//                 });
//               },
//             ),
//             const Text('Saya menyetujui syarat dan ketentuan'),
//           ],
//         ),
//
//         CustomButton(
//           text: 'Lanjut',
//           isLoading: isLoading,
//           onPressed: _agreeToTerms && !isLoading ? _handleRegister : null,
//         ),
//       ],
//     );
//   }
// }
