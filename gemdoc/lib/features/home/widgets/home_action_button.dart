import 'package:flutter/material.dart';
import 'package:gemdoc/core/constants/app_colors.dart';

/// A custom floating action button for the home screen.
/// Displays a chat icon with a gradient background.
class HomeActionButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback function triggered on button press

  const HomeActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,              // Define the action when the button is tapped
      backgroundColor: AppColors.primary, // Base background color
      elevation: 4,                      // Shadow effect
      child: Container(
        width: 60,                       // Set fixed width
        height: 60,                      // Set fixed height
        decoration: BoxDecoration(
          shape: BoxShape.circle,        // Make the container circular
          gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 204),
              ],
            ),

        ),
        child: const Icon(              // Display a chat icon inside the button
          Icons.chat,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
