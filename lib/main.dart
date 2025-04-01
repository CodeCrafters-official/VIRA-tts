import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(VIRAApp());
}

class VIRAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIRA',
      theme: ThemeData(
        primaryColor: Colors.purple, // Primary purple color
        scaffoldBackgroundColor: Colors.purple[50], // Light purple background
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.deepPurple, // Darker shade for contrast
        ),
      ),
      home: LoginScreen(),
    );
  }
}
