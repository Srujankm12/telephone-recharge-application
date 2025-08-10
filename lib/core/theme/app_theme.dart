import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: AppColors.white,
    
  );
}