import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';

class MapIllustration extends StatelessWidget {
  final String image;
  const MapIllustration({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: context.width(150),
      height: context.height(150),
    );
  }
}
