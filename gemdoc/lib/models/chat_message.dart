/// A model class representing a chat message in the app.
class ChatMessage {
  final String text; // Message content
  final String sender; // 'user' or 'ai'
  final DateTime timestamp; // Time of sending

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  /// Create a ChatMessage from a JSON map (e.g., from local storage)
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      sender: json['sender'],
      timestamp: DateTime.tryParse(json['timestamp']) ?? DateTime.now(),
    );
  }

  /// Convert a ChatMessage to a JSON map (e.g., for local storage)
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
