import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';

class HomeController extends GetxController {
  final homeThemeIndex = AppValues().themIndexValue.obs;
  final currentTabIndex = 0.obs;

  void updateThemeIndex(int index) {
    homeThemeIndex.value = index;
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}
