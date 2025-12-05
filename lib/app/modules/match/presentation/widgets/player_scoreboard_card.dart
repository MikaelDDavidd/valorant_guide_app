import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class PlayerScoreboardCard extends StatelessWidget {
  final PlayerDetailEntity player;

  const PlayerScoreboardCard({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRedTeam = player.team.toLowerCase() == 'red';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isRedTeam
            ? AppColors.red.withAlpha(20)
            : AppColors.blue.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRedTeam
              ? AppColors.red.withAlpha(50)
              : AppColors.blue.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: player.assets.agent.small,
            height: 40,
            width: 40,
            errorWidget: (context, url, error) =>
                const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '#${player.tag}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _buildStatColumn('K', player.stats.kills.toString()),
          const SizedBox(width: 12),
          _buildStatColumn('D', player.stats.deaths.toString()),
          const SizedBox(width: 12),
          _buildStatColumn('A', player.stats.assists.toString()),
          const SizedBox(width: 12),
          _buildStatColumn('Score', player.stats.score.toString()),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
