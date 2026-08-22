import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      //
      // case Routes.splashScreen:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());
      //
      // case Routes.loginScreen:
      //   return MaterialPageRoute(builder: (_) => LoginScreen());


      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No Route Found ${settings.name}')),
          ),
        );
    }
  }
}
