import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/constants/app_strings.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/views/agents_view.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/widgets/app_drawer.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/widgets/task_bar.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/views/maps_view.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/views/weapons_view.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentsController = Get.find<AgentsController>();

    return Obx(() => Scaffold(
          backgroundColor: AppColors.appColorsTheme[agentsController.homeThemeIndex.value].background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: AppColors.white,
                  size: 28,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            title: SizedBox(
              height: 32,
              width: 32,
              child: SvgPicture.asset('assets/icons/valorant_icon.svg'),
            ),
          ),
          drawer: AppDrawer(
            currentIndex: controller.currentTabIndex.value,
            onItemTap: (index) {
              controller.changeTab(index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showPlayerSearchDialog(context),
            backgroundColor: AppColors.selectedTabColor,
            child: SizedBox(
              height: 28,
              width: 28,
              child: SvgPicture.asset(
                'assets/icons/valorant_icon.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          body: SafeArea(child: _buildBody(agentsController)),
        ));
  }

  Widget _buildBody(AgentsController agentsController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Text(
            AppStrings.selectAgent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: AppColors.appColorsTheme[agentsController.homeThemeIndex.value].text,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildTabs()),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return const TaskBar(
      gridCards: [
        AgentsView(),
        MapsView(),
        WeaponsView(),
      ],
      tabs: [
        Tab(
          height: 40,
          child: Center(child: Text('Agentes')),
        ),
        Tab(
          height: 40,
          child: Center(child: Text('Mapas')),
        ),
        Tab(
          height: 40,
          child: Center(child: Text('Armas')),
        ),
      ],
    );
  }

  void _showPlayerSearchDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController tagController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: AppColors.detailListBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Buscar Jogador',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Digite o Riot ID do jogador (Nome#TAG)',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Rubik',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        filled: true,
                        fillColor: AppColors.darkPurple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '#',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: tagController,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Rubik',
                      ),
                      decoration: InputDecoration(
                        hintText: 'TAG',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        filled: true,
                        fillColor: AppColors.darkPurple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final tag = tagController.text.trim();

                    if (name.isEmpty || tag.isEmpty) {
                      Get.snackbar(
                        'Erro',
                        'Preencha o nome e a tag do jogador',
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                      return;
                    }

                    Navigator.pop(context);
                    Get.toNamed(
                      Routes.PLAYER_DETAILS,
                      arguments: {
                        'name': name,
                        'tag': tag
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.selectedTabColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Buscar',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
