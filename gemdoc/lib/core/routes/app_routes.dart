import 'package:flutter/material.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/profile/emergency_contacts_screen.dart';
import '../../features/profile/change_password_screen.dart';
import '../../core/services/notification_service.dart';
import '../../features/home/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/home': (context) => const HomeScreen(),
      '/edit-profile': (context) => const EditProfileScreen(),
      '/emergency-contacts': (context) => const EmergencyContactsScreen(),
      '/change-password': (context) => const ChangePasswordScreen(),
      '/preferences': (context) => const PreferencesScreen(),
    };
  }
}
