import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';

abstract class IAgentRepository {
  Future<Either<Failure, List<AgentEntity>>> getAgents();
  Future<Either<Failure, AgentEntity>> getAgentById(String uuid);
}
