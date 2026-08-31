import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/constants/app_lotties.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/navigation.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/helpers/app_asset_helper.dart';
import 'package:water_sos/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    context.pushReplacementNamed(
      Routes.locationFlowScreen,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.imageBackground, fit: BoxFit.cover),
          ),
          Positioned(
            top: context.height(100),
            left: context.width(20),
            right: context.width(20),
            child: AppAssetHelper.lottieImage(
              AppLotties.lottieWater,
              width: context.width(150),
              height: context.height(150),
            ),
          ),

          Positioned(
            bottom: context.height(100),
            left: context.width(20),
            right: context.width(20),
            child: ClipRRect(
              borderRadius: context.circularRadius(14),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  padding: context.spaceSymmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: context.circularRadius(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.30),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: context.height(16),
                    children: [
                      Text(
                        "WaterSOS",
                        style: context.font34Bold?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Your water. Your voice. Your community.",
                        textAlign: TextAlign.center,
                        style: context.font18Regular?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
