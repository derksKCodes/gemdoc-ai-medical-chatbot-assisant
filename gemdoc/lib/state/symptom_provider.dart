import 'package:flutter/foundation.dart';

/// A provider to manage the state of selected symptoms in the app.
class SymptomProvider with ChangeNotifier {
  // Internal list to keep track of selected symptoms
  final List<String> _selectedSymptoms = [];

  /// Public getter to access the selected symptoms
  List<String> get selectedSymptoms => _selectedSymptoms;

  /// Toggle a symptom:
  /// - If already selected, remove it.
  /// - If not selected, add it.
  void toggleSymptom(String symptom) {
    if (_selectedSymptoms.contains(symptom)) {
      _selectedSymptoms.remove(symptom);
    } else {
      _selectedSymptoms.add(symptom);
    }
    notifyListeners(); // Notify UI to update
  }

  /// Clear all selected symptoms
  void clearSymptoms() {
    _selectedSymptoms.clear();
    notifyListeners(); // Notify UI to update
  }
}
