import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';
import 'package:valorant_guide_app/app/modules/players/domain/repositories/i_player_repository.dart';

class GetPlayerMatchesUseCase
    implements UseCase<List<PlayerMatchEntity>, GetPlayerMatchesParams> {
  final IPlayerRepository repository;

  GetPlayerMatchesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PlayerMatchEntity>>> call(
    GetPlayerMatchesParams params,
  ) {
    return repository.getPlayerMatches(
      params.region,
      params.name,
      params.tag,
      size: params.size,
    );
  }
}

class GetPlayerMatchesParams extends Equatable {
  final String region;
  final String name;
  final String tag;
  final int size;

  const GetPlayerMatchesParams({
    required this.region,
    required this.name,
    required this.tag,
    this.size = 5,
  });

  @override
  List<Object?> get props => [region, name, tag, size];
}
