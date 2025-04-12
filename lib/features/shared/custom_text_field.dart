import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: false,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.colorOutline,
          ),
        ),
        prefixIcon: prefix,
        suffix: suffix,
      ),
    );
  }
}
