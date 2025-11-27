import 'dart:convert';
import 'package:valorant_guide_app/app/core/constants/api_constants.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/agents/data/models/agent_model.dart';

abstract class IAgentRemoteDataSource {
  Future<List<AgentModel>> getAgents();
  Future<AgentModel> getAgentById(String uuid);
}

class AgentRemoteDataSource implements IAgentRemoteDataSource {
  final IHttpClient client;

  AgentRemoteDataSource({required this.client});

  @override
  Future<List<AgentModel>> getAgents() async {
    const url =
        '${ApiConstants.baseUrl}${ApiConstants.agentsEndpoint}?isPlayableCharacter=true&language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<AgentModel> agents = (body['data'] as List)
          .map((item) => AgentModel.fromJson(item))
          .toList();
      return agents;
    } else {
      throw ServerException(
        message: 'Failed to load agents',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<AgentModel> getAgentById(String uuid) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.agentsEndpoint}/$uuid?language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return AgentModel.fromJson(body['data']);
    } else {
      throw ServerException(
        message: 'Failed to load agent',
        statusCode: response.statusCode,
      );
    }
  }
}
