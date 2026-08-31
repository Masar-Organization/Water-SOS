import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:water_sos/data/dummy_data.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/presentation/widgets/location_flow/info_banner.dart';
import 'package:water_sos/presentation/widgets/location_flow/review_tile.dart';
import 'package:water_sos/presentation/widgets/custom_elevated_button.dart';
import 'package:water_sos/presentation/widgets/custom_outlined_button.dart';
import 'package:water_sos/presentation/widgets/location_flow/step_scaffold.dart';
import 'package:water_sos/presentation/widgets/location_flow/tips_box.dart';

enum _GpsState {
  locating,
  success,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  timedOut,
  error,
}

class GpsLocatingScreen extends StatefulWidget {
  final LocationSelection selection;
  final VoidCallback onCaptured;
  final VoidCallback onCancel;

  const GpsLocatingScreen({
    super.key,
    required this.selection,
    required this.onCaptured,
    required this.onCancel,
  });

  @override
  State<GpsLocatingScreen> createState() => _GpsLocatingScreenState();
}

class _GpsLocatingScreenState extends State<GpsLocatingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  _GpsState _state = _GpsState.locating;
  String? _errorDetail;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _startLocating();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startLocating() async {
    setState(() => _state = _GpsState.locating);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _state = _GpsState.serviceDisabled);
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _state = _GpsState.permissionDenied);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() => _state = _GpsState.permissionDeniedForever);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 20));

      widget.selection.latitude = position.latitude;
      widget.selection.longitude = position.longitude;
      widget.selection.capturedAt = DateTime.now();

      final geocoded = DummyData.reverseGeocode(
        position.latitude,
        position.longitude,
      );
      widget.selection.governorate = geocoded.governorate;
      widget.selection.region = geocoded.region;
      widget.selection.streetNeighborhood = geocoded.street;

      if (!mounted) return;
      setState(() => _state = _GpsState.success);

      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) widget.onCaptured();
    } on TimeoutException {
      if (mounted) setState(() => _state = _GpsState.timedOut);
    } catch (e) {
      if (mounted) {
        setState(() {
          _state = _GpsState.error;
          _errorDetail = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = _state == _GpsState.locating || _state == _GpsState.success;

    return StepScaffold(
      title: isBusy ? 'جاري تحديد موقعك...' : 'تعذر تحديد موقعك',
      subtitle: _subtitleFor(_state),
      illustration: isBusy
          ? _pulsingLocationIcon()
          : const Icon(Icons.location_off, size: 90, color: Colors.redAccent),
      body: isBusy
          ? const TipsBox(
              title: 'نصائح للحصول على نتائج أدق',
              tips: [
                (Icons.location_on, 'تأكد من تفعيل خدمة تحديد الموقع (GPS)'),
                (Icons.wb_sunny, 'أخرج إلى مكان مفتوح للحصول على إشارة أفضل'),
                (Icons.wifi, 'تحقق من اتصال الإنترنت'),
              ],
            )
          : InfoBanner(
              title: 'السبب',
              text: _errorDetail ?? _subtitleFor(_state),
            ),
      footer: isBusy
          ? CustomOutlinedButton(onPressed: widget.onCancel, text: 'إلغاء')
          : Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: widget.onCancel,
                    text: 'إدخال العنوان يدوياً',
                  ),
                ),

                Expanded(
                  child: CustomElevatedButton(text: 'إعادة المحاولة', onPressed: _startLocating,)


                ),
              ],
            ),
    );
  }

  String _subtitleFor(_GpsState state) {
    switch (state) {
      case _GpsState.locating:
        return 'يرجى الانتظار بينما نحصل على موقعك الحالي عبر نظام GPS';
      case _GpsState.success:
        return 'تم تحديد موقعك بنجاح';
      case _GpsState.serviceDisabled:
        return 'خدمة تحديد الموقع (GPS) غير مفعّلة على جهازك. فعّلها ثم أعد المحاولة';
      case _GpsState.permissionDenied:
        return 'تم رفض إذن الوصول للموقع. يرجى السماح بالوصول للموقع للمتابعة';
      case _GpsState.permissionDeniedForever:
        return 'إذن الموقع مرفوض بشكل دائم. افتح إعدادات التطبيق لتفعيله';
      case _GpsState.timedOut:
        return 'استغرق تحديد الموقع وقتاً طويلاً. تحقق من الإشارة وأعد المحاولة';
      case _GpsState.error:
        return 'حدث خطأ أثناء محاولة تحديد موقعك';
    }
  }

  Widget _pulsingLocationIcon() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (final scale in [0.4, 0.65, 0.9, 1.0])
                Opacity(
                  opacity: (1 - ((_pulseController.value + scale) % 1.0)) * 0.5,
                  child: Container(
                    width: 200 * ((_pulseController.value + scale) % 1.0),
                    height: 200 * ((_pulseController.value + scale) % 1.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1657D6),
                    ),
                  ),
                ),
              Icon(
                _state == _GpsState.success
                    ? Icons.check_circle
                    : Icons.location_on,
                size: 46,
                color: _state == _GpsState.success
                    ? Colors.green
                    : const Color(0xFF1657D6),
              ),
            ],
          ),
        );
      },
    );
  }
}
