import 'package:chapt/presentation/color_manager.dart';
import 'package:chapt/presentation/font_manager.dart';
import 'package:flutter/material.dart';

// general text style
TextStyle _getTextStyle(double size, Color color, FontWeight wieght) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontSize: size,
    fontWeight: wieght,
  );
}

// regular text style
TextStyle getRegularText(
    {double size = FontSizeManager.s21,
    Color color = ColorManager.backglight}) {
  return _getTextStyle(size, color, FontWieghtManager.regular);
}

// light text style
TextStyle getLightText(
    {double size = FontSizeManager.s18,
    Color color = ColorManager.backglight}) {
  return _getTextStyle(size, color, FontWieghtManager.light);
}

// semi bold text style
TextStyle getSemiBoldText(
    {double size = FontSizeManager.s24,
    Color color = ColorManager.backglight}) {
  return _getTextStyle(size, color, FontWieghtManager.semibold);
}

// bold text style
TextStyle getBoldText(
    {double size = FontSizeManager.s26,
    Color color = ColorManager.backglight}) {
  return _getTextStyle(size, color, FontWieghtManager.bold);
}
