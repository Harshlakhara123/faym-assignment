import 'package:flutter/material.dart';
import '../services/google_auth_service.dart';
import '../models/user_model.dart';
import 'manual_signup_screen.dart';
import 'user_details_screen.dart';

class SignupSelectionScreen extends StatelessWidget {
  final GoogleAuthService _authService = GoogleAuthService();

  SignupSelectionScreen({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final user = await _authService.signIn();
    if (user != null) {
      final userModel = UserModel(
        fullName: user.displayName,
        email: user.email,
        photoUrl: user.photoUrl,
        signupType: SignupType.google,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => UserDetailsScreen(user: userModel)),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Sign-In Failed or Cancelled")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome to Faym",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Google Button
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Continue with Google"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.grey),
                ),
                onPressed: () => _handleGoogleSignIn(context),
              ),

              const SizedBox(height: 20),

              // Manual Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ManualSignupScreen(),
                    ),
                  );
                },
                child: const Text("Sign up Manually"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
