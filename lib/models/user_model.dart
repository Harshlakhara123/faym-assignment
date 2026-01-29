enum SignupType { google, manual }

class UserModel {
  final String? fullName;
  final String? email; // For Google
  final String? username;
  final DateTime? dob;
  final String? gender;
  final String? instagramHandle;
  final String? youtubeHandle;
  final String? photoUrl; // For Google
  final SignupType signupType;

  UserModel({
    this.fullName,
    this.email,
    this.username,
    this.dob,
    this.gender,
    this.instagramHandle,
    this.youtubeHandle,
    this.photoUrl,
    required this.signupType,
  });
}
