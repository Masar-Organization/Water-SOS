import 'package:flutter/material.dart';
import 'package:water_sos/core/global/design_system/app_color/app_colors.dart';
import 'package:water_sos/core/global/design_system/font_weight/font_weight_helper.dart';

class AppTheme {
  static const AppColors lightColors = AppColorLight();

  static const String _defaultFont = '';

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required double lineHeight,
    required Color textColor,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      fontFamily: _defaultFont,
      height: lineHeight / fontSize,
    );
  }

  static TextTheme _buildTextTheme({required Color textColor}) {
    TextStyle create(double size, FontWeight weight, double figmaLineHeight) {
      return _style(
        fontSize: size,
        fontWeight: weight,
        lineHeight: figmaLineHeight,
        textColor: textColor,
      );
    }

    return TextTheme(
      displayLarge: create(34, FontWeightHelper.bold, 40),
      displayMedium: create(34, FontWeightHelper.regular, 40),

      displaySmall: create(28, FontWeightHelper.bold, 32),
      headlineLarge: create(28, FontWeightHelper.regular, 32),

      headlineMedium: create(26, FontWeightHelper.bold, 30),
      headlineSmall: create(26, FontWeightHelper.regular, 30),

      titleLarge: create(22, FontWeightHelper.bold, 28),
      titleMedium: create(22, FontWeightHelper.regular, 28),

      titleSmall: create(18, FontWeightHelper.bold, 24),
      bodyLarge: create(18, FontWeightHelper.regular, 24),

      bodyMedium: create(16, FontWeightHelper.bold, 24),
      bodySmall: create(16, FontWeightHelper.regular, 24),

      labelLarge: create(14, FontWeightHelper.bold, 20),
      labelMedium: create(14, FontWeightHelper.regular, 20),
    );
  }

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF23B7DB), Color(0xFF0E8CBC)],
  );

  // (Light Theme)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: _defaultFont,
      primaryColor: lightColors.primaryColor,
      scaffoldBackgroundColor: lightColors.backgroundColor,
      cardColor: lightColors.cardColor,
      colorScheme: ColorScheme.light(
        primary: lightColors.primaryColor,
        surface: lightColors.cardColor,
        onSurface: lightColors.textPrimaryColor,
        onSurfaceVariant: lightColors.textSecondaryColor,
      ),

      textTheme: _buildTextTheme(textColor: lightColors.textPrimaryColor),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 42),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: _style(
            fontSize: 16,
            fontWeight: FontWeightHelper.bold,
            lineHeight: 24,
            textColor: Colors.white,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColors.cardColor,
        isDense: true,

        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),

        prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),

        hintStyle: _buildTextTheme(
          textColor: lightColors.textSecondaryColor,
        ).labelMedium,

        labelStyle: _buildTextTheme(
          textColor: lightColors.textSecondaryColor,
        ).labelMedium,

        suffixIconColor: lightColors.textSecondaryColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColors.inputBorderColor),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColors.inputBorderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: lightColors.inputFocusedBorderColor,
            width: 1,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColors.inputErrorBorderColor),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColors.inputErrorBorderColor),
        ),
      ),
    );
  }
}
