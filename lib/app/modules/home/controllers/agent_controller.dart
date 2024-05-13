import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reflectable/reflectable.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_values.dart';
import 'package:valorant_guide_app/app/data/http/http_client.dart';
import 'package:valorant_guide_app/app/models/agent.dart';
import 'package:valorant_guide_app/app/data/repositories/agent_repositories.dart';
import 'package:valorant_guide_app/app/data/stores/agents_store.dart';

final logger = Logger();

class AgentController extends GetxController {
    RxInt homeThemeIndex = AppValues().themIndexValue.obs;

  final AgentsStore store = AgentsStore(
    repository: AgentRepository(
      client: HttpClient(),
    ),
  );

  
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    store.getAgents();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
