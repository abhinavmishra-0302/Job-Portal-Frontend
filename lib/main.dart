// main.dart
import 'package:flutter/material.dart';
import './screens/splash_screen.dart'; // Import the splash screen
import './screens/home_screen.dart'; // Import your main home screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoading ? const SplashScreen() : const HomeScreen(), // Show splash screen or main screen
      // home: SignUpPage(),
    );
  }
}
