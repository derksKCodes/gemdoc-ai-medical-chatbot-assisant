import 'dart:convert'; // Used for JSON encoding/decoding
import 'package:http/http.dart' as http; // HTTP package to make API calls

// Service class to handle communication with Gemini API
class GeminiService {
  final String apiKey; // Your Gemini API key
  final String baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  // Constructor requiring the API key
  GeminiService({required this.apiKey});

  /// Sends a health-related user prompt to Gemini API and returns the AI response
  Future<String> getHealthResponse(String prompt) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl?key=$apiKey'), // API endpoint with key
            headers: {'Content-Type': 'application/json'}, // Setting JSON content type
            body: jsonEncode({
              "contents": [
                {
                  "parts": [
                    {"text": _buildPrompt(prompt)} // Custom prompt creation
                  ]
                }
              ],
              "safetySettings": [
                {
                  "category": "HARM_CATEGORY_MEDICAL",
                  "threshold": "BLOCK_ONLY_HIGH" // Block only high-risk medical responses
                }
              ],
            }),
          )
          .timeout(const Duration(seconds: 10)); // Set a 10-second timeout

      // If request is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Parse response JSON
        final candidates = data['candidates'] as List?; // List of candidate responses
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content']; // Get first candidate's content
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] ?? 'No response generated.'; // Return the AI's text response
          }
        }
        return 'I couldn\'t generate a response. Please try again.'; // Fallback if empty
      } else {
        // Handle non-200 status code
        final error = jsonDecode(response.body);
        final message = error['error']?['message'] ?? 'Unknown error';
        throw Exception('Failed to get response from Gemini API: $message');
      }
    } catch (e) {
      // Catch timeout or network/JSON errors
      throw Exception('Error communicating with Gemini API: $e');
    }
  }

  /// Builds the full prompt sent to Gemini, including guidelines and the user message
  String _buildPrompt(String userPrompt) {
    return '''
You are GemDoc, an AI health assistant. Your role is to provide general health information, 
symptom analysis, and wellness advice. Always maintain a professional, empathetic tone.

Guidelines:
1. For medical questions, provide general information but always recommend consulting a doctor.
2. For serious symptoms (chest pain, difficulty breathing, etc.), advise immediate medical attention.
3. Never diagnose - only suggest possible conditions based on symptoms.
4. Always include a disclaimer that this is not professional medical advice.

Current conversation:
User: $userPrompt

Response:
''';
  }
}
