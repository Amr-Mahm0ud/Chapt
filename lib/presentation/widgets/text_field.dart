import 'package:flutter/material.dart';
import '../resources/values_manager.dart';

// ignore: non_constant_identifier_names
TextFormField AppInputField({
  required hint,
  type = TextInputType.name,
  required icon,
  required controller,
  bool obscure = false,
  errorText,
  Widget? action,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      suffixIcon: action,
      filled: true,
      hintText: hint,
      errorText: errorText,
      contentPadding: const EdgeInsets.all(AppValues.v12),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(
          AppValues.v10,
        ),
      ),
    ),
  );
}
