import 'package:flutter/material.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home/home_screen.dart';
import '../views/schedule/schedule_page.dart';
import '../views/recycle/recycle_page.dart';
import '../views/events/events_page.dart';
import '../views/donate/donate_screen.dart';
import '../views/blog/blog_screen.dart';
import '../views/tips/tips_screen.dart';
import '../views/more/more_page.dart';
import '../views/settings/profile_page.dart';
import '../views/notification/notification_page.dart';
import '../views/support/help_page.dart';
import '../views/poin/poin_page.dart';

class AppRoutes {
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
  static const String profile = 'profile_page.dart';
  static const String notification = '/notification';
  static const String help = '/help';
  static const String points = '/points';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case schedule:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case recycle:
        return MaterialPageRoute(builder: (_) => const RecyclePage());
      case events:
        return MaterialPageRoute(builder: (_) => EventsPage());
      case donate:
        return MaterialPageRoute(builder: (_) => const DonateScreen());
      case blog:
        return MaterialPageRoute(builder: (_) => const BlogScreen());
      case tips:
        return MaterialPageRoute(builder: (_) => const TipsScreen());
      case more:
        return MaterialPageRoute(builder: (_) => const MoreScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case help:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case points:
        return MaterialPageRoute(builder: (_) => const PointsPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
