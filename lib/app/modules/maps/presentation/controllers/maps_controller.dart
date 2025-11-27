import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/usecases/get_maps_usecase.dart';

class MapsController extends GetxController {
  final GetMapsUseCase getMapsUseCase;

  MapsController({required this.getMapsUseCase});

  final maps = <MapEntity>[].obs;
  final isLoading = false.obs;
  final error = Rxn<String>();
  final homeThemeIndex = AppValues().themIndexValue.obs;

  static const String _excludedMapUuid = 'ee613ee9-28b7-4beb-9666-08db13bb2244';

  List<MapEntity> get filteredMaps =>
      maps.where((map) => map.uuid != _excludedMapUuid).toList();

  @override
  void onInit() {
    super.onInit();
    fetchMaps();
  }

  Future<void> fetchMaps() async {
    isLoading.value = true;
    error.value = null;

    final result = await getMapsUseCase(NoParams());

    result.fold(
      (failure) => error.value = failure.message,
      (data) => maps.value = data,
    );

    isLoading.value = false;
  }

  void updateThemeIndex(int index) {
    homeThemeIndex.value = index;
  }
}
