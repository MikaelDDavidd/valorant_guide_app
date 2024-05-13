import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/models/agent.dart';
import 'package:valorant_guide_app/app/models/weapons.dart';
import 'package:valorant_guide_app/app/modules/details/controllers/details_controller.dart';

class DamageRangeStats extends StatefulWidget {
  final List<DamageRanges> damageRanges;

  const DamageRangeStats({Key? key, required this.damageRanges});

  @override
  State<DamageRangeStats> createState() => _DamageRangeStatsState();
}

class _DamageRangeStatsState extends State<DamageRangeStats> {
  final controller = Get.find<DetailsController>();
  String icon = 'assets/icons/valorant_icon.svg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: widget.damageRanges.map((range) {
            return Text(
              "${range.rangeStartMeters} / ${range.rangeEndMeters}",
              style: TextStyle(
                color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
