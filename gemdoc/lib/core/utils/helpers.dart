import 'package:intl/intl.dart';

class Helpers {
  /// Formats a DateTime object into a human-readable date string, e.g., "Jul 29, 2025"
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Formats a DateTime object into a 24-hour time string, e.g., "14:30"
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  /// Capitalizes the first letter of the given string.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
