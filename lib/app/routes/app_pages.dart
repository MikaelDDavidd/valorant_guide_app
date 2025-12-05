import 'package:get/get.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/bindings/agents_binding.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/views/agent_details_view.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/bindings/home_binding.dart';
import 'package:valorant_guide_app/app/modules/home/presentation/views/home_view.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/bindings/maps_binding.dart';
import 'package:valorant_guide_app/app/modules/maps/presentation/views/map_details_view.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/bindings/match_binding.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/pages/match_page.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/bindings/players_binding.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/views/players_view.dart';
import 'package:valorant_guide_app/app/modules/players/presentation/views/player_details_view.dart';
import 'package:valorant_guide_app/app/modules/splash/presentation/bindings/splash_binding.dart';
import 'package:valorant_guide_app/app/modules/splash/presentation/views/splash_view.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/bindings/weapons_binding.dart';
import 'package:valorant_guide_app/app/modules/weapons/presentation/views/weapon_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AGENT_DETAILS,
      page: () => const AgentDetailsView(),
      binding: AgentsBinding(),
    ),
    GetPage(
      name: _Paths.WEAPON_DETAILS,
      page: () => const WeaponDetailsView(),
      binding: WeaponsBinding(),
    ),
    GetPage(
      name: _Paths.MAP_DETAILS,
      page: () => const MapDetailsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.PLAYERS,
      page: () => const PlayersView(),
      binding: PlayersBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER_DETAILS,
      page: () => const PlayerDetailsView(),
      binding: PlayersBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_DETAILS,
      page: () => const MatchPage(),
      binding: MatchBinding(),
    ),
  ];
}
