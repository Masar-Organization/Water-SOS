import 'package:dartz/dartz.dart';
import 'package:water_sos/core/error/failures.dart';
import 'package:water_sos/core/usecases/usecase.dart';
import 'package:water_sos/features/location_flow/domain/entities/street_entity.dart';
import 'package:water_sos/features/location_flow/domain/repositories/location_repository.dart';

class GetStreetsParams {
  final String regionId;
  const GetStreetsParams({required this.regionId});
}

class GetStreets implements UseCase<List<StreetEntity>, GetStreetsParams> {
  final LocationRepository repository;
  const GetStreets(this.repository);

  @override
  Future<Either<Failure, List<StreetEntity>>> call(GetStreetsParams params) {
    return repository.getStreets(params.regionId);
  }
}
