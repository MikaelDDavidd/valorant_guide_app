import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/match/data/datasources/match_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';
import 'package:valorant_guide_app/app/modules/match/domain/repositories/i_match_repository.dart';

class MatchRepositoryImpl implements IMatchRepository {
  final IMatchRemoteDataSource remoteDataSource;

  MatchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MatchEntity>> getMatchDetails(String matchId) async {
    try {
      final result = await remoteDataSource.getMatchDetails(matchId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on RateLimitException catch (e) {
      return Left(RateLimitFailure(e.message, retryAfter: e.retryAfter));
    }
  }
}
