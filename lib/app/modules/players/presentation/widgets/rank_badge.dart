import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';

class RankBadge extends StatelessWidget {
  final PlayerMmrEntity mmr;
  final bool showDetails;

  const RankBadge({
    Key? key,
    required this.mmr,
    this.showDetails = true,
  }) : super(key: key);

  Color _getRankColor(int tier) {
    if (tier <= 3) return Colors.grey;
    if (tier <= 6) return const Color(0xFFCD7F32);
    if (tier <= 9) return const Color(0xFFC0C0C0);
    if (tier <= 12) return const Color(0xFFFFD700);
    if (tier <= 15) return const Color(0xFF00CED1);
    if (tier <= 18) return const Color(0xFF9B59B6);
    if (tier <= 21) return const Color(0xFF2ECC71);
    if (tier <= 24) return const Color(0xFFE74C3C);
    return const Color(0xFFFFD700);
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = _getRankColor(mmr.currentTier);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: rankColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (mmr.images?.large != null)
            CachedNetworkImage(
              imageUrl: mmr.images!.large!,
              width: 64,
              height: 64,
              errorWidget: (context, url, error) => Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: rankColor.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shield,
                  color: rankColor,
                  size: 32,
                ),
              ),
            )
          else
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: rankColor.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield,
                color: rankColor,
                size: 32,
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mmr.currentTierName.toUpperCase(),
                  style: TextStyle(
                    color: rankColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
                if (showDetails) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${mmr.rankingInTier} RR',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildMmrChange(),
                    ],
                  ),
                  if (mmr.highestRank != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: AppColors.grey.withAlpha(150),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Pico: ${mmr.highestRank!.patchedTier}',
                          style: TextStyle(
                            color: AppColors.grey.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMmrChange() {
    final change = mmr.mmrChangeToLastGame;
    final isPositive = change >= 0;
    final color = isPositive ? AppColors.green : AppColors.red;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        Text(
          '${isPositive ? '+' : ''}$change',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
