import 'package:flutter/material.dart';

/// A reusable card widget for displaying a feature on the home screen.
/// Shows an icon inside a colored circle and a title below it.
class HomeFeatureCard extends StatelessWidget {
  final IconData icon;       // Icon to display in the card
  final String title;        // Title text shown under the icon
  final Color color;         // Color used for the icon background and icon itself
  final VoidCallback onTap;  // Function triggered when the card is tapped

  const HomeFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),  // Spacing around the card
      elevation: 2,                     // Shadow elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // Match the card radius for splash effect
        onTap: onTap,                            // Handle tap interaction
        child: Padding(
          padding: const EdgeInsets.all(16),     // Inner padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular icon container with soft background
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2), // Soft background using icon color
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28), // Main icon
              ),
              const SizedBox(height: 12), // Space between icon and title
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, // Emphasize title
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
