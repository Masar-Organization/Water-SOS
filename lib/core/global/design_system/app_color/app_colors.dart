import 'package:flutter/material.dart';

abstract class AppColors {
  final Color primaryColor;
  final Color backgroundColor;
  final Color cardColor;

  final Color inputBorderColor;
  final Color inputErrorBorderColor;
  final Color inputFocusedBorderColor;

  final Color textPrimaryColor;
  final Color textSecondaryColor;

  final Color buttonBackgroundColor;
  final Color buttonTextColor;

  const AppColors({
    required this.primaryColor,
    required this.backgroundColor,
    required this.cardColor,

    required this.inputBorderColor,
    required this.inputFocusedBorderColor,
    required this.inputErrorBorderColor,

    required this.textPrimaryColor,
    required this.textSecondaryColor,

    required this.buttonBackgroundColor,
    required this.buttonTextColor,
  });
}

class AppColorLight extends AppColors {
  const AppColorLight()
    : super(
        primaryColor: const Color(0xFF00A3C4),
        backgroundColor: const Color(0xFFF8F9FA),
        cardColor: const Color(0xFFFFFFFF),

        inputBorderColor: const Color(0xFF9CA3AF),
        inputFocusedBorderColor: const Color(0xFF00A3C4),
        inputErrorBorderColor: const Color(0xFFEF4444),

        textPrimaryColor: const Color(0xFF181A1B),
        textSecondaryColor: const Color(0xFF64748B),

        buttonBackgroundColor: const Color(0xFF9747FF),
        buttonTextColor: const Color(0xFFFFFFFF),
      );
}
