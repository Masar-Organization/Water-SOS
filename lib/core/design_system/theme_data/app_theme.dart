import 'package:flutter/material.dart';
import 'package:water_sos/core/design_system/app_color/app_color_light.dart';
import 'package:water_sos/core/design_system/app_color/app_gradients.dart';
import 'package:water_sos/core/design_system/font_weight/font_weight_helper.dart';

class AppTheme {
  static const String _defaultFont = '';
  // Text Styles
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


  static ThemeData get lightTheme {
    final colors = AppColorLight.colors;

    return ThemeData(
      brightness: Brightness.light,

      fontFamily: _defaultFont,
      // Theme Extensions
      extensions: [
        colors,
      ],
      primaryColor: colors.primaryColor,
      scaffoldBackgroundColor: colors.backgroundColor,
      cardColor: colors.cardColor,

      colorScheme: ColorScheme.light(
        primary: colors.primaryColor,
        surface: colors.cardColor,
        onSurface: colors.textPrimaryColor,
        onSurfaceVariant: colors.textSecondaryColor,
      ),

      textTheme: _buildTextTheme(textColor: colors.textPrimaryColor),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,

          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,

          elevation: 0,
          shadowColor: Colors.transparent,

          minimumSize: const Size(double.infinity, 42),

          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),

          textStyle: _style(
            fontSize: 16,
            fontWeight: FontWeightHelper.bold,
            lineHeight: 24,
            textColor: Colors.white,
          ),

          // Gradient / Disabled background
          backgroundBuilder: (context, states, child) {
            final isDisabled =
            states.contains(WidgetState.disabled);

            return Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),

                gradient: isDisabled
                    ? null
                    : AppGradients.primary,

                color: isDisabled
                    ? const Color(0xFFB9C8EA)
                    : null,
              ),
              child: child,
            );
          },
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primaryColor,
          minimumSize: const Size(double.infinity, 42),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: BorderSide(
            color: colors.primaryColor,
            width: 1,
          ),
        ),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.cardColor,
        isDense: true,

        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),

        hintStyle: _buildTextTheme(
          textColor: colors.textSecondaryColor,
        ).labelMedium,

        labelStyle: _buildTextTheme(
          textColor: colors.textSecondaryColor,
        ).labelMedium,

        suffixIconColor: colors.textSecondaryColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputBorderColor),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputBorderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.inputFocusedBorderColor,
            width: 1,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputErrorBorderColor),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputErrorBorderColor),
        ),
      ),

     // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        strokeWidth: 2.5,
      ),
    );
  }
}
