import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/app_colors.dart';
import 'custom_theme_extension.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    // backgroundColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    extensions: [CustomThemeExtension.darkMode],

    // AppBar Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greyBackground,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.greyDark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: AppColors.greyDark),
    ),

    // TabBar Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.greenDark, width: 2),
      ),
      unselectedLabelColor: AppColors.greyDark,
      labelColor: AppColors.greenDark,
    ),

    // ElevatedButton Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenDark,
        foregroundColor: AppColors.backgroundDark,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),

    // BottomSheet Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.greyBackground,
      modalBackgroundColor: AppColors.greyBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Dialog Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    dialogBackgroundColor: AppColors.greyBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    // FloatingActionButton Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: Colors.white,
    ),

    // ListTile Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greyDark,
      tileColor: AppColors.backgroundDark,
    ),

    // Switch Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(AppColors.greyDark),
      trackColor: MaterialStatePropertyAll(Color(0xFF344047)),
    ),
  );
}
