import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';

class MatchHistoryCard extends StatelessWidget {
  final PlayerMatchEntity match;

  const MatchHistoryCard({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWin = match.isWin;
    final resultColor = isWin ? AppColors.green : AppColors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: resultColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 80,
            decoration: BoxDecoration(
              color: resultColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildAgentIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              match.metadata.map,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: resultColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                match.result,
                                style: TextStyle(
                                  color: resultColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildModeChip(),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                match.metadata.gameStartPatched,
                                style: TextStyle(
                                  color: AppColors.grey.withAlpha(180),
                                  fontSize: 11,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildStats(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: match.playerStats.agentAssets?.small != null
            ? CachedNetworkImage(
                imageUrl: match.playerStats.agentAssets!.small!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  color: AppColors.grey,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: AppColors.grey,
                    size: 20,
                  ),
                  Text(
                    match.playerStats.character,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 8,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildModeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.selectedTabColor.withAlpha(30),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        match.metadata.mode,
        style: TextStyle(
          color: AppColors.selectedTabColor.withAlpha(200),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        _buildStatItem('K', match.playerStats.kills, AppColors.green),
        const SizedBox(width: 4),
        Text(
          '/',
          style: TextStyle(color: AppColors.grey.withAlpha(100)),
        ),
        const SizedBox(width: 4),
        _buildStatItem('D', match.playerStats.deaths, AppColors.red),
        const SizedBox(width: 4),
        Text(
          '/',
          style: TextStyle(color: AppColors.grey.withAlpha(100)),
        ),
        const SizedBox(width: 4),
        _buildStatItem('A', match.playerStats.assists, AppColors.blue),
        const Spacer(),
        Text(
          'KD ${match.playerStats.kdRatio.toStringAsFixed(2)}',
          style: TextStyle(
            color: AppColors.grey.withAlpha(180),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, int value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
