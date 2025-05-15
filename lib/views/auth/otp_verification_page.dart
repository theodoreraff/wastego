// import 'package:flutter/material.dart';
// import '../../../core/services/api_service.dart';
// import '../../../widgets/custom_button.dart';
//
// class OtpVerificationPage extends StatefulWidget {
//   final String email;
//   const OtpVerificationPage({super.key, required this.email});
//
//   @override
//   State<OtpVerificationPage> createState() => _OtpVerificationPageState();
// }
//
// class _OtpVerificationPageState extends State<OtpVerificationPage> {
//   final otpController = TextEditingController();
//   bool isLoading = false;
//
//   void _showMessage(String message, {bool isError = true}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
//
//   Future<void> handleVerifyOtp() async {
//     final otp = otpController.text.trim();
//
//     if (otp.isEmpty) {
//       _showMessage('OTP tidak boleh kosong.');
//       return;
//     }
//
//     if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
//       _showMessage('OTP harus terdiri dari 6 digit angka.');
//       return;
//     }
//
//     setState(() => isLoading = true);
//     try {
//       await ApiService.verifyOtp(widget.email, otp);
//       _showMessage('OTP berhasil diverifikasi.', isError: false);
//
//       // Navigasi ke halaman reset password
//       Navigator.pushNamed(
//         context,
//         '/reset-password',
//         arguments: {
//           'email': widget.email,
//           'otp': otp,
//         },
//       );
//     } catch (e) {
//       _showMessage(e.toString());
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verifikasi OTP'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Masukkan kode OTP yang telah dikirim ke ${widget.email}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//             const Text('Kode OTP', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//               decoration: const InputDecoration(
//                 hintText: '123456',
//                 counterText: '',
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//             CustomButton(
//               text: 'Verifikasi',
//               isLoading: isLoading,
//               onPressed: isLoading ? null : handleVerifyOtp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
