import 'package:flutter/material.dart';

/// A widget representing a single onboarding screen with an image, title, and description.
class OnboardingPage extends StatelessWidget {
  final String imagePath;    // Path to the onboarding image asset.
  final String title;        // Title text displayed on the screen.
  final String description;  // Description text displayed below the title.

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0), // Adds spacing around the content.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the content.
        children: [
          Image.asset(
            imagePath, // Displays the onboarding image.
            height: 250,
            fit: BoxFit.contain, // Ensures the image fits within its bounds.
          ),
          const SizedBox(height: 32), // Adds vertical spacing.
          Text(
            title, // Displays the onboarding title.
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, // Makes the title bold.
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16), // Adds vertical spacing.
          Text(
            description, // Displays the description below the title.
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
