import 'package:flutter/material.dart';

import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/home/home_page.dart';
import '../views/schedule/schedule_page.dart';
import '../views/recycle/recycle_page.dart';
import '../views/events/events_page.dart';
import '../views/donate/donate_page.dart';
import '../views/blog/blog_page.dart';
import '../views/tips/tips_page.dart';
import '../views/more/more_page.dart';
import '../views/settings/profile_page.dart';
import '../views/notification/notification_page.dart';
import '../views/support/help_page.dart';
import '../views/poin/poin_page.dart';
import '../views/onboarding/onboarding_page.dart';
import '../views/splash/splash_page.dart';

class AppRoutes {
  static const String splash = '/splash'; // Menambahkan route splash
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String schedule = '/schedule';
  static const String recycle = '/recycle';
  static const String events = '/events';
  static const String donate = '/donate';
  static const String blog = '/blog';
  static const String tips = '/tips';
  static const String more = '/more';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String help = '/help';
  static const String points = '/points';
  static const String onboarding = '/onboarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashPage()); // Menambahkan SplashPage route
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case schedule:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case recycle:
        return MaterialPageRoute(builder: (_) => const RecyclePage());
      case events:
        return MaterialPageRoute(builder: (_) => EventsPage());
      case donate:
        return MaterialPageRoute(builder: (_) => const DonatePage());
      case blog:
        return MaterialPageRoute(builder: (_) => const BlogPage());
      case tips:
        return MaterialPageRoute(builder: (_) => const TipsPage());
      case more:
        return MaterialPageRoute(builder: (_) => const MorePage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case help:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case points:
        return MaterialPageRoute(builder: (_) => const PointsPage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
