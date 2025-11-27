import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/datasources/weapon_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/repositories/i_weapon_repository.dart';

class WeaponRepositoryImpl implements IWeaponRepository {
  final IWeaponRemoteDataSource remoteDataSource;

  WeaponRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WeaponEntity>>> getWeapons() async {
    try {
      final result = await remoteDataSource.getWeapons();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WeaponEntity>> getWeaponById(String uuid) async {
    try {
      final result = await remoteDataSource.getWeaponById(uuid);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
