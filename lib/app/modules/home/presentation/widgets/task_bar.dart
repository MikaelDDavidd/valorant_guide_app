import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';

class TaskBar extends StatelessWidget {
  final List<Widget> gridCards;
  final List<Tab> tabs;

  const TaskBar({
    Key? key,
    required this.gridCards,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgentsController>();

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Obx(() => TabBar(
                tabs: tabs,
                labelColor:
                    AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                unselectedLabelColor: AppColors.grey,
                indicatorColor:
                    AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                dividerColor: Colors.transparent,
              )),
          Expanded(
            child: TabBarView(children: gridCards),
          ),
        ],
      ),
    );
  }
}
