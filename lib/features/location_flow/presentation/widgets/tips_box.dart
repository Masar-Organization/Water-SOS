import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';

class TipsBox extends StatelessWidget {
  final String title;
  final List<(IconData, String)> tips;

  const TipsBox({super.key, required this.title, required this.tips});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.info_outline,
                color: color.primaryColor,
                size: context.width(20),
              ),

              Text(
                title,
                textAlign: TextAlign.right,
                style: context.font16Bold?.copyWith(color: color.primaryColor),
              ),
            ],
          ),

          Divider(height: context.height(20), color: color.borderColor),

          for (final tip in tips)
            Padding(
              padding: context.spaceVertical(6),
              child: Row(
                spacing: context.width(8),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    tip.$1,
                    size: context.width(18),
                    color: color.primaryColor,
                  ),

                  Expanded(
                    child: Text(
                      tip.$2,
                      textAlign: TextAlign.right,
                      style: context.font14Regular?.copyWith(
                        color: color.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
