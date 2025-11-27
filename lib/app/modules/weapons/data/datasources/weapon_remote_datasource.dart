import 'dart:convert';
import 'package:valorant_guide_app/app/core/constants/api_constants.dart';
import 'package:valorant_guide_app/app/core/errors/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/models/weapon_model.dart';

abstract class IWeaponRemoteDataSource {
  Future<List<WeaponModel>> getWeapons();
  Future<WeaponModel> getWeaponById(String uuid);
}

class WeaponRemoteDataSource implements IWeaponRemoteDataSource {
  final IHttpClient client;

  WeaponRemoteDataSource({required this.client});

  @override
  Future<List<WeaponModel>> getWeapons() async {
    const url =
        '${ApiConstants.baseUrl}${ApiConstants.weaponsEndpoint}?language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<WeaponModel> weapons = (body['data'] as List)
          .map((item) => WeaponModel.fromJson(item))
          .toList();
      return weapons;
    } else {
      throw ServerException(
        message: 'Failed to load weapons',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<WeaponModel> getWeaponById(String uuid) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.weaponsEndpoint}/$uuid?language=${ApiConstants.language}';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return WeaponModel.fromJson(body['data']);
    } else {
      throw ServerException(
        message: 'Failed to load weapon',
        statusCode: response.statusCode,
      );
    }
  }
}
