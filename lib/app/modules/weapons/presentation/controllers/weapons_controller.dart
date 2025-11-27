import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/usecases/get_weapons_usecase.dart';

class WeaponsController extends GetxController {
  final GetWeaponsUseCase getWeaponsUseCase;

  WeaponsController({required this.getWeaponsUseCase});

  final weapons = <WeaponEntity>[].obs;
  final isLoading = false.obs;
  final error = Rxn<String>();
  final homeThemeIndex = AppValues().themIndexValue.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeapons();
  }

  Future<void> fetchWeapons() async {
    isLoading.value = true;
    error.value = null;

    final result = await getWeaponsUseCase(NoParams());

    result.fold(
      (failure) => error.value = failure.message,
      (data) => weapons.value = data,
    );

    isLoading.value = false;
  }

  void updateThemeIndex(int index) {
    homeThemeIndex.value = index;
  }
}
