import 'dart:convert';
import 'package:valorant_guide_app/app/constants/app_assets.dart';
import 'package:valorant_guide_app/app/data/http/exceptions.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/models/weapons.dart';

abstract class iWeaponRepository {
  Future<List<WeaponData>> getWeapons();
}

class WeaponRepository implements iWeaponRepository {
  final IHttpClient client;

  WeaponRepository({required this.client});

  @override
  Future<List<WeaponData>> getWeapons() async {
    final response = await client.get(url: AppAssets.weaponsEndPont);

    if (response.statusCode == 200) {
      final List<WeaponData> weapons = [];
      final body = jsonDecode(response.body);

      body['data'].map((item) {
        final WeaponData weapon = WeaponData.fromMap(item);
        weapons.add(weapon);
      }).toList();

      return weapons;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('não foi possivel carregar os produtos');
    }
  }
}
