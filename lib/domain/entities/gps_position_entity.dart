/// What a successful GPS fix looks like at the domain level. `capturedAt`
/// is the "captured_at" moment the fix was obtained — kept alongside the
/// coordinates so it can be persisted/displayed later, not derived at
/// display time.
class GpsPositionEntity {
  final double latitude;
  final double longitude;
  final DateTime capturedAt;
  final double? accuracyMeters;

  const GpsPositionEntity({
    required this.latitude,
    required this.longitude,
    required this.capturedAt,
    this.accuracyMeters,
  });

  @override
  bool operator ==(Object other) =>
      other is GpsPositionEntity &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.capturedAt == capturedAt;

  @override
  int get hashCode => Object.hash(latitude, longitude, capturedAt);
}
