import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wastego/routes/app_routes.dart';
import 'package:wastego/core/providers/auth_provider.dart';
import 'package:wastego/core/providers/schedule_provider.dart';
import 'package:wastego/core/providers/event_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.register,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
