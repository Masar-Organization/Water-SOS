import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/global/design_system/theme_data/app_theme.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final String? icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isLoading = false,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            AppAssetHelper.svgImage(icon),
            isLoading
                ? SizedBox(
              width: 24,
              height: 24,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
                : Text(
              text,
              style:
              context.font16Bold?.copyWith(color: Colors.white) ??
                  Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ),
    );
  }
}
