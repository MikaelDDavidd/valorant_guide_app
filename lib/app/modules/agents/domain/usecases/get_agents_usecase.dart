import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/repositories/i_agent_repository.dart';

class GetAgentsUseCase implements UseCase<List<AgentEntity>, NoParams> {
  final IAgentRepository repository;

  GetAgentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AgentEntity>>> call(NoParams params) {
    return repository.getAgents();
  }
}
