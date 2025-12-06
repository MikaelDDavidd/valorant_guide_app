import 'dart:convert';
import 'dart:developer' as dev;
import 'package:valorant_guide_app/app/core/constants/api_constants.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/match/data/models/match_model.dart';

abstract class IMatchRemoteDataSource {
  Future<MatchModel> getMatchDetails(String matchId);
}

class MatchRemoteDataSource implements IMatchRemoteDataSource {
  final IHttpClient client;

  MatchRemoteDataSource({required this.client});

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
  Future<MatchModel> getMatchDetails(String matchId) async {
    final url = '${ApiConstants.henrikBaseUrl}${ApiConstants.matchDetailEndpoint}/$matchId';
    dev.log('🔍 [MatchDataSource] GET Match Details: $url');

    try {
      final response = await client.get(url: url, headers: _headers);
      dev.log('📥 [MatchDataSource] Match Details Response Status: ${response.statusCode}');
      dev.log('📥 [MatchDataSource] Match Details Response Body: ${response.body}');

      return _handleResponse<MatchModel>(
        response,
        (data) => MatchModel.fromJson(data),
        'Partida não encontrada',
      );
    } catch (e, stack) {
      dev.log('❌ [MatchDataSource] Match Details Error: $e');
      dev.log('❌ [MatchDataSource] Stack: $stack');
      rethrow;
    }
  }

  T _handleResponse<T>(
    dynamic response,
    T Function(dynamic data) parser,
    String notFoundMessage,
  ) {
    final statusCode = response.statusCode;

    if (response.body.isEmpty) {
      throw ServerException(message: 'Empty response from server', statusCode: statusCode);
    }

    final body = jsonDecode(response.body);

    if (statusCode == 200) {
      if (body['data'] == null) {
        throw ServerException(message: 'Data is null', statusCode: statusCode);
      }
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
