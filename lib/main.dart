import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:wastego/routes/app_routes.dart';
import 'package:wastego/core/providers/auth_provider.dart';
import 'package:wastego/core/providers/schedule_provider.dart';
import 'package:wastego/core/providers/event_provider.dart';
import 'package:wastego/core/providers/notification_provider.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ),
//   );

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => ScheduleProvider()),
//         ChangeNotifierProvider(create: (_) => EventProvider()),
//         ChangeNotifierProvider(create: (_) => NotificationProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.onboarding,
//       onGenerateRoute: AppRoutes.generateRoute,
//       theme: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//         primarySwatch: Colors.green,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//         ),
//       ),
//     );
//   }
// }


import 'package:wastego/views/onboarding/onboarding_page_step2.dart';
void main() {
  // Menyesuaikan status bar & nav bar agar terlihat bersih
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WasteGo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: const OnboardingPageStep2(),
    );
  }
}
