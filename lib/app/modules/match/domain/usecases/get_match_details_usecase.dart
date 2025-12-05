import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';
import 'package:valorant_guide_app/app/modules/match/domain/repositories/i_match_repository.dart';

class GetMatchDetailsUseCase implements UseCase<MatchEntity, String> {
  final IMatchRepository repository;

  GetMatchDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, MatchEntity>> call(String params) async {
    return await repository.getMatchDetails(params);
  }
}
