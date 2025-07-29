// Import necessary Flutter and project-specific packages
import 'package:flutter/material.dart';
import 'package:gemdoc/core/constants/app_colors.dart'; // (Unused here, can be removed)
import 'package:gemdoc/core/widgets/setting_tile.dart'; // Custom widget for each settings option
import 'package:provider/provider.dart'; // Used for accessing providers
import 'package:gemdoc/state/auth_provider.dart'; // Access user data and logout logic
import 'package:gemdoc/state/theme_provider.dart'; // Access and toggle theme (dark/light)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key}); // Stateless widget with a constant constructor

  @override
  Widget build(BuildContext context) {
    // Access AuthProvider to retrieve user info and logout
    final authProvider = Provider.of<AuthProvider>(context);
    // Access ThemeProvider to manage light/dark mode
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'), // App bar title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Outer padding for spacing
        child: Column(
          children: [
            // Profile Avatar Circle
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                // Use first letter of user’s name or fallback to 'U'
                authProvider.user?.name?.substring(0, 1) ?? 'U',
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Display user's full name or default
            Text(
              authProvider.user?.name ?? 'User',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Display user's email
            Text(
              authProvider.user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            // Card for general settings
            Card(
              child: Column(
                children: [
                  // Edit Profile option
                  SettingTile(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      //Implement edit profile
                       Navigator.pushNamed(context, '/edit-profile');
                    },
                  ),

                  // change password option
                  SettingTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      // Implement change password
                      Navigator.pushNamed(context, '/change-password');
                    },
                  ),

                  // delete account option
                  SettingTile(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    onTap: () {
                      // Implement delete account
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await authProvider.deleteAccount();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/auth',
                                  (route) => false,
                                );
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Notifications toggle (static true for now)
                  SettingTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Implement notification toggle
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Notification settings saved.')),
                        );
                      },
                    ),
                  ),
                  // Toggle for dark/light mode
                  SettingTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                    ),
                  ),
                  // Privacy policy link
                  SettingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      // Show privacy policy
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Privacy Policy'),
                          content: const Text('This is where your privacy policy details would be shown.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  // Help and support screen
                  SettingTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      // Show help screen
                       showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Help & Support'),
                          content: const Text('Contact support@gemdoc.health or visit our Help Center.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card for health-related settings
            Card(
              child: Column(
                children: [
                  // Emergency contacts section
                  SettingTile(
                    icon: Icons.medical_services_outlined,
                    title: 'Emergency Contacts',
                    onTap: () {
                      // Show emergency contacts
                      Navigator.pushNamed(context, '/emergency-contacts');
                    },
                  ),
                  // Hydration reminder toggle (static true for now)
                  SettingTile(
                    icon: Icons.water_drop_outlined,
                    title: 'Hydration Reminders',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Implement hydration reminders
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(value
                                ? 'Hydration reminders enabled.'
                                : 'Hydration reminders disabled.'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  // Log out the user
                  await authProvider.logout();
                  // Redirect to auth screen
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/auth',
                      (route) => false,
                    );
                  }
                },
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
