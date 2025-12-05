import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/controllers/maps_controller.dart';

class MapDetailsView extends StatefulWidget {
  const MapDetailsView({Key? key}) : super(key: key);

  @override
  State<MapDetailsView> createState() => _MapDetailsViewState();
}

class _MapDetailsViewState extends State<MapDetailsView> {
  late PageController _galleryController;
  int _currentGalleryIndex = 0;

  @override
  void initState() {
    super.initState();
    _galleryController = PageController();
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getGalleryImages(MapEntity map) {
    final images = <Map<String, String>>[];
    images.add({'url': map.splash, 'label': 'Splash Art'});
    if (map.displayIcon != null) {
      images.add({'url': map.displayIcon!, 'label': 'Minimap'});
    }
    if (map.stylizedBackgroundImage != null) {
      images.add({'url': map.stylizedBackgroundImage!, 'label': 'Arte Estilizada'});
    }
    if (map.listViewIcon != null) {
      images.add({'url': map.listViewIcon!, 'label': 'Ícone'});
    }
    return images;
  }

  Map<String, List<CalloutEntity>> _groupCalloutsByRegion(List<CalloutEntity> callouts) {
    final grouped = <String, List<CalloutEntity>>{};
    for (final callout in callouts) {
      final region = callout.superRegionName;
      if (!grouped.containsKey(region)) {
        grouped[region] = [];
      }
      grouped[region]!.add(callout);
    }
    return grouped;
  }

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
                _buildBanner(map, controller),
                _buildMapInfo(map, controller),
                _buildGallery(map, controller),
                if (map.callouts.isNotEmpty) _buildCallouts(map, controller),
              ],
            ),
          ),
        ));
  }

  Widget _buildBanner(MapEntity map, MapsController controller) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: map.splash,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: AppColors.gradientStartColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(100),
                    Colors.transparent,
                    AppColors.appColorsTheme[controller.homeThemeIndex.value]
                        .background
                        .withAlpha(200),
                    AppColors.appColorsTheme[controller.homeThemeIndex.value]
                        .background,
                  ],
                  stops: const [0.0, 0.3, 0.8, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  map.displayName.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (map.tacticalDescription.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gradientStartColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          map.tacticalDescription,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    if (map.coordinates != null && map.coordinates!.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.white.withAlpha(180),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            map.coordinates!,
                            style: TextStyle(
                              color: AppColors.white.withAlpha(180),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, int themeIndex) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.gradientStartColor,
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
                  AppColors.gradientStartColor.withAlpha(100),
                  AppColors.gradientStartColor.withAlpha(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapInfo(MapEntity map, MapsController controller) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('INFORMAÇÕES', controller.homeThemeIndex.value),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.sports_esports,
                    'Tipo',
                    map.tacticalDescription.isNotEmpty
                        ? map.tacticalDescription
                        : 'Padrão',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.grey.withAlpha(50),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.place,
                    'Callouts',
                    '${map.callouts.length} pontos',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.grey.withAlpha(50),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.map,
                    'Regiões',
                    _getUniqueRegionsCount(map.callouts),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getUniqueRegionsCount(List<CalloutEntity> callouts) {
    final regions = callouts.map((c) => c.superRegionName).toSet();
    return '${regions.length} áreas';
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.gradientStartColor, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey.withAlpha(180),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGallery(MapEntity map, MapsController controller) {
    final images = _getGalleryImages(map);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('GALERIA', controller.homeThemeIndex.value),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _galleryController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentGalleryIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: CachedNetworkImage(
                          imageUrl: images[index]['url']!,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.broken_image,
                            color: AppColors.grey,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _galleryController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentGalleryIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentGalleryIndex == index
                                ? AppColors.gradientStartColor
                                : AppColors.gradientStartColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    images[_currentGalleryIndex]['label']!,
                    style: const TextStyle(
                      color: AppColors.gradientStartColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallouts(MapEntity map, MapsController controller) {
    final groupedCallouts = _groupCalloutsByRegion(map.callouts);
    final sortedRegions = groupedCallouts.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('CALLOUTS', controller.homeThemeIndex.value),
          const SizedBox(height: 8),
          Text(
            'Pontos de interesse do mapa',
            style: TextStyle(
              color: AppColors.grey.withAlpha(180),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ...sortedRegions.map((region) {
            final callouts = groupedCallouts[region]!;
            return _buildRegionCallouts(region, callouts);
          }),
        ],
      ),
    );
  }

  Widget _buildRegionCallouts(String region, List<CalloutEntity> callouts) {
    Color regionColor;
    IconData regionIcon;

    switch (region.toLowerCase()) {
      case 'a':
        regionColor = Colors.green;
        regionIcon = Icons.looks_one;
        break;
      case 'b':
        regionColor = Colors.blue;
        regionIcon = Icons.looks_two;
        break;
      case 'c':
        regionColor = Colors.orange;
        regionIcon = Icons.looks_3;
        break;
      case 'meio':
      case 'mid':
        regionColor = Colors.purple;
        regionIcon = Icons.swap_horiz;
        break;
      case 'lado atacante':
      case 'attacker side':
        regionColor = Colors.red;
        regionIcon = Icons.arrow_forward;
        break;
      case 'lado defensor':
      case 'defender side':
        regionColor = Colors.teal;
        regionIcon = Icons.shield;
        break;
      default:
        regionColor = AppColors.gradientStartColor;
        regionIcon = Icons.place;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.detailListBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: regionColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: regionColor.withAlpha(30),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Icon(regionIcon, color: regionColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  region.toUpperCase(),
                  style: TextStyle(
                    color: regionColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: regionColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${callouts.length}',
                    style: TextStyle(
                      color: regionColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: callouts.map((callout) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: regionColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    callout.regionName,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
