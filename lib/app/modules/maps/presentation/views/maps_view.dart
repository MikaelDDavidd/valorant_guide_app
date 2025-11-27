import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';
import 'package:valorant_guide_app/app/widgets/skeletons/card_skeleton.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const MapsGridSkeleton();
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

      if (controller.filteredMaps.isEmpty) {
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

      return _buildGrid();
    });
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: controller.filteredMaps.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final map = controller.filteredMaps[index];
        return _buildMapCard(context, map);
      },
    );
  }

  Widget _buildMapCard(BuildContext context, MapEntity map) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.MAP_DETAILS, arguments: map);
      },
      child: Stack(
        children: [
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.01)
              ..rotateY(-0.06)
              ..rotateX(-0.1),
            alignment: FractionalOffset.bottomLeft,
            child: Container(
              height: double.infinity,
              width: double.infinity,
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
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: map.displayIcon ?? '',
              width: 135,
              height: 135,
              fit: BoxFit.contain,
              progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                baseColor: AppColors.grey.withAlpha(30),
                highlightColor: AppColors.grey.withAlpha(60),
                child: Container(
                  width: 135,
                  height: 135,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  map.displayName,
                  style: TextStyle(
                    color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  map.tacticalDescription,
                  style: TextStyle(
                    color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
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
