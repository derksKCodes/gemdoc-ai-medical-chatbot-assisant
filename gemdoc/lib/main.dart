import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gemdoc/core/constants/app_colors.dart';
import 'package:gemdoc/features/auth/auth_screen.dart';
import 'package:gemdoc/features/onboarding/onboarding_screen.dart';
import 'package:gemdoc/state/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:gemdoc/core/routes/app_routes.dart';
import 'package:gemdoc/features/home/home_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    runApp(const FirebaseErrorApp());
  }
}
class FirebaseErrorApp extends StatelessWidget {
  const FirebaseErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Failed to initialize Firebase")),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers as needed
      ],
      child: MaterialApp(
        title: 'GemDoc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        routes: AppRoutes.getRoutes(), // <- Use separated routes
        home: const AppWrapper(),
      ),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return FutureBuilder(
      future: authProvider.checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          if (authProvider.isAuthenticated) {
            return const HomeScreen();
          } else {
            if (authProvider.shouldShowOnboarding) {
              return const OnboardingScreen();
            } else {
              return const AuthScreen();
            }
          }
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
            // errorBuilder: (context, error, stackTrace) {
            //   return const Icon(Icons.health_and_safety, size: 100, color: Colors.white);
            // },
          ],
        ),
      ),
    );
  }
}