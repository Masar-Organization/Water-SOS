import 'package:flutter/material.dart';
import 'package:water_sos/core/design_system/app_color/app_colors.dart';

extension ThemeExtension on BuildContext {
  AppColors get colors {
    return Theme.of(this).extension<AppColors>()!;
  }

}
