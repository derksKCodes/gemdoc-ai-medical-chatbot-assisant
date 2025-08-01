import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  bool _isAuthenticated = false;
  bool _shouldShowOnboarding = true;

 // declare _userModel if you're using it elsewhere
  // UserModel? _userModel;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get shouldShowOnboarding => _shouldShowOnboarding;

  AuthProvider() {
    _init();
  }

  Future<void> fetchUserProfile() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    try {
      final doc = await _firestore.collection('users').doc(currentUser.uid).get();

      if (doc.exists) {
        // _userModel = UserModel.fromFirestore(doc.data()!, doc.id); // uncomment if needed
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
    }
  }

  // Initialize onboarding preference and auth listener
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _shouldShowOnboarding = prefs.getBool('showOnboarding') ?? true;

    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      _isAuthenticated = user != null;
      notifyListeners(); // Notify UI of change
    });
  }

  // Optional manual check of auth status
  Future<void> checkAuthStatus() async {
    _user = FirebaseAuth.instance.currentUser;
    _isAuthenticated = _user != null;
  }

  // Log in user with email and password
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e); // Convert Firebase error to readable string
    }
  }

  // Register new user and save info to Firestore
  Future<void> register(String email, String password, String name) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user profile to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Disable onboarding after successful registration
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('showOnboarding', false);
      _shouldShowOnboarding = false;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Log out current user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Update user profile in memory (for UI update only)
  Future<void> updateUserProfile({
  required String name,
  required String email,
  String? profileUrl,
}) async {
  final currentUser = _firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'name': name,
      'email': email,
      if (profileUrl != null) 'profileUrl': profileUrl,
    });

    // Update FirebaseAuth profile (optional)
    await currentUser.updateDisplayName(name);
    if (profileUrl != null) {
      await currentUser.updatePhotoURL(profileUrl);
    }

    // Sync updated user profile
    await fetchUserProfile();
  } catch (e) {
    debugPrint("Failed to update profile: $e");
  }
}


  // Delete the current user account from Firebase
  Future<void> deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      debugPrint('Account deletion failed: $e');

      // print('Account deletion failed: $e');
      rethrow;
    }
  }

  // Change user's password after re-authenticating
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        throw Exception('User not authenticated');
      }

      // Re-authenticate user before sensitive actions
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('Password change failed: $e');
    }
  }

  // Handle Firebase-specific errors with user-friendly messages
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'An error occurred. Please try again';
    }
  }
}
