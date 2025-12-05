import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/match/data/datasources/match_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/match/data/repositories/match_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/match/domain/repositories/i_match_repository.dart';
import 'package:valorant_guide_app/app/modules/match/domain/usecases/get_match_details_usecase.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/controllers/match_controller.dart';

class MatchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpClient>(() => HttpClient());
    Get.lazyPut<IMatchRemoteDataSource>(
        () => MatchRemoteDataSource(client: Get.find()));
    Get.lazyPut<IMatchRepository>(
        () => MatchRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => GetMatchDetailsUseCase(Get.find()));
    Get.lazyPut(() => MatchController(getMatchDetailsUseCase: Get.find()));
  }
}
