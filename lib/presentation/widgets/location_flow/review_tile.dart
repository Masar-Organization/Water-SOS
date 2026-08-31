import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/global/design_system/theme_data/theme_extension.dart';

class ReviewTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onEdit;

  const ReviewTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.colors;

    return Container(
      width: double.infinity,
      margin: context.spaceBottom(10),
      padding: context.spaceSymmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.cardColor,
        borderRadius: context.circularRadius(14),
        border: Border.all(color: color.borderColor),
      ),
      child: Row(
        children: [
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.chevron_left,
                size: context.width(20),
                color: color.textSecondaryColor,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: context.font14Regular?.copyWith(
                    color: color.textSecondaryColor,
                  ),
                ),

                SizedBox(height: context.height(2)),

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

          SizedBox(width: context.width(10)),

          CircleAvatar(
            radius: context.width(16),
            backgroundColor: color.iconBackgroundColor,
            child: Icon(
              icon,
              size: context.width(16),
              color: color.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
