import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/constants/app_strings.dart';
import 'package:valorant_guide_app/app/models/maps.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/maps_controller.dart';
import '../controllers/details_controller.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';

class MapDetailsView extends GetView<DetailsController> {
  MapDetailsView({Key? key}) : super(key: key);
  final mapsController = Get.find<MapsController>();

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as MapData;
    return Scaffold(
      body: _buildBody(map),
    );
  }

  Widget _buildBody(MapData map) {
    return Stack(
      children: <Widget>[
        _buildMainContent(map),
      ],
    );
  }

  Widget _buildMainContent(MapData map) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
          body: _buildHomeView(map),
        ));
  }

  Widget _buildHomeView(MapData map) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _topImage(map),
          _biography(Get.context!, map),
          _specialAbilities(map),
        ],
      ),
    );
  }

  Widget _topImage(MapData map) {
    return Container(
      color: Colors.transparent,
      height: 300.0,
      child: Stack(
        children: [
          Image.network(
            map.splash!,
            color: Color.fromARGB(144, 255, 255, 255),
            colorBlendMode: BlendMode.modulate,
          ),
          Positioned(
            left: -64,
            top: -10,
            child: SizedBox(
              width: double.maxFinite,
              height: 10,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: -50,
            bottom: -80,
            child: Align(
              alignment: Alignment.bottomRight,
              child: AspectRatio(aspectRatio: 0.75, child: Container()),
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
                      map.displayName.toUpperCase(),
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
                            map.tacticalDescription!,
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

  Widget _biography(BuildContext context, MapData map) {
    final descriptionName = map.displayName.toLowerCase();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Image.network(
                map.displayIcon!,
                height: 250,
                width: 250,
                color: Color.fromARGB(255, 255, 255, 255),
                colorBlendMode: BlendMode.modulate,
              ),
              onTap: () {
                FullscreenImageViewer.open(
                  context: context,
                  child: GestureDetector(
                    child: Hero(
                      tag: 'hero',
                      child: Image.network(map.displayIcon!),
                    ),
                    onTap: () => Get.back(),
                  ),
                );
              },
            ),
          ),
          Text(
            "// REGIÕES",
            style: TextStyle(
              color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 2.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              AppStrings.ascent,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                letterSpacing: 2.0,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _specialAbilities(MapData map) {
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
