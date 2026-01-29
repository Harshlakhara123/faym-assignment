import 'package:flutter/material.dart';
import 'screens/signup_selection_screen.dart';

void main() {
  runApp(const FaymApp());
}

class FaymApp extends StatelessWidget {
  const FaymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faym Signup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: SignupSelectionScreen(),
    );
  }
}
