import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/maps/data/datasources/map_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/maps/data/repositories/map_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/repositories/i_map_repository.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/usecases/get_maps_usecase.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/controllers/maps_controller.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpClient>(() => HttpClient());
    Get.lazyPut<IMapRemoteDataSource>(
      () => MapRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IMapRepository>(
      () => MapRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetMapsUseCase(Get.find()));
    Get.lazyPut(() => MapsController(getMapsUseCase: Get.find()));
  }
}
