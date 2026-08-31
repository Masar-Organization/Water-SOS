import 'package:flutter/material.dart';
import 'package:water_sos/core/routing/routes.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/presentation/screens/main_screen.dart';
import 'package:water_sos/presentation/screens/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.locationFlowScreen:
        return MaterialPageRoute(builder: (_) => LocationFlowScreen());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No Route Found ${settings.name}')),
          ),
        );
    }
  }
}
