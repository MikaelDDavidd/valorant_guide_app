import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class RoundTimelineCard extends StatelessWidget {
  final RoundEntity round;
  final int roundNumber;

  const RoundTimelineCard({Key? key, required this.round, required this.roundNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRedWinner = round.winningTeam.toLowerCase() == 'red';
    final winnerColor = isRedWinner ? AppColors.red : AppColors.blue;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: winnerColor, width: 4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  'ROUND',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$roundNumber',
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${round.winningTeam.toUpperCase()} WON',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: winnerColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    round.endType.replaceAll('_', ' '),
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (round.bombPlanted)
              _buildEventIcon(Icons.backpack, Colors.redAccent, 'Planted'),
            if (round.bombDefused)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildEventIcon(Icons.build, Colors.greenAccent, 'Defused'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventIcon(IconData icon, Color color, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 16,
        ),
      ),
    );
  }
}
