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
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
