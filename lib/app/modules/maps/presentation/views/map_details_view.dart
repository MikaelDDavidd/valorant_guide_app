import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/controllers/maps_controller.dart';

class MapDetailsView extends StatelessWidget {
  const MapDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as MapEntity;
    final controller = Get.find<MapsController>();

    return Obx(() => Scaffold(
          backgroundColor:
              AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopImage(map, controller),
                _buildMapInfo(context, map, controller),
                _buildDescription(map, controller),
              ],
            ),
          ),
        ));
  }

  Widget _buildTopImage(MapEntity map, MapsController controller) {
    return Container(
      color: Colors.transparent,
      height: 300.0,
      child: Stack(
        children: [
          Image.network(
            map.splash,
            color: const Color.fromARGB(144, 255, 255, 255),
            colorBlendMode: BlendMode.modulate,
            fit: BoxFit.cover,
            width: double.infinity,
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
                        color: AppColors
                            .appColorsTheme[controller.homeThemeIndex.value]
                            .text,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (map.tacticalDescription.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: AppColors.darkPurple,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              map.tacticalDescription,
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

  Widget _buildMapInfo(
      BuildContext context, MapEntity map, MapsController controller) {
    if (map.displayIcon == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                FullscreenImageViewer.open(
                  context: context,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Hero(
                      tag: 'map-${map.uuid}',
                      child: Image.network(map.displayIcon!),
                    ),
                  ),
                );
              },
              child: Image.network(
                map.displayIcon!,
                height: 250,
                width: 250,
                color: const Color.fromARGB(255, 255, 255, 255),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(MapEntity map, MapsController controller) {
    if (map.narrativeDescription.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// DESCRIÇÃO',
            style: TextStyle(
              color: AppColors
                  .appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 2.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              map.narrativeDescription,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                letterSpacing: 2.0,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
