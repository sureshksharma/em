import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CustomSelectableTextField extends StatelessWidget {
  const CustomSelectableTextField({
    super.key,
    required this.onTap,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.validator,
  });
  final VoidCallback onTap;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onTap,
      onLongPress: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
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
            suffixIcon: suffix,
          ),
        ),
      ),
    );
  }
}
