import 'package:flutter/foundation.dart';
import 'package:valorant_guide_app/app/data/http/exceptions.dart';
import 'package:valorant_guide_app/app/data/repositories/map_repositories.dart';
import 'package:valorant_guide_app/app/models/agent.dart';
import 'package:valorant_guide_app/app/models/maps.dart';

class MapsStore {
  final iMapRepository repository;

  // var relative to loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // var relative to state
  final ValueNotifier<List<MapData>> state = ValueNotifier<List<MapData>>([]);

  // var relative to error
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  MapsStore({required this.repository});

  Future getMaps() async {
    isLoading.value = true;

    try {
      final result = await repository.getMaps();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
