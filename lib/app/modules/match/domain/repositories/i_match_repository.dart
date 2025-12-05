import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

abstract class IMatchRepository {
  Future<Either<Failure, MatchEntity>> getMatchDetails(String matchId);
}
