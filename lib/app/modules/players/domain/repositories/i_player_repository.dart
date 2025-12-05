import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';

abstract class IPlayerRepository {
  Future<Either<Failure, PlayerAccountEntity>> getPlayerAccount(
    String name,
    String tag,
  );

  Future<Either<Failure, PlayerMmrEntity>> getPlayerMmr(
    String region,
    String name,
    String tag,
  );

  Future<Either<Failure, List<PlayerMatchEntity>>> getPlayerMatches(
    String region,
    String name,
    String tag, {
    int size = 5,
  });
}
