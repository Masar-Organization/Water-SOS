import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/domain/entities/region_entity.dart';
import 'package:water_sos/domain/repositories/location_repository.dart';

class GetRegionsParams {
  final String governorateId;
  const GetRegionsParams({required this.governorateId});
}

class GetRegions implements UseCase<List<RegionEntity>, GetRegionsParams> {
  final LocationRepository repository;
  const GetRegions(this.repository);

  @override
  Future<Either<Failure, List<RegionEntity>>> call(GetRegionsParams params) {
    return repository.getRegions(params.governorateId);
  }
}
