import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import for date formatting initialization
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:wastego/routes/app_routes.dart';
import 'package:wastego/core/providers/auth_provider.dart';
import 'package:wastego/core/providers/schedule_provider.dart';
import 'package:wastego/core/providers/event_provider.dart';
import 'package:wastego/core/providers/notification_provider.dart';
import 'package:wastego/core/services/api_service.dart';
import 'package:wastego/core/providers/profile_provider.dart';

/// Overrides SSL certificate checks for development/testing purposes only.
/// This allows the app to trust all certificates, even self-signed or invalid ones.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Accepts all certificates by returning true for badCertificateCallback.
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // Ensures that Flutter widgets are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Sets the global HttpOverrides to MyHttpOverrides,
  // enabling SSL certificate overriding for development.
  HttpOverrides.global = MyHttpOverrides();

  // Initializes the ApiService, which includes loading tokens from SharedPreferences.
  await ApiService.init();

  // Initialize date formatting for the 'id_ID' locale.
  await initializeDateFormatting('id_ID', null);

  // Sets the system UI overlay style (status bar and navigation bar colors and icon brightness).
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Runs the Flutter application with multiple providers.
  runApp(
    MultiProvider(
      providers: [
        // Provides AuthProvider for authentication state management.
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Provides ScheduleProvider for managing schedule-related data.
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        // Provides EventProvider for managing event-related data.
        ChangeNotifierProvider(create: (_) => EventProvider()),
        // Provides NotificationProvider for managing notifications.
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        // Provides ProfileProvider for managing user profile data.
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WasteGo App', // The title of the application.
      debugShowCheckedModeBanner: false, // Hides the debug banner.
      initialRoute: AppRoutes.onboarding, // Sets the initial route of the app.
      onGenerateRoute:
          AppRoutes.generateRoute, // Defines how routes are generated.
      theme: ThemeData(
        useMaterial3: true, // Enables Material 3 design.
        scaffoldBackgroundColor:
            Colors.white, // Sets the default background color for scaffolds.
        // Applies Google Fonts Poppins to the app's text theme.
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003539), // Primary color
          primary: const Color(0xFF003539),
          secondary: const Color(0xFFAFEE00), // Accent color
          // You might want to define other colors like surface, background, error, onPrimary, onSecondary etc.
          // For example:
          // surface: Colors.white,
          // onPrimary: Colors.white,
          // onSecondary: Colors.black, // For text/icons on accent color
        ),
        // primarySwatch is not needed if colorScheme is defined comprehensively
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Sets the app bar background color.
          foregroundColor:
              Colors
                  .black, // Sets the app bar foreground color (e.g., icons, text).
          elevation: 0, // Removes the shadow under the app bar.
          systemOverlayStyle:
              SystemUiOverlayStyle
                  .dark, // Sets the system overlay style for the app bar.
        ),
      ),
    );
  }
}
