import 'package:water_sos/domain/entities/gps_position_entity.dart';
import 'package:water_sos/domain/entities/governorate_entity.dart';
import 'package:water_sos/domain/entities/location_method.dart';
import 'package:water_sos/domain/entities/region_entity.dart';
import 'package:water_sos/domain/entities/street_entity.dart';

/// The full address the flow is building, regardless of whether it was
/// reached via GPS or manual entry. `gpsPosition` is only non-null when
/// [method] is [LocationMethod.gps].
class LocationEntity {
  final LocationMethod method;
  final GpsPositionEntity? gpsPosition;
  final GovernorateEntity? governorate;
  final RegionEntity? region;
  final StreetEntity? street;
  final String? landmark;

  const LocationEntity({
    required this.method,
    this.gpsPosition,
    this.governorate,
    this.region,
    this.street,
    this.landmark,
  });

  bool get isComplete => governorate != null && region != null && street != null;

  LocationEntity copyWith({
    LocationMethod? method,
    GpsPositionEntity? gpsPosition,
    GovernorateEntity? governorate,
    RegionEntity? region,
    StreetEntity? street,
    String? landmark,
  }) {
    return LocationEntity(
      method: method ?? this.method,
      gpsPosition: gpsPosition ?? this.gpsPosition,
      governorate: governorate ?? this.governorate,
      region: region ?? this.region,
      street: street ?? this.street,
      landmark: landmark ?? this.landmark,
    );
  }
}
