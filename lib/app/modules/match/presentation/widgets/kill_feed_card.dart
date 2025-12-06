import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class KillFeedCard
    extends
        StatelessWidget {
  final KillEntity kill;
  final List<
    PlayerDetailEntity
  >
  allPlayers;

  const KillFeedCard({
    Key? key,
    required this.kill,
    required this.allPlayers,
  }) : super(
         key: key,
       );

  @override
  Widget build(
    BuildContext context,
  ) {
    final killer = allPlayers.firstWhere(
      (
        p,
      ) =>
          p.puuid ==
          kill.killerPuuid,
    );
    final victim = allPlayers.firstWhere(
      (
        p,
      ) =>
          p.puuid ==
          kill.victimPuuid,
    );

    final killerColor =
        killer.team.toLowerCase() ==
            'red'
        ? AppColors.red
        : AppColors.blue;
    final victimColor =
        victim.team.toLowerCase() ==
            'red'
        ? AppColors.red
        : AppColors.blue;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 2,
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                ),
                Image.asset(
                  'assets/images/Base_Kill_Banner.png',
                  height: 65,
                  width: 65,
                  color: killerColor,
                  errorBuilder:
                      (
                        context,
                        error,
                        stackTrace,
                      ) => Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: killerColor,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.white.withOpacity(
                      0.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 12,
                top: 12,
              ),
              padding: const EdgeInsets.all(
                12,
              ),
              decoration: BoxDecoration(
                color: AppColors.detailListBackground,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  CachedNetworkImage(
                    imageUrl: killer.assets.agent.small,
                    height: 30,
                    width: 30,
                    errorWidget:
                        (
                          context,
                          url,
                          error,
                        ) => const SizedBox(),
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: killer.name,
                                style: TextStyle(
                                  color: killerColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' eliminated ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(
                                    0.5,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: victim.name,
                                style: TextStyle(
                                  color: victimColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${(kill.killTimeInMatch / 60000).toStringAsFixed(0)}:${(kill.killTimeInMatch % 60000 / 1000).toStringAsFixed(0).padLeft(2, '0')}',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white.withOpacity(
                              0.4,
                            ),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  CachedNetworkImage(
                    imageUrl: victim.assets.agent.small,
                    height: 30,
                    width: 30,
                    errorWidget:
                        (
                          context,
                          url,
                          error,
                        ) => const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
