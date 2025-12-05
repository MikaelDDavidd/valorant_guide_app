import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/controllers/weapons_controller.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/widgets/damage_mannequin.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/widgets/damage_range_chart.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/widgets/skin_details_dialog.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class WeaponDetailsView extends StatelessWidget {
  const WeaponDetailsView({Key? key}) : super(key: key);

  Color _getCategoryColor(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('sidearm')) return Colors.green;
    if (cat.contains('smg')) return Colors.blue;
    if (cat.contains('shotgun')) return Colors.orange;
    if (cat.contains('rifle')) return Colors.purple;
    if (cat.contains('sniper')) return Colors.red;
    if (cat.contains('heavy')) return Colors.amber;
    if (cat.contains('melee')) return Colors.grey;
    return AppColors.gradientStartColor;
  }

  IconData _getCategoryIcon(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('sidearm')) return Icons.gps_fixed;
    if (cat.contains('smg')) return Icons.flash_on;
    if (cat.contains('shotgun')) return Icons.scatter_plot;
    if (cat.contains('rifle')) return Icons.track_changes;
    if (cat.contains('sniper')) return Icons.center_focus_strong;
    if (cat.contains('heavy')) return Icons.shield;
    if (cat.contains('melee')) return Icons.content_cut;
    return Icons.sports_esports;
  }

  String _getWallPenetrationText(String penetration) {
    switch (penetration.toLowerCase()) {
      case 'low':
        return 'Baixa';
      case 'medium':
        return 'Média';
      case 'high':
        return 'Alta';
      default:
        return penetration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final weapon = ModalRoute.of(context)!.settings.arguments as WeaponEntity;
    final controller = Get.find<WeaponsController>();

    return Obx(() => Scaffold(
          backgroundColor:
              AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildBanner(weapon, controller),
                if (weapon.weaponStats != null) ...[
                  _buildStatsCards(weapon, controller),
                  _buildDamageMannequin(weapon, controller),
                  _buildDamageChart(weapon, controller),
                ],
                _buildSkins(context, weapon, controller),
                _buildRelatedWeapons(context, weapon, controller),
              ],
            ),
          ),
        ));
  }

  Widget _buildSectionTitle(String title, Color categoryColor, int themeIndex) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: AppColors.appColorsTheme[themeIndex].text,
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
                  categoryColor.withAlpha(100),
                  categoryColor.withAlpha(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(WeaponEntity weapon, WeaponsController controller) {
    final categoryColor = _getCategoryColor(weapon.categoryName);
    final categoryIcon = _getCategoryIcon(weapon.categoryName);
    final cost = weapon.shopData?.cost ?? 0;
    final categoryText = weapon.shopData?.categoryText ?? weapon.categoryName;

    return Container(
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            categoryColor.withAlpha(200),
            categoryColor.withAlpha(120),
            AppColors.appColorsTheme[controller.homeThemeIndex.value]
                .background
                .withAlpha(255),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: 0,
            bottom: 0,
            child: Center(
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  categoryIcon,
                  size: 200,
                  color: AppColors.white,
                ),
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
                    AppColors.appColorsTheme[controller.homeThemeIndex.value]
                        .background
                        .withAlpha(255),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 60,
            bottom: 40,
            child: CachedNetworkImage(
              imageUrl: weapon.displayIcon,
              fit: BoxFit.contain,
              width: 200,
              errorWidget: (context, url, error) => Icon(
                categoryIcon,
                color: AppColors.white.withAlpha(100),
                size: 80,
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 60,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weapon.displayName.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: categoryColor.withAlpha(150),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              categoryIcon,
                              color: categoryColor,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              categoryText.toUpperCase(),
                              style: TextStyle(
                                color: categoryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (cost > 0) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.amber.withAlpha(150),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$cost',
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildStatsCards(WeaponEntity weapon, WeaponsController controller) {
    final categoryColor = _getCategoryColor(weapon.categoryName);
    final stats = weapon.weaponStats!;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'ESTATÍSTICAS',
            categoryColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.speed,
                  stats.fireRate.toStringAsFixed(2),
                  'Disparo/s',
                  categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.inventory_2,
                  '${stats.magazineSize}',
                  'Magazine',
                  categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.refresh,
                  '${stats.reloadTimeSeconds.toStringAsFixed(1)}s',
                  'Recarga',
                  categoryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.swap_horiz,
                  '${stats.equipTimeSeconds.toStringAsFixed(1)}s',
                  'Equipar',
                  categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.security,
                  _getWallPenetrationText(stats.wallPenetration),
                  'Penetração',
                  categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color categoryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: categoryColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: categoryColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.grey.withAlpha(180),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageMannequin(WeaponEntity weapon, WeaponsController controller) {
    final categoryColor = _getCategoryColor(weapon.categoryName);
    final ranges = weapon.weaponStats!.damageRanges;

    if (ranges.isEmpty) return const SizedBox();

    final baseDamage = ranges.first;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'DANO BASE',
            categoryColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 8),
          Text(
            '${baseDamage.rangeStartMeters.toInt()}-${baseDamage.rangeEndMeters.toInt()} metros',
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          DamageMannequin(
            damage: baseDamage,
            accentColor: categoryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDamageChart(WeaponEntity weapon, WeaponsController controller) {
    final categoryColor = _getCategoryColor(weapon.categoryName);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'ALCANCE DE DANO',
            categoryColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: categoryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: DamageRangeChart(
              damageRanges: weapon.weaponStats!.damageRanges,
              themeIndex: controller.homeThemeIndex.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkins(
    BuildContext context,
    WeaponEntity weapon,
    WeaponsController controller,
  ) {
    final categoryColor = _getCategoryColor(weapon.categoryName);

    final displaySkins = weapon.skins
        .where((s) =>
            s.displayIcon != null &&
            !s.displayName.toLowerCase().contains('standard') &&
            !s.displayName.toLowerCase().contains('random'))
        .toList();

    if (displaySkins.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'SKINS',
            categoryColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 8),
          Text(
            '${displaySkins.length} skins disponíveis',
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: displaySkins.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final skin = displaySkins[index];
                return _buildSkinCard(context, skin, categoryColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkinCard(BuildContext context, SkinEntity skin, Color categoryColor) {
    final hasVideo = skin.hasVideo;
    final hasWallpaper = skin.wallpaper != null;

    return GestureDetector(
      onTap: () {
        SkinDetailsDialog.show(context, skin, categoryColor);
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.detailListBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasWallpaper
                ? categoryColor.withAlpha(80)
                : categoryColor.withAlpha(30),
            width: hasWallpaper ? 1.5 : 1,
          ),
          boxShadow: hasWallpaper
              ? [
                  BoxShadow(
                    color: categoryColor.withAlpha(40),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Stack(
            children: [
              if (hasWallpaper)
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: skin.wallpaper!,
                    fit: BoxFit.cover,
                    color: Colors.black.withAlpha(120),
                    colorBlendMode: BlendMode.darken,
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                ),
              Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: skin.displayIcon ?? '',
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported,
                                color: AppColors.grey.withAlpha(100),
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        if (hasVideo)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: categoryColor.withAlpha(200),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: AppColors.white,
                                size: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: hasWallpaper
                          ? Colors.black.withAlpha(150)
                          : categoryColor.withAlpha(20),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(11),
                        bottomRight: Radius.circular(11),
                      ),
                    ),
                    child: Text(
                      skin.displayName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedWeapons(
    BuildContext context,
    WeaponEntity weapon,
    WeaponsController controller,
  ) {
    final categoryColor = _getCategoryColor(weapon.categoryName);
    final categoryText = weapon.shopData?.categoryText ?? weapon.categoryName;

    final relatedWeapons = controller.weapons
        .where((w) =>
            w.categoryName.toLowerCase() == weapon.categoryName.toLowerCase() &&
            w.uuid != weapon.uuid)
        .toList();

    if (relatedWeapons.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'ARMAS RELACIONADAS',
            categoryColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 8),
          Text(
            'Outros ${categoryText}s',
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: relatedWeapons.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final relatedWeapon = relatedWeapons[index];
                final relatedColor = _getCategoryColor(relatedWeapon.categoryName);
                final relatedCost = relatedWeapon.shopData?.cost ?? 0;

                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.WEAPON_DETAILS,
                      arguments: relatedWeapon,
                    );
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          relatedColor.withAlpha(100),
                          relatedColor.withAlpha(50),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: relatedColor.withAlpha(80),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: CachedNetworkImage(
                              imageUrl: relatedWeapon.displayIcon,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                _getCategoryIcon(relatedWeapon.categoryName),
                                color: AppColors.white.withAlpha(100),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(11),
                              bottomRight: Radius.circular(11),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                relatedWeapon.displayName,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                              if (relatedCost > 0) ...[
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      color: Colors.amber,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '$relatedCost',
                                      style: const TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
