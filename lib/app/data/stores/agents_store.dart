import 'package:flutter/foundation.dart';
import 'package:valorant_guide_app/app/data/http/exceptions.dart';
import 'package:valorant_guide_app/app/data/repositories/agent_repositories.dart';
import 'package:valorant_guide_app/app/models/agent.dart';

class AgentsStore {
  final iAgentRepository repository;

  // var relative to loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // var relative to state
  final ValueNotifier<List<AgentData>> state = ValueNotifier<List<AgentData>>([]);

  // var relative to error
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  AgentsStore({required this.repository});

  Future getAgents() async {
    isLoading.value = true;

    try {
      final result = await repository.getAgents();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
