import 'package:flutter/material.dart';
import 'package:water_sos/core/global/design_system/theme_data/app_theme.dart';
import 'package:water_sos/core/routing/app_router.dart';
import 'package:water_sos/core/routing/routes.dart';


class WaterApp extends StatelessWidget {
  final AppRouter appRouter;
  const WaterApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water SOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
