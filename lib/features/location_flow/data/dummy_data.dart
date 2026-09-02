class DummyData {
  static const List<String> methods = ['تحديد عبر GPS', 'إدخال يدوي'];

  static const List<String> governorates = [
    'شمال غزة',
    'غزة',
    'الوسطى',
    'خانيونس',
    'رفح',
  ];

  static const Map<String, List<String>> regionsByGovernorate = {
    'شمال غزة': ['شمال غزة', 'جباليا', 'بيت لاهيا', 'بيت حانون'],
    'غزة': ['الرمال', 'الزيتون', 'الشجاعية', 'التفاح'],
    'الوسطى': ['النصيرات', 'دير البلح', 'المغراقة', 'البريج'],
    'خانيونس': ['خانيونس البلد', 'خزاعة', 'عبسان', 'بني سهيلا'],
    'رفح': ['رفح البلد', 'الشوكة', 'تل السلطان'],
  };

  static const Map<String, List<String>> streetsByRegion = {
    'جباليا': ['شارع النصر', 'شارع الوحدة', 'شارع السوق', 'حي الزيتون', 'حي السلام', 'حي الأمل'],
    'النصيرات': ['المخيم الجديد', 'المخيم القديم', 'حي الشهداء'],
    'الرمال': ['شارع الجلاء', 'شارع عمر المختار', 'شارع الرشيد'],
  };

  static const List<String> defaultStreets = ['الحي الأول', 'الحي الثاني', 'الشارع الرئيسي'];

  /// Stand-in for a real reverse-geocoding call. Given a captured GPS fix,
  /// returns the address fields to pre-fill (still editable afterwards).
  static ({String governorate, String region, String street}) reverseGeocode(
      double lat,
      double lng,
      ) {
    return (governorate: 'الوسطى', region: 'النصيرات', street: 'المخيم الجديد');
  }
}

class StepDef {
  final String key;
  final String label;
  const StepDef(this.key, this.label);
}

const List<StepDef> kAllSteps = [
  StepDef('method', 'الطريقة'),
  StepDef('locating', 'تحديد الموقع'),
  StepDef('governorate', 'المحافظة'),
  StepDef('region', 'المنطقة'),
  StepDef('street', 'الحي/الشارع'),
  StepDef('landmark', 'المعلم'),
  StepDef('review', 'مراجعة'),
];

const List<StepDef> kManualSteps = [
  StepDef('method', 'الطريقة'),
  StepDef('governorate', 'المحافظة'),
  StepDef('region', 'المنطقة'),
  StepDef('street', 'الحي/الشارع'),
  StepDef('landmark', 'المعلم'),
  StepDef('review', 'مراجعة'),
];