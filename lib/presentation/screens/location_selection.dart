/// Holds everything collected across the location-picking flow.
///
/// [method] is either the GPS option or the manual-entry option
/// (see `DummyData.methods` in `location_flow_screen.dart`).
/// When the user picks GPS, [latitude]/[longitude]/[capturedAt] are filled
/// in by `GpsLocatingScreen`. When the user picks manual entry, those three
/// stay null and the address fields below are filled in by hand instead.
class LocationSelection {
  String? method;

  // Populated only when the location was captured via GPS.
  double? latitude;
  double? longitude;
  DateTime? capturedAt;

  // Address fields — filled either automatically (reverse-geocoded after a
  // GPS capture) or manually by the user, and always editable afterwards.
  String? governorate;
  String? region;
  String? streetNeighborhood;
  String? landmark;

  bool get isManual => method != null && method!.contains('يدوي');
  bool get isGps => method != null && method!.contains('GPS');
  bool get wasCapturedByGps => capturedAt != null;

  bool get hasBasics =>
      governorate != null && region != null && streetNeighborhood != null;

  /// Clears everything that was derived from a previous GPS fix or a
  /// previous manual selection, used when the user changes method mid-flow.
  void resetAddress() {
    latitude = null;
    longitude = null;
    capturedAt = null;
    governorate = null;
    region = null;
    streetNeighborhood = null;
  }
}
