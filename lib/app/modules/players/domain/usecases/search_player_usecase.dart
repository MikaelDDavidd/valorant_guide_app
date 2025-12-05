import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';
import 'package:valorant_guide_app/app/modules/players/domain/repositories/i_player_repository.dart';

class SearchPlayerUseCase
    implements UseCase<PlayerAccountEntity, SearchPlayerParams> {
  final IPlayerRepository repository;

  SearchPlayerUseCase(this.repository);

  @override
  Future<Either<Failure, PlayerAccountEntity>> call(
    SearchPlayerParams params,
  ) {
    return repository.getPlayerAccount(params.name, params.tag);
  }
}

class SearchPlayerParams extends Equatable {
  final String name;
  final String tag;

  const SearchPlayerParams({
    required this.name,
    required this.tag,
  });

  factory SearchPlayerParams.fromFullName(String fullName) {
    final parts = fullName.split('#');
    if (parts.length != 2) {
      throw ArgumentError('Invalid format. Use Name#Tag');
    }
    return SearchPlayerParams(
      name: parts[0].trim(),
      tag: parts[1].trim(),
    );
  }

  @override
  List<Object?> get props => [name, tag];
}
