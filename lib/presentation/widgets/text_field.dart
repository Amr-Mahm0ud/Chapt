import 'package:flutter/material.dart';
import '../resources/values_manager.dart';

// ignore: non_constant_identifier_names
class AppInputField extends StatefulWidget {
  final String? hint;
  final TextInputType type;
  final IconData? icon;
  final TextEditingController? controller;
  final dynamic validator;
  final bool obscure;
  final String? errorText;
  final bool haveErrorText;
  final Widget? action;
  final bool filled;
  final InputBorder? border;
  const AppInputField({
    super.key,
    this.hint,
    this.type = TextInputType.name,
    this.icon,
    this.controller,
    this.validator,
    this.obscure = false,
    this.errorText = '',
    this.haveErrorText = true,
    this.action,
    this.filled = true,
    this.border,
  });

  @override
  State<AppInputField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      controller: widget.controller,
      obscureText: widget.obscure,
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        suffixIcon: widget.action,
        filled: widget.filled,
        hintText: widget.hint,
        errorText: widget.haveErrorText ? widget.errorText : null,
        contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.p10, horizontal: AppPadding.p10),
        enabledBorder: widget.border,
        disabledBorder: widget.border,
        border: widget.border ??
            OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                AppValues.v10,
              ),
            ),
      ),
    );
  }
}
