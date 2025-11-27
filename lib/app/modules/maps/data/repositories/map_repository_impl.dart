import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/maps/data/datasources/map_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/repositories/i_map_repository.dart';

class MapRepositoryImpl implements IMapRepository {
  final IMapRemoteDataSource remoteDataSource;

  MapRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MapEntity>>> getMaps() async {
    try {
      final result = await remoteDataSource.getMaps();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MapEntity>> getMapById(String uuid) async {
    try {
      final result = await remoteDataSource.getMapById(uuid);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
