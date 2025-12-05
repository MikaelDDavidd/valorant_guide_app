import 'dart:convert';
import 'dart:developer' as dev;
import 'package:valorant_guide_app/app/core/constants/api_constants.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/players/data/models/player_model.dart';

abstract class IPlayerRemoteDataSource {
  Future<PlayerAccountModel> getPlayerAccount(String name, String tag);
  Future<PlayerMmrModel> getPlayerMmr(String region, String name, String tag);
  Future<List<PlayerMatchModel>> getPlayerMatches(
    String region,
    String name,
    String tag, {
    int size = 5,
  });
}

class PlayerRemoteDataSource implements IPlayerRemoteDataSource {
  final IHttpClient client;

  PlayerRemoteDataSource({required this.client});

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (ApiConstants.henrikApiKey.isNotEmpty) {
      headers['Authorization'] = ApiConstants.henrikApiKey;
    }
    return headers;
  }

  @override
  Future<PlayerAccountModel> getPlayerAccount(String name, String tag) async {
    final url =
        '${ApiConstants.henrikBaseUrl}${ApiConstants.accountEndpoint}/$name/$tag';
    dev.log('🔍 [PlayerDataSource] GET Account: $url');

    try {
      final response = await client.get(url: url, headers: _headers);
      dev.log('📥 [PlayerDataSource] Account Response Status: ${response.statusCode}');
      dev.log('📥 [PlayerDataSource] Account Response Body: ${response.body}');

      return _handleResponse<PlayerAccountModel>(
        response,
        (data) => PlayerAccountModel.fromJson(data),
        'Jogador não encontrado',
      );
    } catch (e, stack) {
      dev.log('❌ [PlayerDataSource] Account Error: $e');
      dev.log('❌ [PlayerDataSource] Stack: $stack');
      rethrow;
    }
  }

  @override
  Future<PlayerMmrModel> getPlayerMmr(
    String region,
    String name,
    String tag,
  ) async {
    final url =
        '${ApiConstants.henrikBaseUrl}${ApiConstants.mmrEndpoint}/$region/$name/$tag';
    dev.log('🔍 [PlayerDataSource] GET MMR: $url');

    final response = await client.get(url: url, headers: _headers);
    dev.log('📥 [PlayerDataSource] MMR Response Status: ${response.statusCode}');

    return _handleResponse<PlayerMmrModel>(
      response,
      (data) => PlayerMmrModel.fromJson(data),
      'Dados de rank não encontrados',
    );
  }

  @override
  Future<List<PlayerMatchModel>> getPlayerMatches(
    String region,
    String name,
    String tag, {
    int size = 5,
  }) async {
    final url =
        '${ApiConstants.henrikBaseUrl}${ApiConstants.matchesEndpoint}/$region/$name/$tag?size=$size';
    dev.log('🔍 [PlayerDataSource] GET Matches: $url');

    final response = await client.get(url: url, headers: _headers);
    dev.log('📥 [PlayerDataSource] Matches Response Status: ${response.statusCode}');

    return _handleResponse<List<PlayerMatchModel>>(
      response,
      (data) => (data as List)
          .map((item) => PlayerMatchModel.fromJson(item))
          .toList(),
      'Partidas não encontradas',
    );
  }

  T _handleResponse<T>(
    dynamic response,
    T Function(dynamic data) parser,
    String notFoundMessage,
  ) {
    final statusCode = response.statusCode;
    final body = jsonDecode(response.body);

    if (statusCode == 200) {
      return parser(body['data']);
    } else if (statusCode == 404) {
      throw NotFoundException(message: notFoundMessage);
    } else if (statusCode == 429) {
      throw RateLimitException(
        message: 'Limite de requisições atingido. Tente novamente em breve.',
        retryAfter: body['retry_after'],
      );
    } else {
      throw ServerException(
        message: body['message'] ?? 'Erro ao carregar dados',
        statusCode: statusCode,
      );
    }
  }
}
