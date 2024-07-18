// lib/ui/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isDisable;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isDisable=true,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Only show the suffix icon (eye icon) for password fields
    return TextFormField(
      readOnly: !widget.isDisable,
     enabled: widget.isDisable,
      controller: widget.controller,

      obscureText: widget.obscureText && _obscureText, 
      decoration: InputDecoration(
        disabledBorder: const OutlineInputBorder(),


        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.obscureText ?
          IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
          ) : null, // Only show the icon if obscureText is true
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}