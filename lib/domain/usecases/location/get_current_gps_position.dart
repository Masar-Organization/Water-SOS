import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/domain/entities/gps_position_entity.dart';
import 'package:water_sos/domain/repositories/location_repository.dart';

/// Wraps `LocationRepository.getCurrentGpsPosition`. This is what
/// `GpsLocatingScreen` should call instead of talking to `Geolocator`
/// directly — the repository implementation owns the service-check /
/// permission-request / timeout dance and maps every failure mode to a
/// `Location*Failure`.
class GetCurrentGpsPosition implements UseCase<GpsPositionEntity, NoParams> {
  final LocationRepository repository;
  const GetCurrentGpsPosition(this.repository);

  @override
  Future<Either<Failure, GpsPositionEntity>> call(NoParams params) {
    return repository.getCurrentGpsPosition();
  }
}
