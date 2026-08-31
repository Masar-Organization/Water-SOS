import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/domain/entities/location_entity.dart';
import 'package:water_sos/domain/repositories/location_repository.dart';

class ConfirmLocation implements UseCase<void, LocationEntity> {
  final LocationRepository repository;
  const ConfirmLocation(this.repository);

  @override
  Future<Either<Failure, void>> call(LocationEntity params) {
    if (!params.isComplete) {
      return Future.value(const Left(InvalidAddressSelectionFailure()));
    }
    return repository.confirmLocation(params);
  }
}
