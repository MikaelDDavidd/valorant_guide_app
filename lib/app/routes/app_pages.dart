import 'dart:collection';

import 'package:get/get.dart';
import 'package:valorant_guide_app/app/modules/details/views/map_details_view.dart';
import 'package:valorant_guide_app/app/modules/details/views/weapon_details_view.dart';

import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/maps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => MapsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () =>  DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.MAPDETAILS,
      page: () =>  MapDetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.WEAPONDETAILS,
      page: () =>  WeaponDetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}
