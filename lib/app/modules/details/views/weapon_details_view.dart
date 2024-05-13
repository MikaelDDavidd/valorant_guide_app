// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';

import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/models/maps.dart';
import 'package:valorant_guide_app/app/models/weapons.dart';
import 'package:valorant_guide_app/app/modules/details/controllers/details_controller.dart';
import 'package:valorant_guide_app/app/modules/details/views/damage_range_stats.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/weapon_controller.dart';
import 'package:valorant_guide_app/app/modules/home/widgets/body_widget.dart';

class WeaponDetailsView extends GetView<DetailsController> {
  WeaponDetailsView({Key? key}) : super(key: key);
  final weaponsController = Get.find<WeaponController>();

  @override
  Widget build(BuildContext context) {
    final weapon = ModalRoute.of(context)!.settings.arguments as WeaponData;
    return Scaffold(
      body: _buildBody(weapon),
    );
  }

  Widget _buildBody(WeaponData weapon) {
    return Stack(
      children: <Widget>[
        _buildMainContent(weapon),
      ],
    );
  }

  Widget _buildMainContent(WeaponData weapon) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
          body: _buildHomeView(weapon),
        ));
  }

  Widget _buildHomeView(WeaponData weapon) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _topImage(Get.context!, weapon),
          _biography(weapon),
          _specialAbilities(weapon),
        ],
      ),
    );
  }

  Widget _topImage(BuildContext context, WeaponData weapon) {
    String category = weapon.category;
    List<String> parts = category.split("::");
    String weaponCategory = parts.last;
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
                  child: Image.network(
                    weapon.displayIcon,
                  ),
                  onTap: () {
                    FullscreenImageViewer.open(
                      context: context,
                      child: GestureDetector(
                        child: Image.network(
                          weapon.displayIcon,
                        ),
                        onTap: () => Get.back(),
                      ),
                    );
                  },
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
                        color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
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
                          // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(8.0)), // Set rounded corner radius
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            weaponCategory,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _biography(WeaponData weapon,) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 20,
            ),
            child: Text(
              "// DAMAGE RANGE",
              style: TextStyle(
                color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            ),
          ),
          DamageRangeStats(damageRanges: weapon.weaponStats?.damageRanges ?? []),
        ],
      ),
    );
  }

  Widget _specialAbilities(WeaponData weapon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "// HABILIDADES ESPECIAIS",
            style: TextStyle(
              color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
}
