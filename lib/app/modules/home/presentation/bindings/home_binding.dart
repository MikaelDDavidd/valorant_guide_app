import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/agents/data/datasources/agent_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/agents/data/repositories/agent_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/repositories/i_agent_repository.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/usecases/get_agents_usecase.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:valorant_guide_app/app/modules/maps/data/datasources/map_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/maps/data/repositories/map_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/repositories/i_map_repository.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/usecases/get_maps_usecase.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/datasources/weapon_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/repositories/weapon_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/repositories/i_weapon_repository.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/controllers/weapons_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpClient>(() => HttpClient());

    Get.lazyPut<IAgentRemoteDataSource>(
      () => AgentRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IAgentRepository>(
      () => AgentRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetAgentsUseCase(Get.find()));
    Get.lazyPut(() => AgentsController(getAgentsUseCase: Get.find()));

    Get.lazyPut<IWeaponRemoteDataSource>(
      () => WeaponRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IWeaponRepository>(
      () => WeaponRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetWeaponsUseCase(Get.find()));
    Get.lazyPut(() => WeaponsController(getWeaponsUseCase: Get.find()));

    Get.lazyPut<IMapRemoteDataSource>(
      () => MapRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IMapRepository>(
      () => MapRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetMapsUseCase(Get.find()));
    Get.lazyPut(() => MapsController(getMapsUseCase: Get.find()));

    Get.lazyPut(() => HomeController());
  }
}
