import 'package:flutter/material.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/opacity_of_color.dart';
import 'package:water_sos/data/dummy_data.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/presentation/inner_screens/select_citizen_location.dart';
import 'package:water_sos/presentation/inner_screens/gps_locating_screen.dart';
import 'package:water_sos/presentation/inner_screens/select_governorate_screen.dart';
import 'package:water_sos/presentation/inner_screens/select_region_screen.dart';
import 'package:water_sos/presentation/inner_screens/select_street_screen.dart';
import 'package:water_sos/presentation/inner_screens/select_landmark_screen.dart';
import 'package:water_sos/presentation/inner_screens/review_screen.dart';




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


  void _onMethodChosen(String method) {
    selection.method = method;
    selection.resetAddress();
    if (selection.isManual) {
      _push('governorate');
    } else {
      _push('locating');
    }
  }

  void _onGpsCaptured() => _push('governorate');
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8FAFF),
              Color(0xFFF5FDFF),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // 🌊 Decorative water wave
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00C2E0).changeOpacity(0.18),
                      Color(0xFF0077C8).changeOpacity(0.04),
                    ],
                  ),
                ),
              ),
            ),

            // 💧 Small decorative bubble
            Positioned(
              top: 180,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00C2E0).changeOpacity(0.06),
                ),
              ),
            ),

            SafeArea(
              child:    Column(
                spacing: context.height(8),
                children: [
                  Padding(
                    padding:context.spaceSymmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _back,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                          ),
                        ),
                        Expanded(
                          child: StepProgressBar(
                            steps: _visibleSteps,
                            currentIndex: _currentIndex,
                          ),
                        ),
                      ],
                    ),
                  ),



                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 320),
                      transitionBuilder: (child, animation) {
                        final slide = Tween<Offset>(
                          begin: const Offset(0.12, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        );

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: slide,
                            child: child,
                          ),
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
