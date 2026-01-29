import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/swipe_button.dart';
import 'user_details_screen.dart';

class ManualSignupScreen extends StatefulWidget {
  const ManualSignupScreen({super.key});

  @override
  State<ManualSignupScreen> createState() => _ManualSignupScreenState();
}

class _ManualSignupScreenState extends State<ManualSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();
  final _instaController = TextEditingController();
  final _ytController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGender;
  bool _isFormValid = false;

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();
    // Listen to changes to enable/disable button
    _nameController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
    _instaController.addListener(_validateForm);
    _ytController.addListener(_validateForm);
  }

  // --- VALIDATION LOGIC ---
  void _validateForm() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    // Extra checks that formField validator might miss if not interacted with
    bool genderCheck = _selectedGender != null;
    bool dobCheck =
        _selectedDate != null && _calculateAge(_selectedDate!) >= 13;

    setState(() {
      _isFormValid = isValid && genderCheck && dobCheck;
    });
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 13)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      _validateForm();
    }
  }

  void _submitSignup() {
    if (_isFormValid) {
      final user = UserModel(
        fullName: _nameController.text,
        username: _usernameController.text,
        dob: _selectedDate,
        gender: _selectedGender,
        instagramHandle: _instaController.text,
        youtubeHandle: _ytController.text,
        signupType: SignupType.manual,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => UserDetailsScreen(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manual Signup")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          onChanged: _validateForm, // Checks validation on every keystroke
          child: Column(
            children: [
              CustomTextField(
                label: "Full Name",
                controller: _nameController,
                validator: (v) => v!.isEmpty ? "Name is required" : null,
              ),
              CustomTextField(
                label: "Username (min 3 chars)",
                controller: _usernameController,
                validator: (v) => (v != null && v.length < 3)
                    ? "Minimum 3 characters required"
                    : null,
              ),
              CustomTextField(
                label: "Date of Birth",
                controller: _dobController,
                readOnly: true,
                onTap: _pickDate,
                validator: (v) {
                  if (v!.isEmpty) return "DOB is required";
                  if (_selectedDate != null &&
                      _calculateAge(_selectedDate!) < 13) {
                    return "You must be at least 13 years old";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                items: _genders
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) {
                  setState(() => _selectedGender = val);
                  _validateForm();
                },
                validator: (v) => v == null ? "Gender is required" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: "Instagram Handle",
                controller: _instaController,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              CustomTextField(
                label: "YouTube Handle",
                controller: _ytController,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 40),
              Center(
                child: SwipeButton(
                  isEnabled: _isFormValid,
                  onSwipeComplete: _submitSignup,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
