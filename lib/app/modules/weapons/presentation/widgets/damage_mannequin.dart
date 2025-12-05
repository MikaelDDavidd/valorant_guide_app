import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

class DamageMannequin extends StatelessWidget {
  final DamageRangeEntity damage;
  final Color accentColor;

  const DamageMannequin({
    Key? key,
    required this.damage,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildMannequin(),
          const SizedBox(width: 24),
          Expanded(child: _buildDamageInfo()),
        ],
      ),
    );
  }

  Widget _buildMannequin() {
    return SizedBox(
      width: 80,
      height: 180,
      child: CustomPaint(
        painter: MannequinPainter(
          headColor: Colors.red,
          bodyColor: Colors.amber,
          legColor: AppColors.grey,
        ),
      ),
    );
  }

  Widget _buildDamageInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDamageRow(
          color: Colors.red,
          label: 'Cabeça',
          value: damage.headDamage,
          icon: Icons.gps_fixed,
        ),
        const SizedBox(height: 16),
        _buildDamageRow(
          color: Colors.amber,
          label: 'Corpo',
          value: damage.bodyDamage,
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildDamageRow(
          color: AppColors.grey,
          label: 'Pernas',
          value: damage.legDamage,
          icon: Icons.directions_walk,
        ),
      ],
    );
  }

  Widget _buildDamageRow({
    required Color color,
    required String label,
    required double value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withAlpha(100),
              width: 1,
            ),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.grey.withAlpha(180),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.toStringAsFixed(0),
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _buildKillIndicator(value, color),
      ],
    );
  }

  Widget _buildKillIndicator(double damage, Color color) {
    final shotsToKill = (150 / damage).ceil();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.my_location,
            color: color.withAlpha(200),
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            '$shotsToKill tiro${shotsToKill > 1 ? 's' : ''}',
            style: TextStyle(
              color: color.withAlpha(200),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class MannequinPainter extends CustomPainter {
  final Color headColor;
  final Color bodyColor;
  final Color legColor;

  MannequinPainter({
    required this.headColor,
    required this.bodyColor,
    required this.legColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final headPaint = Paint()
      ..color = headColor
      ..style = PaintingStyle.fill;

    final bodyPaint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill;

    final legPaint = Paint()
      ..color = legColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white.withAlpha(50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final centerX = size.width / 2;

    final headRadius = size.width * 0.22;
    final headCenterY = headRadius + 5;
    canvas.drawCircle(Offset(centerX, headCenterY), headRadius, headPaint);
    canvas.drawCircle(Offset(centerX, headCenterY), headRadius, strokePaint);

    final neckTop = headCenterY + headRadius;
    final neckBottom = neckTop + 8;
    final neckWidth = size.width * 0.15;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, neckTop + 4),
        width: neckWidth,
        height: 8,
      ),
      bodyPaint,
    );

    final torsoTop = neckBottom;
    final torsoHeight = size.height * 0.32;
    final torsoWidth = size.width * 0.55;
    final torsoRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, torsoTop + torsoHeight / 2),
        width: torsoWidth,
        height: torsoHeight,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(torsoRect, bodyPaint);
    canvas.drawRRect(torsoRect, strokePaint);

    final armWidth = size.width * 0.12;
    final armHeight = torsoHeight * 0.85;
    final armTop = torsoTop + 5;

    final leftArmRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX - torsoWidth / 2 - armWidth - 2,
        armTop,
        armWidth,
        armHeight,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(leftArmRect, bodyPaint);
    canvas.drawRRect(leftArmRect, strokePaint);

    final rightArmRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX + torsoWidth / 2 + 2,
        armTop,
        armWidth,
        armHeight,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(rightArmRect, bodyPaint);
    canvas.drawRRect(rightArmRect, strokePaint);

    final legTop = torsoTop + torsoHeight + 3;
    final legHeight = size.height - legTop - 5;
    final legWidth = size.width * 0.18;
    const legGap = 4.0;

    final leftLegRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX - legWidth - legGap / 2,
        legTop,
        legWidth,
        legHeight,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(leftLegRect, legPaint);
    canvas.drawRRect(leftLegRect, strokePaint);

    final rightLegRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX + legGap / 2,
        legTop,
        legWidth,
        legHeight,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(rightLegRect, legPaint);
    canvas.drawRRect(rightLegRect, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
