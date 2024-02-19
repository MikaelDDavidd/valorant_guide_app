import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/constants/app_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/agent_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/modules/home/views/agents_view.dart';
import 'package:valorant_guide_app/app/modules/home/views/maps_view.dart';
import 'package:valorant_guide_app/app/modules/home/views/weapons_view.dart';
import 'package:valorant_guide_app/app/modules/home/widgets/tab_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<AgentController> {
  HomeView({Key? key}) : super(key: key);
  final agentController = Get.find<AgentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        //       _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Obx(
      () => _buildHomeView(),
    );
  }

  Widget _buildHomeView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 64,
                width: 64,
                child: SvgPicture.asset('assets/icons/valorant_icon.svg'),
              ),
            ),
            Text(
              AppStrings.selectAgent,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Rubik',
                color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            _buildTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return TaskBar(gridCards: [
      // Widgets para a primeira aba
      AgentsView(),
      // Widgets para a segunda aba
      MapsView(),
      // Widgets para a terceira aba
      WeaponsView(),
    ], tabs: [
      Tab(
        height: 40,
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            "Agentes",
          ),
        ),
      ),
      Tab(
        height: 40,
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            "Mapas",
          ),
        ),
      ),
      Tab(
        height: 40,
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            "Armas",
          ),
        ),
      ),
    ]);
  }
}
