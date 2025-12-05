import 'package:get/get.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';
import 'package:valorant_guide_app/app/modules/match/domain/usecases/get_match_details_usecase.dart';

class MatchController extends GetxController {
  final GetMatchDetailsUseCase getMatchDetailsUseCase;

  MatchController({required this.getMatchDetailsUseCase});

  final Rx<MatchEntity?> match = Rx<MatchEntity?>(null);
  final RxBool isLoading = false.obs;
  final Rx<Failure?> failure = Rx<Failure?>(null);

  @override
  void onInit() {
    super.onInit();
    final matchId = Get.parameters['matchId'];
    if (matchId != null) {
      loadMatchDetails(matchId);
    }
  }

  Future<void> loadMatchDetails(String matchId) async {
    isLoading.value = true;
    final result = await getMatchDetailsUseCase(matchId);
    result.fold(
      (fail) => failure.value = fail,
      (matchEntity) => match.value = matchEntity,
    );
    isLoading.value = false;
  }
}
