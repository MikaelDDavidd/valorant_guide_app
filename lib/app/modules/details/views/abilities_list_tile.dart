import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/models/agent.dart';
import 'package:valorant_guide_app/app/modules/details/controllers/details_controller.dart';

class AbilitiesListTile extends StatefulWidget {
  final Abilities abilities;


  AbilitiesListTile({required this.abilities});

  @override
  State<AbilitiesListTile> createState() => _AbilitiesListTileState();
}

class _AbilitiesListTileState extends State<AbilitiesListTile> {
    final controller = Get.find<DetailsController>();
  String icon = 'assets/icons/valorant_icon.svg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CachedNetworkImage(
          imageUrl: widget.abilities.displayIcon ?? "http://via.placeholder.com/50x50",
          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            widget.abilities.displayName,
            style: TextStyle(
              color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 2.0,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.abilities.description,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
        ));
  }
}
