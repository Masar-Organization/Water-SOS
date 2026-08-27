import 'package:flutter/material.dart';

import 'presentation/screens/location_flow_screen.dart';

class WareApp extends StatelessWidget {
  const WareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water SOS',
      home: const LocationFlowScreen(),
    );
  }
}
