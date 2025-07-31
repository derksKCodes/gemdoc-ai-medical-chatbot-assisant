import 'package:flutter/foundation.dart';
import 'package:gemdoc/models/chat_message.dart';
import 'package:gemdoc/core/services/gemini_service.dart';

/// A provider for managing chat state, messages, and AI interaction
class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = []; // Stores chat messages
  bool _isTyping = false; // Tracks if the AI is "typing" a response

  List<ChatMessage> get messages => _messages; // Exposes messages to UI
  bool get isTyping => _isTyping; // Exposes typing status to UI

  final GeminiService _geminiService; // Handles communication with Gemini API

  /// Constructor requires a GeminiService instance (dependency injection)
  ChatProvider({required GeminiService geminiService}) 
      : _geminiService = geminiService;

  /// Adds a new message to the list and notifies listeners (UI updates)
  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  /// Sends user's message to AI and gets a health response
  Future<void> getAIResponse(String userMessage) async {
    _isTyping = true;
    notifyListeners();

    try {
      final aiResponse = await _geminiService.getHealthResponse(userMessage);

      // Add AI's response to chat
      addMessage(ChatMessage(
        text: aiResponse,
        sender: 'ai',
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      // Handle error gracefully
      addMessage(ChatMessage(
        text: 'Sorry, I encountered an error. Please try again.',
        sender: 'ai',
        timestamp: DateTime.now(),
      ));
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  /// Sends symptom input to AI and gets an analysis back
  Future<void> getSymptomAnalysis(String symptoms) async {
    _isTyping = true;
    notifyListeners();

    try {
      final analysis = await _geminiService.getHealthResponse(
        "Analyze these symptoms: $symptoms. Provide possible causes and when to see a doctor."
      );

      // Add AI's symptom analysis to chat
      addMessage(ChatMessage(
        text: analysis,
        sender: 'ai',
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      // Handle error gracefully
      addMessage(ChatMessage(
        text: 'Failed to analyze symptoms. Please try again.',
        sender: 'ai',
        timestamp: DateTime.now(),
      ));
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }
}
