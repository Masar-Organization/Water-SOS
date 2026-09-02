import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: context.circularRadius(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          padding: context.spaceSymmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: context.circularRadius(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
