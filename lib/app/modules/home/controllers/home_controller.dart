import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/models/agent.dart';

class HomeController extends GetxController {
  RxInt homeThemeIndex = AppValues().themIndexValue.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
