import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.inputType = TextInputType.text,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: inputType,
        onTap: onTap,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
