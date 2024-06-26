import 'color_manager.dart';
import 'text_styles.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    //colors
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.primary,
      error: ColorManager.error,
      background: ColorManager.backgdark,
      secondary: ColorManager.secondry,
      onPrimary: ColorManager.backglight,
      onSecondary: ColorManager.backglight,
      onError: ColorManager.greyColordark,
      onBackground: ColorManager.backglight,
      surface: ColorManager.secondry,
      onSurface: ColorManager.backglight,
    ),

    //appbar theme
    appBarTheme: const AppBarTheme(
      elevation: AppValues.v0,
      backgroundColor: ColorManager.trans,
      shadowColor: ColorManager.trans,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.backglight,
        shape: const StadiumBorder(),
        textStyle: getRegularText(
          color: ColorManager.backglight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p40,
          vertical: AppPadding.p15,
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      headlineLarge: getBoldText(color: ColorManager.backglight),
      headlineMedium: getSemiBoldText(color: ColorManager.greyColordark),
      bodyLarge: getRegularText(color: ColorManager.backglight),
      bodyMedium: getLightText(color: ColorManager.greyColordark),
    ),
  );
}

ThemeData getLightTheme() {
  return ThemeData(
    //colors
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.primary,
      error: ColorManager.error,
      background: ColorManager.backglight,
      secondary: ColorManager.secondryLight,
      onPrimary: ColorManager.backgdark,
      onSecondary: ColorManager.backgdark,
      onError: ColorManager.greyColorlight,
      onBackground: ColorManager.backgdark,
      surface: ColorManager.secondryLight,
      onSurface: ColorManager.backgdark,
    ),

    //appbar theme
    appBarTheme: const AppBarTheme(
      elevation: AppValues.v0,
      backgroundColor: ColorManager.trans,
      shadowColor: ColorManager.trans,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.backglight,
        shape: const StadiumBorder(),
        textStyle: getRegularText(
          color: ColorManager.backglight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p40,
          vertical: AppPadding.p15,
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      headlineLarge: getBoldText(color: ColorManager.backgdark),
      headlineMedium: getSemiBoldText(color: ColorManager.greyColorlight),
      bodyLarge: getRegularText(color: ColorManager.backgdark),
      bodyMedium: getLightText(color: ColorManager.greyColorlight),
    ),
  );
}
