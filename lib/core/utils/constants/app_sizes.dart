import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  /// Padding and margin sizes - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  /// Icon sizes - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  /// Font sizes - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  /// Spacing  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;
  static double defaultPadding = 24.0;
  static double defaultBtwFields = 20.0;

  /// Border radius  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;

  /// borderSide  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static const double borderSide = 1.0;

  /// Spacing - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static SizedBox verticalSpace(double height) => SizedBox(height: height);
  static SizedBox horizontalSpace(double width) => SizedBox(width: width);

  /// Divider height  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static double dividerHeight = 1.0;

  /// Appbar height  ----------------------------------------------------------------
  static double appBarHeight = 56;
}
