import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/usecases/get_agents_usecase.dart';

class AgentsController extends GetxController {
  final GetAgentsUseCase getAgentsUseCase;

  AgentsController({required this.getAgentsUseCase});

  final agents = <AgentEntity>[].obs;
  final isLoading = false.obs;
  final error = Rxn<String>();
  final homeThemeIndex = AppValues().themIndexValue.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAgents();
  }

  Future<void> fetchAgents() async {
    isLoading.value = true;
    error.value = null;

    final result = await getAgentsUseCase(NoParams());

    result.fold(
      (failure) => error.value = failure.message,
      (data) => agents.value = data,
    );

    isLoading.value = false;
  }

  void updateThemeIndex(int index) {
    homeThemeIndex.value = index;
  }
}
