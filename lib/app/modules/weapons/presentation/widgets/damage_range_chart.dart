import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

class DamageRangeChart extends StatelessWidget {
  final List<DamageRangeEntity> damageRanges;
  final int themeIndex;

  const DamageRangeChart({
    Key? key,
    required this.damageRanges,
    required this.themeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (damageRanges.isEmpty) return const SizedBox.shrink();

    return Column(
      children: damageRanges.map((range) => _buildRangeRow(range)).toList(),
    );
  }

  Widget _buildRangeRow(DamageRangeEntity range) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.detailListBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${range.rangeStartMeters.toStringAsFixed(0)}m - ${range.rangeEndMeters.toStringAsFixed(0)}m',
              style: TextStyle(
                color: AppColors.appColorsTheme[themeIndex].text,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDamageColumn(
                  'Cabeça',
                  range.headDamage,
                  Colors.red,
                ),
                _buildDamageColumn(
                  'Corpo',
                  range.bodyDamage,
                  Colors.orange,
                ),
                _buildDamageColumn(
                  'Pernas',
                  range.legDamage,
                  Colors.yellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDamageColumn(String label, double damage, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          damage.toStringAsFixed(0),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
