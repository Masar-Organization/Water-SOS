import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final String? icon;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.icon,
    this.iconData,
    this.onPressed,
    this.isLoading = false,
  }) : assert(
  icon == null || iconData == null,
  'Use either icon or iconData, not both.',
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: context.width(22),
              height: context.height(22),
              child: CircularProgressIndicator(),
            )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            AppAssetHelper.svgImage(
              icon!,
              width: context.width(12),
              height: context.height(12),
            ),
            context.addHorizontalSpace(10),
          ],

          if (iconData != null) ...[
            Icon(
              iconData,
              size: 12,
            ),
            context.addHorizontalSpace(10),
          ],

          Text(text),
        ],
      ),
    );
  }
}
