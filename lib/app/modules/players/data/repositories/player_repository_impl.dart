import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/players/data/datasources/player_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';
import 'package:valorant_guide_app/app/modules/players/domain/repositories/i_player_repository.dart';

class PlayerRepositoryImpl implements IPlayerRepository {
  final IPlayerRemoteDataSource remoteDataSource;

  PlayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PlayerAccountEntity>> getPlayerAccount(
    String name,
    String tag,
  ) async {
    try {
      final result = await remoteDataSource.getPlayerAccount(name, tag);
      return Right(result.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on RateLimitException catch (e) {
      return Left(RateLimitFailure(e.message, retryAfter: e.retryAfter));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerMmrEntity>> getPlayerMmr(
    String region,
    String name,
    String tag,
  ) async {
    try {
      final result = await remoteDataSource.getPlayerMmr(region, name, tag);
      return Right(result.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on RateLimitException catch (e) {
      return Left(RateLimitFailure(e.message, retryAfter: e.retryAfter));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlayerMatchEntity>>> getPlayerMatches(
    String region,
    String name,
    String tag, {
    int size = 5,
  }) async {
    try {
      final accountResult = await remoteDataSource.getPlayerAccount(name, tag);
      final puuid = accountResult.puuid;

      final result = await remoteDataSource.getPlayerMatches(
        region,
        name,
        tag,
        size: size,
      );
      return Right(result.map((model) => model.toEntity(puuid)).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on RateLimitException catch (e) {
      return Left(RateLimitFailure(e.message, retryAfter: e.retryAfter));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
