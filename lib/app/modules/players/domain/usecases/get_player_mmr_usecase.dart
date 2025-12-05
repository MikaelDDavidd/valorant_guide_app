import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';
import 'package:valorant_guide_app/app/modules/players/domain/repositories/i_player_repository.dart';

class GetPlayerMmrUseCase
    implements UseCase<PlayerMmrEntity, GetPlayerMmrParams> {
  final IPlayerRepository repository;

  GetPlayerMmrUseCase(this.repository);

  @override
  Future<Either<Failure, PlayerMmrEntity>> call(GetPlayerMmrParams params) {
    return repository.getPlayerMmr(params.region, params.name, params.tag);
  }
}

class GetPlayerMmrParams extends Equatable {
  final String region;
  final String name;
  final String tag;

  const GetPlayerMmrParams({
    required this.region,
    required this.name,
    required this.tag,
  });

  @override
  List<Object?> get props => [region, name, tag];
}
