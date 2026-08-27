import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/domain/entities/governorate_entity.dart';
import 'package:water_sos/domain/entities/gps_position_entity.dart';
import 'package:water_sos/domain/entities/location_entity.dart';
import 'package:water_sos/domain/entities/region_entity.dart';
import 'package:water_sos/domain/entities/street_entity.dart';

/// The domain layer only knows about this contract. The data layer will
/// provide the real implementation (e.g. `LocationRepositoryImpl`) backed
/// by a `GeolocatorDataSource` for GPS and an `AddressRemoteDataSource` /
/// `AddressLocalDataSource` for the governorate/region/street lists —
/// today those lists are the dummy data already in the presentation layer,
/// swapped for a real API later without touching anything above this line.
abstract class LocationRepository {
  /// Full list of governorates.
  Future<Either<Failure, List<GovernorateEntity>>> getGovernorates();

  /// Regions that belong to [governorateId].
  Future<Either<Failure, List<RegionEntity>>> getRegions(String governorateId);

  /// Streets/neighborhoods that belong to [regionId].
  Future<Either<Failure, List<StreetEntity>>> getStreets(String regionId);

  /// Requests the device's current GPS fix. Fails with one of the
  /// `Location*Failure` types (service disabled, permission denied,
  /// permission denied forever, timeout) instead of throwing.
  Future<Either<Failure, GpsPositionEntity>> getCurrentGpsPosition();

  /// Turns a GPS fix into a best-guess governorate/region/street. The
  /// result is always still editable by the citizen afterwards.
  Future<Either<Failure, LocationEntity>> reverseGeocode(GpsPositionEntity position);

  /// Persists the citizen's confirmed location (e.g. sends it to the
  /// backend / saves it locally for the rest of the app to use).
  Future<Either<Failure, void>> confirmLocation(LocationEntity location);
}
