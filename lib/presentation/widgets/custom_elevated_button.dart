import 'package:flutter/material.dart';
import 'package:water_sos/core/global/design_system/theme_data/theme_extension.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;

  /// SVG asset path.
  final String? icon;

  /// Material/IconData icon.
  final IconData? iconData;

  final VoidCallback? onPressed;

  /// Controls loading state.
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
    final buttonTheme = context.buttonTheme;

    final bool enabled = onPressed != null && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: buttonTheme.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: enabled ? buttonTheme.backgroundGradient : null,
          color: enabled ? null : buttonTheme.disabledBackgroundColor,
          borderRadius: BorderRadius.circular(buttonTheme.borderRadius),
        ),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: buttonTheme.foregroundColor,
            disabledForegroundColor: buttonTheme.disabledForegroundColor,
            elevation: 0,
            padding: buttonTheme.padding,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonTheme.borderRadius),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: buttonTheme.loadingIndicatorSize,
                  height: buttonTheme.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth: buttonTheme.loadingStrokeWidth,
                    color: buttonTheme.foregroundColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      AppAssetHelper.svgImage(
                        icon,
                        width: buttonTheme.iconSize,
                        height: buttonTheme.iconSize,
                      ),

                      SizedBox(width: buttonTheme.iconSpacing),
                    ],

                    if (iconData != null) ...[
                      Icon(
                        iconData,
                        size: buttonTheme.iconSize,
                        color: buttonTheme.foregroundColor,
                      ),

                      SizedBox(width: buttonTheme.iconSpacing),
                    ],

                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: buttonTheme.foregroundColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
