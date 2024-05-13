import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/data/repositories/map_repositories.dart';
import 'package:valorant_guide_app/app/data/stores/maps_store.dart';

class MapsController extends GetxController {
  RxInt homeThemeIndex = AppValues().themIndexValue.obs;
  final MapsStore store = MapsStore(
    repository: MapRepository(
      client: HttpClient(),
    ),
  );

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    store.getMaps();
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
