import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.blue, size: 28),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: AppColors.grey),
      prefixIconColor: AppColors.grey,
      suffixIconColor: AppColors.grey,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.opacBlue,
      selectionHandleColor: AppColors.blue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
    ),
  );
}
