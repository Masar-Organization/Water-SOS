import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';

class SelectedValueBar extends StatelessWidget {
  final String label;
  final String value;
  const SelectedValueBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final color = context.colors;

    return Container(
      width: double.infinity,
      padding: context.spaceSymmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.cardColor,
        borderRadius: context.circularRadius(14),
        border: Border.all(color: color.borderColor),
      ),
      child: Row(
        spacing: context.width(8),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.location_on,
            color: color.primaryColor,
            size: context.width(18),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.right,
                  style: context.font14Regular?.copyWith(
                    color: color.textSecondaryColor,
                  ),
                ),

                if (value.isNotEmpty)
                  Text(
                    value,
                    textAlign: TextAlign.right,
                    style: context.font14Bold?.copyWith(
                      color: color.textPrimaryColor,
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
