// import 'package:flutter/material.dart';
// import '../../../core/services/api_service.dart';
// import '../../../widgets/custom_button.dart';
//
// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});
//
//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final emailController = TextEditingController();
//   bool isLoading = false;
//
//   bool _isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
//     return emailRegex.hasMatch(email);
//   }
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
//   Future<void> handleSendOtp() async {
//     final email = emailController.text.trim();
//
//     if (email.isEmpty) {
//       _showMessage('Email tidak boleh kosong.');
//       return;
//     }
//     if (!_isValidEmail(email)) {
//       _showMessage('Format email tidak valid.');
//       return;
//     }
//
//     setState(() => isLoading = true);
//     try {
//       await ApiService.forgotPassword(email);
//       _showMessage('OTP berhasil dikirim ke email.', isError: false);
//
//       // Bisa navigate ke halaman berikutnya, misal verifikasi OTP
//       // Navigator.pushNamed(context, '/verify-otp');
//
//     } catch (e) {
//       _showMessage(e.toString());
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lupa Password'),
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
//             const Text(
//               'Masukkan email yang terkait dengan akunmu, kami akan mengirim OTP untuk reset password.',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//             const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 hintText: 'contoh@email.com',
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
//               text: 'Kirim OTP',
//               isLoading: isLoading,
//               onPressed: isLoading ? null : handleSendOtp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
