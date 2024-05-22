import 'dart:async';

import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyOnboardingScreenViewed =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyIsDarkTHeme = "PREFS_KEY_IS_DARK_THEME";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // on boarding
  Future<void> setOnBoardingScreenViewed() async {
    await _sharedPreferences.setBool(prefsKeyOnboardingScreenViewed, true);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(prefsKeyOnboardingScreenViewed) ?? false;
  }
  //********************************************* */

  //login
  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout(context) async {
    await _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
    await _sharedPreferences.remove(prefsKeyOnboardingScreenViewed);
    Navigator.pushReplacementNamed(context, Routes.splash);
  }
  //******************************************** */

  //THEME
  Future<void> changeTheme() async {
    await _sharedPreferences.setBool(prefsKeyIsDarkTHeme, !getTheme());
  }

  bool getTheme() => _sharedPreferences.getBool(prefsKeyIsDarkTHeme) ?? false;
}
