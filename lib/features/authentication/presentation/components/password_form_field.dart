import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

class PasswordFormatField extends StatefulWidget {
  const PasswordFormatField({
    super.key,
    required this.controller,
    required this.fKey,
    required this.label,
    this.validator,
    this.obscure = false,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> fKey;
  final String label;
  final String? Function(String?)? validator;
  final bool obscure;

  @override
  State<PasswordFormatField> createState() => _PasswordFormatFieldState();
}

class _PasswordFormatFieldState extends State<PasswordFormatField> {
  bool _obscureText = true;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: widget.fKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: widget.label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                errorText: _passwordError,
              ),
              validator: widget.validator,
              onChanged: (value) {
                setState(() {
                  _passwordError = widget.validator?.call(value);
                });
              },
            ),
            const SizedBox(height: 10),
            StreamBuilder<String>(
              stream: widget.controller.text.isNotEmpty
                  ? Stream.value(widget.controller.text)
                  : Stream.empty(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final strength = estimatePasswordStrength(snapshot.data!);
                  return LinearProgressIndicator(
                    value: strength,
                    backgroundColor: Colors.red,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      strength > 0.7
                          ? Colors.green
                          : strength > 0.4
                          ? Colors.yellow
                          : Colors.red,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
