/// A model class representing a chat message in the app
class ChatMessage {
  final String text; // Content of the message
  final String sender; // Who sent the message: 'user' or 'ai'
  final DateTime timestamp; // Time when the message was sent

  /// Constructor for a chat message
  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}
