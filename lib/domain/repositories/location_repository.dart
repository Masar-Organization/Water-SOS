import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/domain/entities/governorate_entity.dart';
import 'package:water_sos/domain/entities/gps_position_entity.dart';
import 'package:water_sos/domain/entities/location_entity.dart';
import 'package:water_sos/domain/entities/region_entity.dart';
import 'package:water_sos/domain/entities/street_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<GovernorateEntity>>> getGovernorates();

  Future<Either<Failure, List<RegionEntity>>> getRegions(String governorateId);

  Future<Either<Failure, List<StreetEntity>>> getStreets(String regionId);

  Future<Either<Failure, GpsPositionEntity>> getCurrentGpsPosition();

  Future<Either<Failure, LocationEntity>> reverseGeocode(GpsPositionEntity position);

  Future<Either<Failure, void>> confirmLocation(LocationEntity location);
}
