import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/navigation.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/core/routing/routes.dart';
import 'package:water_sos/features/splash/presentation/widgets/glass_card.dart';
import 'package:water_sos/features/splash/presentation/widgets/logo_water_app.dart';

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

    context.pushReplacementNamed(Routes.locationFlowScreen);
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
            child: LogoWaterApp(),
          ),

          Positioned(
            bottom: context.height(100),
            left: context.width(20),
            right: context.width(20),
            child: GlassCard(
              child: Column(
                spacing: context.height(16),
                children: [
                  Text(
                    "WaterSOS",
                    style: context.font34Bold?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Your water. Your voice. Your community.",
                    textAlign: TextAlign.center,
                    style: context.font18Regular?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
