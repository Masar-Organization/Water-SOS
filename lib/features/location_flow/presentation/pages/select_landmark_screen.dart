import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_scaffold.dart';
import 'package:water_sos/shared/widgets/custom_elevated_button.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/info_banner.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/map_illustration.dart';

class SelectLandmarkScreen extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectLandmarkScreen({super.key, required this.selection, required this.onNext});

  @override
  State<SelectLandmarkScreen> createState() => _SelectLandmarkScreenState();
}

class _SelectLandmarkScreenState extends State<SelectLandmarkScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.selection.landmark ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'أدخل معلمًا معروفًا',
      subtitle: 'اكتب معلمًا قريبًا من موقعك لتحديده بدقة',
      illustration:  MapIllustration(
        image: AppImages.imageLandmark,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('المعلم (اختياري)', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'مثال: مسجد النور، مدرسة فلسطين، دوار الشهداء',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD3DCEC)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const InfoBanner(title: 'معلومة', text: 'كلما كان المعلم أقرب لموقعك كان تحديده أدق.'),
        ],
      ),
      footer: CustomElevatedButton(
        text: "التالي",
        onPressed: () => widget.onNext(_controller.text.trim()),
      ),

    );
  }
}
