import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/controllers/players_controller.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class PlayersView extends GetView<PlayersController> {
  const PlayersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final tagController = TextEditingController();

    final args = Get.arguments;
    if (args != null && args is Map) {
      if (args['name'] != null) nameController.text = args['name'];
      if (args['tag'] != null) tagController.text = args['tag'];
    }

    return Scaffold(
      backgroundColor: AppColors.appColorsTheme[0].background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'BUSCAR JOGADOR',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchFields(context, nameController, tagController),
              const SizedBox(height: 24),
              Expanded(
                child: Obx(() {
                  if (controller.recentSearches.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildRecentSearches(nameController, tagController);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFields(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController tagController,
  ) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      fillColor: AppColors.detailListBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: AppColors.grey,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
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
                      fillColor: AppColors.detailListBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) =>
                        _handleSearch(context, nameController, tagController),
                  ),
                ),
              ],
            ),
            if (controller.error.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  controller.error.value!,
                  style: TextStyle(
                    color: AppColors.red.withAlpha(200),
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isSearching.value
                    ? null
                    : () => _handleSearch(context, nameController, tagController),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.selectedTabColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isSearching.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Text(
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
          ],
        ));
  }

  void _handleSearch(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController tagController,
  ) {
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

    FocusScope.of(context).unfocus();
    Get.toNamed(
      Routes.PLAYER_DETAILS,
      arguments: {'name': name, 'tag': tag},
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 64,
            color: AppColors.grey.withAlpha(80),
          ),
          const SizedBox(height: 16),
          Text(
            'Busque um jogador',
            style: TextStyle(
              color: AppColors.grey.withAlpha(150),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Digite o Riot ID (Nome#Tag)',
            style: TextStyle(
              color: AppColors.grey.withAlpha(100),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(
    TextEditingController nameController,
    TextEditingController tagController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.selectedTabColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'BUSCAS RECENTES',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: controller.clearRecentSearches,
              child: Text(
                'Limpar',
                style: TextStyle(
                  color: AppColors.selectedTabColor.withAlpha(180),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: controller.recentSearches.length,
            itemBuilder: (context, index) {
              final query = controller.recentSearches[index];
              return _buildRecentSearchItem(
                  query, nameController, tagController);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchItem(
    String query,
    TextEditingController nameController,
    TextEditingController tagController,
  ) {
    final parts = query.split('#');
    final name = parts.isNotEmpty ? parts[0] : '';
    final tag = parts.length > 1 ? parts[1] : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          nameController.text = name;
          tagController.text = tag;
          Get.toNamed(
            Routes.PLAYER_DETAILS,
            arguments: {'name': name, 'tag': tag},
          );
        },
        leading: Icon(
          Icons.history,
          color: AppColors.grey.withAlpha(150),
          size: 20,
        ),
        title: Text(
          query,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          onPressed: () => controller.removeRecentSearch(query),
          icon: Icon(
            Icons.close,
            color: AppColors.grey.withAlpha(100),
            size: 18,
          ),
        ),
      ),
    );
  }
}
