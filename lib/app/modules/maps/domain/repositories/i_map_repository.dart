import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';

abstract class IMapRepository {
  Future<Either<Failure, List<MapEntity>>> getMaps();
  Future<Either<Failure, MapEntity>> getMapById(String uuid);
}
