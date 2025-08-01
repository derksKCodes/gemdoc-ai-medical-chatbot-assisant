// Importing required Firebase packages for core functionality, authentication,
// push notifications, analytics tracking, and crash reporting.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class FirebaseService {
  // Firebase Auth instance for handling authentication.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase Messaging instance for push notifications.
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Firebase Analytics instance for tracking user behavior.
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Firebase Crashlytics instance for reporting uncaught errors and crashes.
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    // Ask the user for permission to receive push notifications
    await _messaging.requestPermission();

    // Retrieve the FCM device token (used for sending notifications to this device)
    final token = await _messaging.getToken();
    debugPrint('FCM Token: $token');  // For debugging purposes

    // Enable Firebase Analytics for user tracking
    await _analytics.setAnalyticsCollectionEnabled(true);

    // Enable Firebase Crashlytics to automatically report crashes and errors
    await _crashlytics.setCrashlyticsCollectionEnabled(true);

    // Hook into Flutter's error system and report uncaught errors to Crashlytics
    FlutterError.onError = _crashlytics.recordFlutterError;
  }

  // 🔧 You can extend this class by adding more Firebase methods
  // like signIn(), signOut(), logEvent(), etc.
}
