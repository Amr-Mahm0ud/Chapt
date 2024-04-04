import 'package:flutter/material.dart';

class AppMargins {
  static const double m20 = 20.0;
  static const double m30 = 30.0;
  static const double m40 = 40.0;
}

class AppPadding {
  static const double p10 = 10.0;
  static const double p15 = 15.0;
  static const double p20 = 20.0;
  static const double p25 = 25.0;
  static const double p30 = 30.0;
  static const double p40 = 40.0;
  static const double p50 = 50.0;
}

class AppValues {
  static const double v0 = 0.0;
  static const double v05 = 0.5;
  static const double v025 = 0.25;
  static const double v10 = 10;
  static const double v12 = 12;
  static const double v15 = 15;
  static const double v20 = 20;
  static const double v30 = 30;
  static const double v40 = 40;
  static const double v50 = 50;

  static const int i2 = 2;
  static const int i300 = 300;

  static const Curve linear = Curves.linear;

  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}
