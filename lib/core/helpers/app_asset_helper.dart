import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_sos/core/extension/opacity_of_color.dart';

mixin AppAssetHelper {
  static Widget svgImage(
    String? path_, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholderBuilder,
    bool network = false,
    double opacity = 1,
  }) {
    String path = path_ ?? '';
    if (path.isEmpty) return SizedBox(width: width, height: height);

    return Opacity(
      opacity: opacity,
      child: !network
          ? SvgPicture.asset(
              path,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color?.toColorFilter(),
              placeholderBuilder: placeholderBuilder != null
                  ? (_) => placeholderBuilder
                  : null,
              errorBuilder: (context, error, stackTrace) => errorImageBuilder,
            )
          : SvgPicture.network(
              path,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color?.toColorFilter(),
              placeholderBuilder: placeholderBuilder != null
                  ? (_) => placeholderBuilder
                  : null,
              errorBuilder: (context, error, stackTrace) => errorImageBuilder,
            ),
    );
  }

  static Widget get errorImageBuilder {
    return Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.error));
  }
}
