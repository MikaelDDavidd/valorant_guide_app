import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/agents/data/datasources/agent_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/repositories/i_agent_repository.dart';

class AgentRepositoryImpl implements IAgentRepository {
  final IAgentRemoteDataSource remoteDataSource;

  AgentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AgentEntity>>> getAgents() async {
    try {
      final result = await remoteDataSource.getAgents();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentEntity>> getAgentById(String uuid) async {
    try {
      final result = await remoteDataSource.getAgentById(uuid);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
