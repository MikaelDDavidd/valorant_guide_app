import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/repositories/i_map_repository.dart';

class GetMapsUseCase implements UseCase<List<MapEntity>, NoParams> {
  final IMapRepository repository;

  GetMapsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MapEntity>>> call(NoParams params) {
    return repository.getMaps();
  }
}
