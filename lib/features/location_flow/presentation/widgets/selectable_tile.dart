import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/design_system/font_weight/font_weight_helper.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';

class SelectableTile extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const SelectableTile({
    super.key,
    required this.label,
    required this.selected,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.colors;
    return Padding(
      padding: context.spaceBottom(8),
      child: InkWell(
        borderRadius: context.circularRadius(14),
        onTap: onTap,
        child: Container(
          padding: context.spaceSymmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: context.circularRadius(14),
            border: Border.all(
              color: selected ? color.primaryColor : color.borderColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                color: selected
                    ? color.primaryColor
                    : color.textSecondaryColor,
              ),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: selected
                        ? FontWeightHelper.bold
                        : FontWeightHelper.regular,
                    color: selected
                        ? color.primaryColor
                        : color.textPrimaryColor,
                  ),
                ),
              ),
              context.addHorizontalSpace(10),
              CircleAvatar(
                radius: 15,
                backgroundColor: color.iconBackgroundColor,
                child: Icon(leadingIcon, size: 16, color: color.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
