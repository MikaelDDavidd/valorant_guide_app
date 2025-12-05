import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/controllers/match_controller.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/widgets/player_scoreboard_card.dart';

class MatchPage extends GetView<MatchController> {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorsTheme[0].background,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.selectedTabColor,
            ));
          }

          if (controller.failure.value != null) {
            return Center(
                child: Text('Error: ${controller.failure.value!.message}'));
          }

          if (controller.match.value == null) {
            return const Center(child: Text('Match not found'));
          }

          final match = controller.match.value!;
          final metadata = match.metadata;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(metadata),
                _buildScoreboard(),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(dynamic metadata) {
    return Container(
      height: 240,
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                metadata.map,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
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
              const SizedBox(height: 4),
              Text(
                metadata.mode,
                style: TextStyle(
                  color: Colors.white.withAlpha(180),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(Icons.timer, '${(metadata.gameLength / 60000).toStringAsFixed(0)} min'),
                  const SizedBox(width: 8),
                  _buildInfoChip(Icons.calendar_today, metadata.gameStartPatched.split(',')[1]),
                ],
              ),
            ],
          ),
        ),
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
              color: Colors.white,
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
            color: Colors.white,
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

  Widget _buildScoreboard() {
    final match = controller.match.value!;
    final allPlayers = match.players.allPlayers;
    final redTeam = allPlayers.where((p) => p.team.toLowerCase() == 'red').toList();
    final blueTeam = allPlayers.where((p) => p.team.toLowerCase() == 'blue').toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('RED TEAM'),
          const SizedBox(height: 16),
          ...redTeam.map((player) => PlayerScoreboardCard(player: player)),
          const SizedBox(height: 24),
          _buildSectionTitle('BLUE TEAM'),
          const SizedBox(height: 16),
          ...blueTeam.map((player) => PlayerScoreboardCard(player: player)),
        ],
      ),
    );
  }
}
