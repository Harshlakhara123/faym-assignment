import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: user.photoUrl != null
                        ? NetworkImage(user.photoUrl!)
                        : null,
                    child: user.photoUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _buildRow(
                  "Signup Method",
                  user.signupType == SignupType.google ? "Google" : "Manual",
                ),
                const Divider(),
                _buildRow("Name", user.fullName ?? "N/A"),
                if (user.signupType == SignupType.google)
                  _buildRow("Email", user.email ?? "N/A"),
                if (user.signupType == SignupType.manual) ...[
                  _buildRow("Username", user.username ?? "N/A"),
                  _buildRow("Gender", user.gender ?? "N/A"),
                  _buildRow(
                    "DOB",
                    user.dob != null
                        ? DateFormat('yMMMd').format(user.dob!)
                        : "N/A",
                  ),
                  _buildRow("Instagram", user.instagramHandle ?? "N/A"),
                  _buildRow("YouTube", user.youtubeHandle ?? "N/A"),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
