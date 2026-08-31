import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';

class StepScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final Widget body;
  final Widget footer;

  const StepScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.body,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: context.spaceSymmetric(horizontal: 20, vertical: 16),
              child: Column(
                spacing: context.height(16),
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.font22Bold,
                  ),

                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: context.font14Regular,
                  ),

                  illustration,

                  body,
                ],
              ),
            ),
          ),

          Padding(
            padding: context.fromLTRB(left: 20, top: 8, right: 20, bottom: 16),

            child: footer,
          ),
        ],
      ),
    );
  }
}
