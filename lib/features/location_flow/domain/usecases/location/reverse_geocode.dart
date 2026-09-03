import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/features/location_flow/domain/entities/gps_position_entity.dart';
import 'package:water_sos/features/location_flow/domain/entities/location_entity.dart';
import 'package:water_sos/features/location_flow/domain/repositories/location_repository.dart';

class ReverseGeocodeParams {
  final GpsPositionEntity position;
  const ReverseGeocodeParams({required this.position});
}

class ReverseGeocode implements UseCase<LocationEntity, ReverseGeocodeParams> {
  final LocationRepository repository;
  const ReverseGeocode(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(ReverseGeocodeParams params) {
    return repository.reverseGeocode(params.position);
  }
}
