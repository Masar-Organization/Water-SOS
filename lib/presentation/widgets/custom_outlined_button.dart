import 'package:flutter/material.dart';
import 'package:water_sos/core/global/design_system/theme_data/theme_extension.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';

class CustomOutlinedButton extends StatelessWidget {
final String text;
final String? icon;
final IconData? iconData;
final VoidCallback? onPressed;
final bool isLoading;

const CustomOutlinedButton({
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

final bool enabled =
onPressed != null && !isLoading;

return SizedBox(
width: double.infinity,
height: buttonTheme.height,
child: OutlinedButton(
onPressed: enabled ? onPressed : null,
style: OutlinedButton.styleFrom(
backgroundColor: Colors.transparent,

foregroundColor:
buttonTheme.outlinedForegroundColor,

disabledForegroundColor:
buttonTheme.outlinedDisabledForegroundColor,

minimumSize: Size.zero,

padding: buttonTheme.padding,

tapTargetSize:
MaterialTapTargetSize.shrinkWrap,

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(
buttonTheme.borderRadius,
),
),

side: BorderSide(
color: enabled
? buttonTheme.outlinedBorderColor
    : buttonTheme.outlinedDisabledBorderColor,
width: buttonTheme.outlinedBorderWidth,
),
),
child: isLoading
? SizedBox(
width:
buttonTheme.loadingIndicatorSize,
height:
buttonTheme.loadingIndicatorSize,
child: CircularProgressIndicator(
strokeWidth:
buttonTheme.loadingStrokeWidth,
color:
buttonTheme.outlinedForegroundColor,
),
)
    : Row(
mainAxisAlignment:
MainAxisAlignment.center,
mainAxisSize: MainAxisSize.min,
children: [
if (icon != null) ...[
AppAssetHelper.svgImage(
icon,
width: buttonTheme.iconSize,
height: buttonTheme.iconSize,
),

SizedBox(
width: buttonTheme.iconSpacing,
),
],

if (iconData != null) ...[
Icon(
iconData,
size: buttonTheme.iconSize,
color:
buttonTheme.outlinedForegroundColor,
),

SizedBox(
width: buttonTheme.iconSpacing,
),
],

Text(
text,
style: Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(
color: buttonTheme
    .outlinedForegroundColor,
),
),
],
),
),
);
}
}
