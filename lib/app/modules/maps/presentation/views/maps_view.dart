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
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final map = controller.filteredMaps[index];
        return _buildMapCard(context, map, index);
      },
    );
  }

  BorderRadius _getCardShape(int index) {
    final shapes = [
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(4),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(20),
      ),
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
    ];
    return shapes[index % shapes.length];
  }

  Matrix4 _getCardTransform(int index) {
    final transforms = [
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(-0.02)
        ..rotateX(-0.03),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(0.02)
        ..rotateX(-0.03),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(-0.02)
        ..rotateX(0.02),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(0.02)
        ..rotateX(0.02),
    ];
    return transforms[index % transforms.length];
  }

  Alignment _getTransformAlignment(int index) {
    final alignments = [
      FractionalOffset.bottomLeft,
      FractionalOffset.bottomRight,
      FractionalOffset.topLeft,
      FractionalOffset.topRight,
    ];
    return alignments[index % alignments.length];
  }

  String _formatCoordinates(String? coordinates) {
    if (coordinates == null || coordinates.isEmpty) return '';
    final parts = coordinates.split(',');
    if (parts.isEmpty) return '';
    return parts.first.trim();
  }

  Widget _buildMapCard(BuildContext context, MapEntity map, int index) {
    final shape = _getCardShape(index);
    final backgroundImage = map.splash;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.MAP_DETAILS, arguments: map);
      },
      child: Transform(
        transform: _getCardTransform(index),
        alignment: _getTransformAlignment(index),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: shape,
            boxShadow: [
              BoxShadow(
                color: AppColors.gradientStartColor.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: shape,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: backgroundImage,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      Shimmer.fromColors(
                    baseColor: AppColors.grey.withAlpha(30),
                    highlightColor: AppColors.grey.withAlpha(60),
                    child: Container(
                      color: AppColors.gradientStartColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.gradientStartColor,
                    child: const Icon(
                      Icons.map,
                      color: AppColors.white,
                      size: 48,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(50),
                        Colors.black.withAlpha(200),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
                if (map.displayIcon != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.white.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: map.displayIcon!,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        map.displayName.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 6,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (map.tacticalDescription.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gradientStartColor.withAlpha(180),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                map.tacticalDescription,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          if (map.coordinates != null &&
                              map.coordinates!.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _formatCoordinates(map.coordinates),
                                style: TextStyle(
                                  color: AppColors.white.withAlpha(180),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
