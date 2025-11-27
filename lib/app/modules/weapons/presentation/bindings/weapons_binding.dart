import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/datasources/weapon_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/weapons/data/repositories/weapon_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/repositories/i_weapon_repository.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/controllers/weapons_controller.dart';

class WeaponsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpClient>(() => HttpClient());
    Get.lazyPut<IWeaponRemoteDataSource>(
      () => WeaponRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IWeaponRepository>(
      () => WeaponRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetWeaponsUseCase(Get.find()));
    Get.lazyPut(() => WeaponsController(getWeaponsUseCase: Get.find()));
  }
}
