import 'package:get/get.dart';

import 'package:valorant_guide_app/app/modules/home/controllers/agent_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/weapon_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeaponController>(
      () => WeaponController(),
    );
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
    Get.lazyPut<AgentController>(
      () => AgentController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
