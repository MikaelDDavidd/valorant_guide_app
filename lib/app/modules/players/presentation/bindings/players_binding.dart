import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/players/data/datasources/player_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/players/data/repositories/player_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/players/domain/repositories/i_player_repository.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/search_player_usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/get_player_mmr_usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/get_player_matches_usecase.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/controllers/players_controller.dart';

class PlayersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpClient>(() => HttpClient());
    Get.lazyPut<IPlayerRemoteDataSource>(
      () => PlayerRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<IPlayerRepository>(
      () => PlayerRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => SearchPlayerUseCase(Get.find()));
    Get.lazyPut(() => GetPlayerMmrUseCase(Get.find()));
    Get.lazyPut(() => GetPlayerMatchesUseCase(Get.find()));
    Get.lazyPut(
      () => PlayersController(
        searchPlayerUseCase: Get.find(),
        getPlayerMmrUseCase: Get.find(),
        getPlayerMatchesUseCase: Get.find(),
      ),
    );
  }
}
