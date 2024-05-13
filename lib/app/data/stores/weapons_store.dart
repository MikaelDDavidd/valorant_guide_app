import 'package:flutter/foundation.dart';
import 'package:valorant_guide_app/app/data/http/exceptions.dart';
import 'package:valorant_guide_app/app/data/repositories/weapon_repositories.dart';
import 'package:valorant_guide_app/app/models/weapons.dart';

class WeaponsStore {
  final iWeaponRepository repository;

  // var relative to loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // var relative to state
  final ValueNotifier<List<WeaponData>> state = ValueNotifier<List<WeaponData>>([]);

  // var relative to error
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  WeaponsStore({required this.repository});

  Future getWeapons() async {
    isLoading.value = true;

    try {
      final result = await repository.getWeapons();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
