import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ElevatedButton AppButton({
  rounded = false,
  color,
  required content,
  required action,
}) {
  return ElevatedButton(
    onPressed: action,
    child: content,
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? ElevatedButton.styleFrom().backgroundColor,
      shape: rounded
          ? const StadiumBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.v15),
            ),
    ),
  );
}
