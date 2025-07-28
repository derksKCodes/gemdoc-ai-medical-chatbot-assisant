// features/symptom_checker/symptom_checker_screen.dart
import 'package:flutter/material.dart';
import 'package:gemdoc/core/constants/app_colors.dart';
import 'package:gemdoc/core/widgets/custom_text_field.dart';
import 'package:gemdoc/state/chat_provider.dart';
import 'package:provider/provider.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  final List<String> _selectedSymptoms = [];
  bool _isLoading = false;

  final List<String> _commonSymptoms = [
    'Headache',
    'Fever',
    'Cough',
    'Fatigue',
    'Nausea',
    'Dizziness',
    'Sore throat',
    'Shortness of breath',
    'Muscle pain',
    'Diarrhea',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Describe your symptoms',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your symptoms below or select from common symptoms',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _symptomsController,
              label: 'Symptoms',
              hintText: 'e.g., headache, fever, nausea',
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Text(
              'Common Symptoms',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _commonSymptoms.map((symptom) {
                final isSelected = _selectedSymptoms.contains(symptom);
                return FilterChip(
                  label: Text(symptom),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSymptoms.add(symptom);
                      } else {
                        _selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _analyzeSymptoms,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Check Symptoms'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Note: This is not a substitute for professional medical advice. Always consult a doctor for serious symptoms.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _analyzeSymptoms() async {
    if (_symptomsController.text.isEmpty && _selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe or select at least one symptom')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      
      String symptoms = '';
      if (_selectedSymptoms.isNotEmpty) {
        symptoms += 'Selected symptoms: ${_selectedSymptoms.join(', ')}. ';
      }
      if (_symptomsController.text.isNotEmpty) {
        symptoms += 'Additional details: ${_symptomsController.text}';
      }

      // Get AI analysis
      await chatProvider.getSymptomAnalysis(symptoms.trim());
      
      // Navigate back to chat with the analysis
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to analyze symptoms. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}