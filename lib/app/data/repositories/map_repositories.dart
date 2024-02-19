import 'dart:convert';
import 'package:valorant_guide_app/app/constants/app_assets.dart';
import 'package:valorant_guide_app/app/data/http/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/models/maps.dart';

abstract class iMapRepository {
  Future<List<MapData>> getMaps();
}

class MapRepository implements iMapRepository {
  final IHttpClient client;

  MapRepository({required this.client});

  @override
  Future<List<MapData>> getMaps() async {
    final response = await client.get(url: AppAssets.mapsEndPoint);

    if (response.statusCode == 200) {
      final List<MapData> maps = [];
      final body = jsonDecode(response.body);

      body['data'].map((item) {
        final MapData map = MapData.fromJson(item);
        maps.add(map);
      }).toList();

      return maps;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('não foi possivel carregar os produtos');
    }
  }
}
