import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/controllers/players_controller.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/widgets/rank_badge.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/widgets/match_history_card.dart';

class PlayerDetailsView extends GetView<PlayersController> {
  const PlayerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorsTheme[0].background,
      body: Obx(() {
        final account = controller.playerAccount.value;
        final isSearching = controller.isSearching.value;
        final error = controller.error.value;

        if (isSearching) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.selectedTabColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Buscando jogador...',
                  style: TextStyle(
                    color: AppColors.grey.withAlpha(180),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        if (error != null && account == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.red.withAlpha(180),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    error,
                    style: TextStyle(
                      color: AppColors.grey.withAlpha(200),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.selectedTabColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.selectedTabColor,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPlayerData,
          color: AppColors.selectedTabColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(account),
                _buildRankSection(),
                _buildMatchHistory(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(dynamic account) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.selectedTabColor.withAlpha(180),
            AppColors.gradientEndColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          if (account.card?.wide != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: CachedNetworkImage(
                  imageUrl: account.card!.wide!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const SizedBox(),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.appColorsTheme[0].background,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: controller.refreshPlayerData,
                        icon: const Icon(
                          Icons.refresh,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (account.card?.small != null)
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.white.withAlpha(50),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: account.card!.small!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.grey.withAlpha(50),
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account.name,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 8,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '#${account.tag}',
                              style: TextStyle(
                                color: AppColors.white.withAlpha(180),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildInfoChip(
                                  Icons.star,
                                  'Nível ${account.accountLevel}',
                                ),
                                const SizedBox(width: 8),
                                _buildInfoChip(
                                  Icons.public,
                                  account.region.toUpperCase(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(80),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.selectedTabColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.selectedTabColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.selectedTabColor.withAlpha(100),
                  AppColors.selectedTabColor.withAlpha(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('RANK COMPETITIVO'),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.isLoadingMmr.value) {
              return _buildRankSkeleton();
            }

            if (controller.mmrError.value != null) {
              return _buildErrorCard(controller.mmrError.value!);
            }

            final mmr = controller.playerMmr.value;
            if (mmr == null) {
              return _buildErrorCard('Dados de rank não disponíveis');
            }

            return RankBadge(mmr: mmr);
          }),
        ],
      ),
    );
  }

  Widget _buildMatchHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('PARTIDAS RECENTES'),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.isLoadingMatches.value) {
              return _buildMatchesSkeleton();
            }

            if (controller.matchesError.value != null) {
              return _buildErrorCard(controller.matchesError.value!);
            }

            if (controller.playerMatches.isEmpty) {
              return _buildErrorCard('Nenhuma partida encontrada');
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.playerMatches.length,
              itemBuilder: (context, index) {
                final match = controller.playerMatches[index];
                return GestureDetector(
                  onTap: () {
                    final route = Routes.MATCH_DETAILS.replaceFirst(
                        ':matchId', match.matchId);
                    Get.toNamed(route);
                  },
                  child: MatchHistoryCard(match: match),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRankSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withAlpha(30),
      highlightColor: AppColors.grey.withAlpha(60),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildMatchesSkeleton() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: AppColors.grey.withAlpha(30),
            highlightColor: AppColors.grey.withAlpha(60),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.red.withAlpha(30),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.grey.withAlpha(150),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.grey.withAlpha(180),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
