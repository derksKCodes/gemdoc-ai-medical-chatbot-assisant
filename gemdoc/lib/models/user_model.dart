/// A model class that represents a user in the app.
class UserModel {
  final String uid; // Unique ID of the user (usually from Firebase Auth)
  final String? email; // Optional email address
  final String? name; // Optional name
  final DateTime? createdAt; // Optional account creation date

  /// Constructor for creating a user model instance
  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.createdAt,
  });

  /// Factory method to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      email: data['email'],
      name: data['name'],
      createdAt: data['createdAt']?.toDate(), // Convert Timestamp to DateTime
    );
  }

  /// Convert the user model to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
