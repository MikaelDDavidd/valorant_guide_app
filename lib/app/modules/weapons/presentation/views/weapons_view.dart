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

      return _buildGrid(context);
    });
  }

  Widget _buildGrid(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: controller.weapons.length,
      itemBuilder: (context, index) {
        final weapon = controller.weapons[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            height: 140,
            child: _buildWeaponCard(context, weapon),
          ),
        );
      },
    );
  }

  Widget _buildWeaponCard(BuildContext context, WeaponEntity weapon) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.WEAPON_DETAILS, arguments: weapon);
      },
      child: Stack(
        children: [
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0009)
              ..rotateY(-0.05)
              ..rotateX(-0.5),
            alignment: FractionalOffset.bottomLeft,
            child: Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.gradientStartColor,
                    AppColors.gradientEndColor,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.purple,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 100,
              width: 300,
              child: CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl: weapon.displayIcon,
                progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                  baseColor: AppColors.grey.withAlpha(30),
                  highlightColor: AppColors.grey.withAlpha(60),
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weapon.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors
                        .appColorsTheme[controller.homeThemeIndex.value].text,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  weapon.categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors
                        .appColorsTheme[controller.homeThemeIndex.value].text,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
