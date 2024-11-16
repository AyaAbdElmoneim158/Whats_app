import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/app_colors.dart';
import 'custom_theme_extension.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    // backgroundColor: AppColors.backgroundLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    extensions: [CustomThemeExtension.lightMode],

    // AppBar Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenLight,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // TabBar Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
    ),

    // ElevatedButton Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenLight,
        foregroundColor: AppColors.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),

    // BottomSheet Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.backgroundLight,
      modalBackgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Dialog Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    dialogBackgroundColor: AppColors.backgroundLight,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    // FloatingActionButton Theme - - - - - - - - - - - - - - - - - - - - - - - -
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: Colors.white,
    ),

    // ListTile Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greyDark,
      tileColor: AppColors.backgroundLight,
    ),

    // Switch Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
  );
}
