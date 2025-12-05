import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/controllers/weapons_controller.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';
import 'package:valorant_guide_app/app/widgets/skeletons/card_skeleton.dart';

class WeaponsView extends GetView<WeaponsController> {
  const WeaponsView({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WeaponsGridSkeleton();
      }

      if (controller.error.value != null) {
        return Center(
          child: Text(
            controller.error.value!,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      if (controller.weapons.isEmpty) {
        return const Center(
          child: Text(
            'Nenhum Item na Lista',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      return _buildList(context);
    });
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: controller.weapons.length,
      itemBuilder: (context, index) {
        final weapon = controller.weapons[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildWeaponCard(context, weapon, index),
        );
      },
    );
  }

  BorderRadius _getCardShape(int index) {
    final shapes = [
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(4),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(20),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(4),
      ),
    ];
    return shapes[index % shapes.length];
  }

  Widget _buildWeaponCard(BuildContext context, WeaponEntity weapon, int index) {
    final categoryColor = _getCategoryColor(weapon.categoryName);
    final categoryIcon = _getCategoryIcon(weapon.categoryName);
    final shape = _getCardShape(index);
    final cost = weapon.shopData?.cost ?? 0;
    final categoryText = weapon.shopData?.categoryText ?? weapon.categoryName;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.WEAPON_DETAILS, arguments: weapon);
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: shape,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              categoryColor.withAlpha(40),
              AppColors.detailListBackground,
              AppColors.detailListBackground,
            ],
          ),
          border: Border.all(
            color: categoryColor.withAlpha(60),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: categoryColor.withAlpha(30),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: shape,
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Opacity(
                    opacity: 0.08,
                    child: Icon(
                      categoryIcon,
                      size: 120,
                      color: categoryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: categoryColor.withAlpha(40),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: categoryColor.withAlpha(100),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      categoryIcon,
                                      color: categoryColor,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      categoryText.toUpperCase(),
                                      style: TextStyle(
                                        color: categoryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            weapon.displayName.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.appColorsTheme[
                                      controller.homeThemeIndex.value]
                                  .text,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (cost > 0) ...[
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$cost',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                              if (weapon.weaponStats != null) ...[
                                Icon(
                                  Icons.inventory_2,
                                  color: AppColors.grey.withAlpha(180),
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${weapon.weaponStats!.magazineSize}',
                                  style: TextStyle(
                                    color: AppColors.grey.withAlpha(180),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.speed,
                                  color: AppColors.grey.withAlpha(180),
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${weapon.weaponStats!.fireRate.toStringAsFixed(1)}/s',
                                  style: TextStyle(
                                    color: AppColors.grey.withAlpha(180),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CachedNetworkImage(
                        imageUrl: weapon.displayIcon,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Shimmer.fromColors(
                          baseColor: AppColors.grey.withAlpha(30),
                          highlightColor: AppColors.grey.withAlpha(60),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          categoryIcon,
                          color: categoryColor.withAlpha(100),
                          size: 48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
