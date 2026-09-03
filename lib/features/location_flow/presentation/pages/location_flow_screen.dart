import 'package:flutter/material.dart';
import 'package:water_sos/core/design_system/app_color/app_gradients.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/core/extension/opacity_of_color.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';
import 'package:water_sos/features/location_flow/presentation/pages/select_citizen_location.dart';
import 'package:water_sos/features/location_flow/presentation/pages/gps_locating_screen.dart';
import 'package:water_sos/features/location_flow/presentation/pages/select_governorate_screen.dart';
import 'package:water_sos/features/location_flow/presentation/pages/select_region_screen.dart';
import 'package:water_sos/features/location_flow/presentation/pages/select_street_screen.dart';
import 'package:water_sos/features/location_flow/presentation/pages/select_landmark_screen.dart';
import 'package:water_sos/features/location_flow/presentation/pages/review_screen.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_progress_bar.dart';

class LocationFlowScreen extends StatefulWidget {
  const LocationFlowScreen({super.key});

  @override
  State<LocationFlowScreen> createState() => _LocationFlowScreenState();
}

class _LocationFlowScreenState extends State<LocationFlowScreen> {
  final LocationSelection selection = LocationSelection();
  final List<String> _stack = ['method'];

  String get _current => _stack.last;

  List<StepDef> get _visibleSteps =>
      selection.isManual ? kManualSteps : kAllSteps;

  int get _currentIndex => _visibleSteps.indexWhere((s) => s.key == _current);

  void _push(String key) => setState(() => _stack.add(key));

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
    final color = context.colors;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.background),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.waterGlow,
                ),
              ),
            ),

            Positioned(
              top: 180,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.primaryColor.changeOpacity(0.06),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                spacing: context.height(8),
                children: [
                  Padding(
                    padding: context.spaceSymmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: StepProgressBar(
                      steps: _visibleSteps,
                      currentIndex: _currentIndex,
                    ),
                  ),

                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 520),
                      transitionBuilder: (child, animation) {
                        final slide =
                            Tween<Offset>(
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
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String key) {
    switch (key) {
      case 'method':
        return SelectCitizenLocation(
          selection: selection,
          onNext: _onMethodChosen,
        );
      case 'locating':
        return GpsLocatingScreen(
          selection: selection,
          onCaptured: _onGpsCaptured,
          onCancel: _onGpsCancelled,
        );
      case 'governorate':
        return SelectGovernorateScreen(
          selection: selection,
          onNext: _onGovernorateChosen,
        );
      case 'region':
        return SelectRegionScreen(
          selection: selection,
          onNext: _onRegionChosen,
        );
      case 'street':
        return SelectStreetScreen(
          selection: selection,
          onNext: _onStreetChosen,
        );
      case 'landmark':
        return SelectLandmarkScreen(
          selection: selection,
          onNext: _onLandmarkChosen,
        );
      case 'review':
        return ReviewScreen(selection: selection, onEditStep: _jumpTo);
      default:
        return const SizedBox.shrink();
    }
  }
}
