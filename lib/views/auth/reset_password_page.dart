// import 'package:flutter/material.dart';
// import '../../../core/services/api_service.dart';
// import '../../../widgets/custom_button.dart';
//
// class ResetPasswordPage extends StatefulWidget {
//   final String email;
//   final String otp;
//
//   const ResetPasswordPage({
//     super.key,
//     required this.email,
//     required this.otp,
//   });
//
//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }
//
// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool isLoading = false;
//   bool isPasswordVisible = false;
//   bool isConfirmPasswordVisible = false;
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
//   bool _validatePassword(String password) {
//     if (password.isEmpty) {
//       _showMessage('Password tidak boleh kosong.');
//       return false;
//     }
//     if (password.length < 6) {
//       _showMessage('Password minimal 6 karakter.');
//       return false;
//     }
//     if (password.contains(' ')) {
//       _showMessage('Password tidak boleh mengandung spasi.');
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> handleResetPassword() async {
//     final password = passwordController.text;
//     final confirmPassword = confirmPasswordController.text;
//
//     if (!_validatePassword(password)) return;
//     if (password != confirmPassword) {
//       _showMessage('Password dan konfirmasi tidak sama.');
//       return;
//     }
//
//     setState(() => isLoading = true);
//
//     try {
//       await ApiService.resetPassword(
//         email: widget.email,
//         otp: widget.otp,
//         newPassword: password,
//       );
//       _showMessage('Password berhasil direset.', isError: false);
//
//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.popUntil(context, (route) => route.isFirst);
//         Navigator.pushReplacementNamed(context, '/'); // kembali ke login
//       });
//     } catch (e) {
//       _showMessage(e.toString());
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reset Password'),
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
//               'Masukkan password baru untuk akun Anda.',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//
//             const Text('Password Baru', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: passwordController,
//               obscureText: !isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: 'Masukkan Password Baru',
//                 enabledBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//             const Text('Konfirmasi Password', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: confirmPasswordController,
//               obscureText: !isConfirmPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: 'Konfirmasi Password',
//                 enabledBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 32),
//             CustomButton(
//               text: 'Reset Password',
//               isLoading: isLoading,
//               onPressed: isLoading ? null : handleResetPassword,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
