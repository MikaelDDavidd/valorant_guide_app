import 'package:get/get.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/modules/agents/data/datasources/agent_remote_datasource.dart';
import 'package:valorant_guide_app/app/modules/agents/data/repositories/agent_repository_impl.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/repositories/i_agent_repository.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/usecases/get_agents_usecase.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';

class AgentsBinding extends Bindings {
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
  }
}
