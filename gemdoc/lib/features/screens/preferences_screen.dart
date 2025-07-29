import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = false;
  bool hydrationReminder = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('dark_mode') ?? false;
      notificationsEnabled = prefs.getBool('notifications') ?? false;
      hydrationReminder = prefs.getBool('hydration_reminder') ?? false;
    });
  }

  Future<void> _updatePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _toggle(String key, bool value) {
    setState(() {
      if (key == 'dark_mode') isDarkMode = value;
      if (key == 'notifications') notificationsEnabled = value;
      if (key == 'hydration_reminder') hydrationReminder = value;
    });
    _updatePreference(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferences')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('🌙 Dark Mode'),
            value: isDarkMode,
            onChanged: (value) => _toggle('dark_mode', value),
          ),
          SwitchListTile(
            title: const Text('🔔 Notifications'),
            value: notificationsEnabled,
            onChanged: (value) => _toggle('notifications', value),
          ),
          SwitchListTile(
            title: const Text('💧 Hydration Reminder'),
            value: hydrationReminder,
            onChanged: (value) => _toggle('hydration_reminder', value),
          ),
        ],
      ),
    );
  }
}
