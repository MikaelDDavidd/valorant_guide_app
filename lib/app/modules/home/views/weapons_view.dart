import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/home_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/weapon_controller.dart';

class WeaponsView extends GetView {
  WeaponsView({Key? key}) : super(key: key);
  final mapController = Get.find<WeaponController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: circularProgressIndicator(),
    );
  }

  Widget circularProgressIndicator() {
    final store = mapController.store;
    return AnimatedBuilder(
        animation: Listenable.merge([store.isLoading, store.erro, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty) {
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
          } else {
            return _gridCards();
          }
        });
  }

  Widget _gridCards() {
    final controller = Get.find<HomeController>();
    final store = mapController.store;
    return GridView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: store.state.value.length,
      // Generate 100 widgets that display their index in the List.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        childAspectRatio: 1.5,
        crossAxisCount: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = store.state.value[index];
        return InkWell(
          onTap: () {
            //        Navigator.pushNamed(context, Routes.detail, arguments: _postStore.agentList!.data[index]);
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
                      color: Colors.purple),
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
                    imageUrl: item.displayIcon ?? '',
                    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        const Icon(Icons.error),
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
                      item.displayName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.appColorsTheme[controller.homeThemeIndex.value].text,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Text(
                      item.displayName,
                      textAlign: TextAlign.center,
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
      },
    );
  }
}
