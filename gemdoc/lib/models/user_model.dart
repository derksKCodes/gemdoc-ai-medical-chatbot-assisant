/// A model class that represents a user in the app.
class UserModel {
  final String uid; // Unique ID (e.g., from Firebase Auth)
  final String? email; // User's email address
  final String? name; // User's full name
  final String? profileUrl; // Profile photo URL
  final DateTime? createdAt; // Account creation date

  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.profileUrl,
    this.createdAt,
  });

  /// Factory method to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      email: data['email'],
      name: data['name'],
      profileUrl: data['profileUrl'],
      createdAt: data['createdAt']?.toDate(),
    );
  }

  /// Convert the user model to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'profileUrl': profileUrl,
      'createdAt': createdAt,
    };
  }

  /// Create a UserModel from a JSON map (for local storage)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      profileUrl: json['profileUrl'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  /// Convert the user model to JSON map (for local storage)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileUrl': profileUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
