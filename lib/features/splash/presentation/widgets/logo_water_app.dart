import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_lotties.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';

class LogoWaterApp extends StatelessWidget {
  const LogoWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAssetHelper.lottieImage(
      AppLotties.lottieWater,
      width: context.width(150),
      height: context.height(150),
    );
  }
}
