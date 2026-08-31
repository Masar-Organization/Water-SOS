import 'package:flutter/material.dart';
import 'package:water_sos/core/global/design_system/app_color/app_colors.dart';
import 'package:water_sos/core/global/design_system/theme_data/app_button_theme.dart';

extension ThemeExtension on BuildContext {
  AppColors get colors {
    return Theme.of(this).extension<AppColors>()!;
  }
  AppButtonTheme get buttonTheme {
    return Theme.of(this).extension<AppButtonTheme>()!;
  }
}
