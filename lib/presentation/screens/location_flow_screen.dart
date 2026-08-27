import 'package:flutter/material.dart';
import 'package:water_sos/presentation/screens/location_selection.dart';
import 'package:water_sos/presentation/screens/select_citizen_location.dart';
import 'package:water_sos/presentation/screens/gps_locating_screen.dart';
import 'package:water_sos/presentation/screens/select_governorate_screen.dart';
import 'package:water_sos/presentation/screens/select_region_screen.dart';
import 'package:water_sos/presentation/screens/select_street_screen.dart';
import 'package:water_sos/presentation/screens/select_landmark_screen.dart';
import 'package:water_sos/presentation/screens/review_screen.dart';


// ============================================================
// Dummy data (address lists — replace with a real API later)
// ============================================================
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

// ============================================================
// Step identifiers (order used only for the progress bar / labels —
// actual navigation branches around "locating" depending on the method)
// ============================================================
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

// ============================================================
// Main controller — decides which screen to show and how to get there.
//
// Navigation is a small stack of step keys (not a fixed-size PageView)
// because the path length differs: GPS goes through "locating", manual
// entry skips it entirely and goes straight to "governorate".
// ============================================================
class LocationFlowScreen extends StatefulWidget {
  const LocationFlowScreen({super.key});

  @override
  State<LocationFlowScreen> createState() => _LocationFlowScreenState();
}

class _LocationFlowScreenState extends State<LocationFlowScreen> {
  final LocationSelection selection = LocationSelection();
  final List<String> _stack = ['method'];

  String get _current => _stack.last;

  List<StepDef> get _visibleSteps => selection.isManual ? kManualSteps : kAllSteps;

  int get _currentIndex => _visibleSteps.indexWhere((s) => s.key == _current);

  void _push(String key) => setState(() => _stack.add(key));

  void _back() {
    if (_stack.length > 1) {
      setState(() => _stack.removeLast());
    } else {
      Navigator.of(context).maybePop();
    }
  }

  /// Used by the review screen's "edit" buttons: truncates the stack back
  /// to the requested step instead of pushing a duplicate on top.
  void _jumpTo(String key) {
    setState(() {
      final idx = _stack.indexOf(key);
      if (idx != -1) {
        _stack.removeRange(idx + 1, _stack.length);
      } else {
        _stack.add(key);
      }
    });
  }

  // ---- Step transition handlers -----------------------------------

  void _onMethodChosen(String method) {
    selection.method = method;
    selection.resetAddress();
    // This is the branch point: GPS goes to the locating screen, manual
    // entry skips straight to picking the governorate by hand.
    if (selection.isManual) {
      _push('governorate');
    } else {
      _push('locating');
    }
  }

  void _onGpsCaptured() {
    // Latitude/longitude/capturedAt were already written onto `selection`
    // by GpsLocatingScreen. The reverse-geocoded address is pre-filled but
    // still editable on the following screens.
    _push('governorate');
  }

  void _onGpsCancelled() => _jumpTo('method');

  void _onGovernorateChosen(String g) {
    selection.governorate = g;
    selection.region = null;
    selection.streetNeighborhood = null;
    _push('region');
  }

  void _onRegionChosen(String r) {
    selection.region = r;
    selection.streetNeighborhood = null;
    _push('street');
  }

  void _onStreetChosen(String s) {
    selection.streetNeighborhood = s;
    _push('landmark');
  }

  void _onLandmarkChosen(String l) {
    selection.landmark = l;
    _push('review');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(onPressed: _back, icon: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  Expanded(
                    child: StepProgressBar(steps: _visibleSteps, currentIndex: _currentIndex),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(begin: const Offset(0.12, 0), end: Offset.zero)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey(_current),
                  child: _buildStep(_current),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String key) {
    switch (key) {
      case 'method':
        return SelectCitizenLocation(selection: selection, onNext: _onMethodChosen);
      case 'locating':
        return GpsLocatingScreen(
          selection: selection,
          onCaptured: _onGpsCaptured,
          onCancel: _onGpsCancelled,
        );
      case 'governorate':
        return SelectGovernorateScreen(selection: selection, onNext: _onGovernorateChosen);
      case 'region':
        return SelectRegionScreen(selection: selection, onNext: _onRegionChosen);
      case 'street':
        return SelectStreetScreen(selection: selection, onNext: _onStreetChosen);
      case 'landmark':
        return SelectLandmarkScreen(selection: selection, onNext: _onLandmarkChosen);
      case 'review':
        return ReviewScreen(selection: selection, onEditStep: _jumpTo);
      default:
        return const SizedBox.shrink();
    }
  }
}

// ============================================================
// Shared step layout (title/subtitle/illustration/body/footer)
// ============================================================
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0B1E4A))),
                const SizedBox(height: 8),
                Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 20),
                illustration,
                const SizedBox(height: 20),
                body,
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 16), child: footer),
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;
  const NextButton({super.key, required this.enabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enabled ? onPressed : null,
      icon: const Icon(Icons.arrow_back_ios_new, size: 14),
      label: const Text('التالي'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: const Color(0xFF1657D6),
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFFB9C8EA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class StepProgressBar extends StatelessWidget {
  final List<StepDef> steps;
  final int currentIndex;

  const StepProgressBar({super.key, required this.steps, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final safeIndex = currentIndex < 0 ? 0 : currentIndex;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        children: List.generate(steps.length, (i) {
          final isDone = i < safeIndex;
          final isCurrent = i == safeIndex;
          final circle = Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDone ? const Color(0xFF1657D6) : Colors.white,
              border: Border.all(
                color: isDone || isCurrent ? const Color(0xFF1657D6) : const Color(0xFFD3DCEC),
                width: 2,
              ),
            ),
            child: isDone
                ? const Icon(Icons.check, size: 15, color: Colors.white)
                : isCurrent
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1657D6)),
                        ),
                      )
                    : null,
          );

          final label = SizedBox(
            width: 58,
            child: Text(
              steps[i].label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isCurrent ? const Color(0xFF1657D6) : (isDone ? Colors.black87 : Colors.grey),
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );

          final node = Column(mainAxisSize: MainAxisSize.min, children: [circle, const SizedBox(height: 4), label]);

          if (i == steps.length - 1) return node;

          final connector = Container(
            width: 22,
            height: 2,
            margin: const EdgeInsets.only(bottom: 18),
            color: i < safeIndex ? const Color(0xFF1657D6) : const Color(0xFFD3DCEC),
          );

          return Row(children: [node, connector]);
        }),
      ),
    );
  }
}
