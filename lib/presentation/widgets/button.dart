import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ElevatedButton AppButton({
  border,
  color,
  content,
  action,
}) {
  return ElevatedButton(
    onPressed: action,
    child: content,
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? ElevatedButton.styleFrom().backgroundColor,
      shape: border == null
          ? const StadiumBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border),
            ),
    ),
  );
}
