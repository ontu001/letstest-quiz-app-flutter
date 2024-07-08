import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Icon? icon;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
     this.icon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        icon: icon,
        hintText: hintText,
      ),
    );
  }
}
