import 'package:flutter/material.dart';
import 'package:wastego/views/auth/login_page.dart';
import 'package:wastego/views/auth/register_page.dart';
import 'package:wastego/views/auth/forgot_password_page.dart';
import 'package:wastego/views/auth/otp_verification_page.dart';
import 'package:wastego/views/auth/reset_password_page.dart';
import 'package:wastego/views/home/home_page.dart';
import 'package:wastego/views/schedule/schedule_page.dart';
import 'package:wastego/views/recycle/recycle_page.dart';
import 'package:wastego/views/events/events_page.dart';
import 'package:wastego/views/donate/donate_page.dart';
import 'package:wastego/views/blog/blog_page.dart';
import 'package:wastego/views/tips/tips_page.dart';
import 'package:wastego/views/more/more_page.dart';
import 'package:wastego/views/settings/profile_page.dart';
import 'package:wastego/views/notification/notification_page.dart';
import 'package:wastego/views/support/help_page.dart';
import 'package:wastego/views/poin/poin_page.dart';
import 'package:wastego/views/onboarding/onboarding_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/verify-otp';
  static const String resetPassword = '/reset-password';
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
  static const String onboardingStep1 = '/onboardingStep1';
  static const String onboardingStep2 = '/onboardingStep2';
  static const String onboardingScreen1 = '/onboardingScreen1';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case otpVerification:
        // Reverted to original assumption: OtpVerificationPage handles its own argument retrieval
        // or is pushed with arguments directly if needed.
        // If it requires 'email' to be passed via named routes, its constructor and this case
        // would need to be adapted similar to ResetPasswordPage.
        return MaterialPageRoute(builder: (_) => OtpVerificationPage());

      case resetPassword:
        // Rolling back: ResetPasswordPage will be deleted.
        // Navigating to LoginPage as a fallback if this route is somehow still called.
        // Consider removing the AppRoutes.resetPassword constant if it's no longer used.
        return MaterialPageRoute(builder: (_) => const LoginPage());

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
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case help:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case points:
        return MaterialPageRoute(builder: (_) => const PointsPage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case onboardingStep1:
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
