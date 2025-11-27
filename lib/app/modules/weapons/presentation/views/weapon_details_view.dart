import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/controllers/weapons_controller.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/widgets/damage_range_chart.dart';

class WeaponDetailsView extends StatelessWidget {
  const WeaponDetailsView({Key? key}) : super(key: key);

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
                _buildTopImage(context, weapon, controller),
                _buildStats(weapon, controller),
                _buildDamageInfo(weapon, controller),
              ],
            ),
          ),
        ));
  }

  Widget _buildTopImage(
      BuildContext context, WeaponEntity weapon, WeaponsController controller) {
    return Container(
      color: AppColors.gradientStartColor,
      height: 300.0,
      child: Stack(
        children: [
          Positioned.fill(
            right: -10,
            bottom: -80,
            child: Align(
              alignment: Alignment.bottomRight,
              child: AspectRatio(
                aspectRatio: 0.75,
                child: GestureDetector(
                  onTap: () {
                    FullscreenImageViewer.open(
                      context: context,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.network(weapon.displayIcon),
                      ),
                    );
                  },
                  child: Image.network(weapon.displayIcon),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 48.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      weapon.displayName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors
                            .appColorsTheme[controller.homeThemeIndex.value]
                            .text,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            weapon.categoryName,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(WeaponEntity weapon, WeaponsController controller) {
    if (weapon.weaponStats == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// ESTATÍSTICAS',
            style: TextStyle(
              color: AppColors
                  .appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          _buildStatRow(
            'Taxa de Disparo',
            '${weapon.weaponStats!.fireRate.toStringAsFixed(1)} tiros/seg',
            controller,
          ),
          const SizedBox(height: 20),
          Text(
            '// ALCANCE DE DANO',
            style: TextStyle(
              color: AppColors
                  .appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          DamageRangeChart(
            damageRanges: weapon.weaponStats!.damageRanges,
            themeIndex: controller.homeThemeIndex.value,
          ),
        ],
      ),
    );
  }

  Widget _buildDamageInfo(WeaponEntity weapon, WeaponsController controller) {
    if (weapon.weaponStats == null ||
        weapon.weaponStats!.damageRanges.isEmpty) {
      return const SizedBox.shrink();
    }

    final damage = weapon.weaponStats!.damageRanges.first;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// INFORMAÇÕES DE DANO',
            style: TextStyle(
              color: AppColors
                  .appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          _buildStatRow(
            'Dano na Cabeça',
            damage.headDamage.toStringAsFixed(0),
            controller,
          ),
          _buildStatRow(
            'Dano no Corpo',
            damage.bodyDamage.toStringAsFixed(0),
            controller,
          ),
          _buildStatRow(
            'Dano nas Pernas',
            damage.legDamage.toStringAsFixed(0),
            controller,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
      String label, String value, WeaponsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors
                  .appColorsTheme[controller.homeThemeIndex.value].text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
