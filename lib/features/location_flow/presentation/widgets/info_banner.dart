import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';

class InfoBanner extends StatelessWidget {
  final String title;
  final String text;

  const InfoBanner({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = context.colors;
    return Container(
      width: double.infinity,
      padding: context.spaceAroundAll(16),
      decoration: BoxDecoration(
        color: color.iconBackgroundColor,
        borderRadius: context.circularRadius(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.width(8),
        children: [
          Icon(Icons.info_outline, color: color.primaryColor, size: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: context.height(4),
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: context.font14Bold?.copyWith(
                    color: color.primaryColor,
                  ),
                ),

                Text(
                  text,
                  textAlign: TextAlign.right,
                  style: context.font14Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
