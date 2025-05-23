import 'package:flutter/material.dart';

/// A widget to display content for an onboarding screen.
///
/// This widget typically includes an image, a prominent title,
/// and a descriptive text, all centered on the screen.
class OnboardingContent extends StatelessWidget {
  /// The asset path to the image displayed on the onboarding slide.
  final String image;

  /// The main title text for the onboarding slide.
  final String title;

  /// The descriptive text providing more details about the onboarding slide.
  final String description;

  /// Creates an [OnboardingContent] widget.
  ///
  /// All parameters [image], [title], and [description] are required.
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centers the content vertically.
      children: [
        // Displays the image from the specified asset path.
        Image.asset(image, height: 250),
        const SizedBox(height: 30), // Provides vertical space.
        // Displays the title with a bold and large font.
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15), // Provides vertical space.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center, // Centers the description text.
            style: const TextStyle(fontSize: 16, color: Colors.black54), // Styles the description text.
          ),
        ),
      ],
    );
  }
}