import 'package:flutter/material.dart';

class TextFromatField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final GlobalKey<FormState> fKey;
  final String? Function(String?)? validator;

  const TextFromatField({
    super.key,
    required this.controller,
    required this.label,
    required this.fKey,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: fKey,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
