import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/opacity_of_color.dart';

class AppGradients {
  AppGradients._();

  /// Main gradient used for primary actions/buttons.
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF23B7DB), Color(0xFF0E8CBC)],
  );

  /// Soft background gradient used across the main flow.
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8FAFF), Color(0xFFF5FDFF), Color(0xFFFFFFFF)],
    stops: [0.0, 0.45, 1.0],
  );

  /// Decorative water glow / circle.
  static LinearGradient get waterGlow => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF00C2E0).changeOpacity(0.18),
      const Color(0xFF0077C8).changeOpacity(0.04),
    ],
  );
}
