import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/repositories/i_agent_repository.dart';

class GetAgentByIdUseCase implements UseCase<AgentEntity, AgentParams> {
  final IAgentRepository repository;

  GetAgentByIdUseCase(this.repository);

  @override
  Future<Either<Failure, AgentEntity>> call(AgentParams params) {
    return repository.getAgentById(params.uuid);
  }
}

class AgentParams extends Equatable {
  final String uuid;

  const AgentParams({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
