import 'package:water_sos/core/constants/app_images.dart';

class LocationStepConfig {
  final String title;
  final String subtitle;
  final String illustration;

  const LocationStepConfig({
    required this.title,
    required this.subtitle,
    required this.illustration,
  });
}
class LocationStepConfigs {
  static const method = LocationStepConfig(
    title: 'اختر طريقة تحديد موقعك',
    subtitle: 'يمكنك استخدام GPS أو إدخال العنوان يدوياً',
    illustration: AppImages.imageIllustration,
  );

  static const governorate = LocationStepConfig(
    title: 'اختر محافظتك',
    subtitle: 'اختر المحافظة التي تقع بها',
    illustration: AppImages.imageGovernorate,
  );

  static const region = LocationStepConfig(
    title: 'اختر منطقتك',
    subtitle: 'اختر المنطقة التابعة للمحافظة',
    illustration: AppImages.imageRegion,
  );

  static const street = LocationStepConfig(
    title: 'اختر الحي/الشارع',
    subtitle: 'اختر الحي أو الشارع التابع للمنطقة المحددة',
    illustration: AppImages.imageStreet,
  );

  static const landmark = LocationStepConfig(
    title: 'أدخل معلمًا معروفًا',
    subtitle: 'اكتب معلمًا قريبًا من موقعك لتحديده بدقة',
    illustration: AppImages.imageLandmark,
  );

  static const review = LocationStepConfig(
    title: 'مراجعة وتأكيد الموقع',
    subtitle: 'تحقق من بيانات العنوان قبل التأكيد',
    illustration: AppImages.imageConfirmLocation,
  );
}