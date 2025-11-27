import 'dart:convert';
import 'package:valorant_guide_app/app/core/constants/api_constants.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/maps/data/models/map_model.dart';

abstract class IMapRemoteDataSource {
  Future<List<MapModel>> getMaps();
  Future<MapModel> getMapById(String uuid);
}

class MapRemoteDataSource implements IMapRemoteDataSource {
  final IHttpClient client;

  MapRemoteDataSource({required this.client});

  @override
  Future<List<MapModel>> getMaps() async {
    const url =
        '${ApiConstants.baseUrl}${ApiConstants.mapsEndpoint}?language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<MapModel> maps = (body['data'] as List)
          .map((item) => MapModel.fromJson(item))
          .toList();
      return maps;
    } else {
      throw ServerException(
        message: 'Failed to load maps',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<MapModel> getMapById(String uuid) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.mapsEndpoint}/$uuid?language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return MapModel.fromJson(body['data']);
    } else {
      throw ServerException(
        message: 'Failed to load map',
        statusCode: response.statusCode,
      );
    }
  }
}
