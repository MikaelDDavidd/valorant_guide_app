import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/data/repositories/weapon_repositories.dart';
import 'package:valorant_guide_app/app/data/stores/weapons_store.dart';

class WeaponController extends GetxController {
  RxInt homeThemeIndex = AppValues().themIndexValue.obs;
  final WeaponsStore store = WeaponsStore(
    repository: WeaponRepository(
      client: HttpClient(),
    ),
  );

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    store.getWeapons();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
