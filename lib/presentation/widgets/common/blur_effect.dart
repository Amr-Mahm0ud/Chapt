// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../resources/values_manager.dart';

Widget AppBlurEffect({required child}) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: AppValues.v50, sigmaY: AppValues.v50),
    child: child,
  );
}
