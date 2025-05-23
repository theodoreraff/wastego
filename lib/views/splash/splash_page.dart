// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wastego/views/auth/login_page.dart';
// import 'package:wastego/views/onboarding/onboarding_page.dart';
// import 'package:wastego/views/home/home_page.dart';
//
// class SplashPage extends StatefulWidget {
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     _checkStatus();
//   }
//
//   Future<void> _checkStatus() async {
//     await Future.delayed(const Duration(seconds: 3)); // Delay splash
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
//
//     // Debug log
//     print('SplashPage: isLoggedIn = $isLoggedIn, hasCompletedOnboarding = $hasCompletedOnboarding');
//
//     if (isLoggedIn) {
//       if (hasCompletedOnboarding) {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
//       } else {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
//       }
//     } else {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
//     }
//   }
//
//   Future<void> _resetPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     print('SharedPreferences reset.');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Data reset. Restart app to test onboarding again.')),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/logo.png', width: 150),
//             const SizedBox(height: 20),
//             const CircularProgressIndicator(),
//             const SizedBox(height: 40),
//             // Tombol hanya untuk debugging
//             ElevatedButton(
//               onPressed: _resetPrefs,
//               child: const Text('Reset SharedPreferences'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
