import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/presentation/widgets/custom_elevated_button.dart';
import 'package:water_sos/presentation/widgets/custom_outlined_button.dart';
import 'package:water_sos/presentation/widgets/location_flow/info_banner.dart';
import 'package:water_sos/presentation/widgets/location_flow/step_scaffold.dart';
import 'package:water_sos/presentation/widgets/map_illustration.dart';
import 'package:water_sos/presentation/widgets/location_flow/review_tile.dart';

class ReviewScreen extends StatelessWidget {
  final LocationSelection selection;
  final ValueChanged<String> onEditStep;

  const ReviewScreen({
    super.key,
    required this.selection,
    required this.onEditStep,
  });

  String _formatCapturedAt(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)}  ${two(dt.hour)}:${two(dt.minute)}';
  }

  void _confirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 48),
            SizedBox(height: 8),
            Text('تم تأكيد الموقع', textAlign: TextAlign.center),
          ],
        ),
        content: Text(
          'الطريقة: ${selection.method}\n'
          'المحافظة: ${selection.governorate}\n'
          'المنطقة: ${selection.region}\n'
          'الحي/الشارع: ${selection.streetNeighborhood}\n'
          'المعلم: ${selection.landmark?.isNotEmpty == true ? selection.landmark : "لا يوجد"}'
          '${selection.wasCapturedByGps ? '\nوقت الالتقاط: ${_formatCapturedAt(selection.capturedAt!)}' : ''}',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1657D6),
                foregroundColor: Colors.white,
              ),
              child: const Text('حسناً'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'مراجعة وتأكيد الموقع',
      subtitle: 'تحقق من بيانات العنوان قبل التأكيد',
      illustration: MapIllustration(image: AppImages.imageConfirmLocation),
      body: Column(
        children: [
          ReviewTile(
            icon: selection.wasCapturedByGps
                ? Icons.gps_fixed
                : Icons.edit_location_alt,
            title: 'طريقة التحديد',
            value: selection.wasCapturedByGps
                ? 'عبر GPS — بتاريخ ${_formatCapturedAt(selection.capturedAt!)}'
                : 'إدخال يدوي',
            onEdit: () => onEditStep('method'),
          ),
          ReviewTile(
            icon: Icons.account_balance,
            title: 'المحافظة',
            value: selection.governorate ?? '-',
            onEdit: () => onEditStep('governorate'),
          ),
          ReviewTile(
            icon: Icons.map,
            title: 'المنطقة',
            value: selection.region ?? '-',
            onEdit: () => onEditStep('region'),
          ),
          ReviewTile(
            icon: Icons.person_pin_circle,
            title: 'الحي / الشارع',
            value: selection.streetNeighborhood ?? '-',
            onEdit: () => onEditStep('street'),
          ),
          ReviewTile(
            icon: Icons.edit,
            title: 'المعلم',
            value: (selection.landmark?.isNotEmpty ?? false)
                ? selection.landmark!
                : 'لا يوجد',
            onEdit: () => onEditStep('landmark'),
          ),
          const SizedBox(height: 8),
          const InfoBanner(
            title: 'معلومة',
            text: 'تأكد من صحة العنوان لتصلك خدماتنا بشكل أسرع وأكثر دقة.',
          ),
        ],
      ),
      footer: Row(
        spacing: context.width(10),
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'تعديل العنوان',
              onPressed: () => onEditStep('method'),
              iconData: Icons.edit,
            ),
          ),

          Expanded(
            child: CustomElevatedButton(
              text: 'تأكيد الموقع',
              onPressed: selection.hasBasics ? () => _confirm(context) : null,
              iconData: Icons.arrow_back_ios_new,
            ),
          ),
        ],
      ),
    );
  }
}
