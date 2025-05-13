import 'dart:async';
import 'package:flutter/material.dart'; // Ensure you import this
import 'package:wastego/core/services/storage_services.dart';
import 'package:wastego/routes/app_routes.dart';
import 'package:wastego/core/models/onboarding_model.dart';

class OnboardingController {
  final PageController pageController = PageController();
  int currentPage = 0;
  Timer? _autoSlideTimer;

  final List<OnboardingContent> onboardingItems = [
    OnboardingContent(
      image: 'assets/images/reuse.svg',
      title: 'REUSE',
      description: 'Utilise the product in different way possible',
    ),
    OnboardingContent(
      image: 'assets/images/reduce.svg',
      title: 'REDUCE',
      description: 'Minimise waste to reduce environmental impact',
    ),
    OnboardingContent(
      image: 'assets/images/recycle.svg',
      title: 'RECYCLE',
      description: 'Convert waste into reusable material',
    ),
  ];

  void startAutoSlide(BuildContext context) {
    _autoSlideTimer?.cancel(); // Clear if already started
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (pageController.hasClients) {
        if (currentPage < onboardingItems.length - 1) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          currentPage++;
        } else {
          _completeOnboarding(context);
        }
      }
    });
  }

  void updatePage(int index) {
    currentPage = index;
  }

  void completeOnboarding(BuildContext context) {
    _autoSlideTimer?.cancel();
    _completeOnboarding(context);
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    await StorageService.setOnboardingCompleted();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void dispose() {
    pageController.dispose();
    _autoSlideTimer?.cancel();
  }
}
