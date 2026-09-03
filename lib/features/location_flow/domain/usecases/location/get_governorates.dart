import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/features/location_flow/domain/entities/governorate_entity.dart';
import 'package:water_sos/features/location_flow/domain/repositories/location_repository.dart';

class GetGovernorates implements UseCase<List<GovernorateEntity>, NoParams> {
  final LocationRepository repository;
  const GetGovernorates(this.repository);

  @override
  Future<Either<Failure, List<GovernorateEntity>>> call(NoParams params) {
    return repository.getGovernorates();
  }
}
