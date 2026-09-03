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
