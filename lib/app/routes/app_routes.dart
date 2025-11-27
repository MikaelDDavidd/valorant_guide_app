part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const AGENT_DETAILS = _Paths.AGENT_DETAILS;
  static const WEAPON_DETAILS = _Paths.WEAPON_DETAILS;
  static const MAP_DETAILS = _Paths.MAP_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const AGENT_DETAILS = '/agent-details';
  static const WEAPON_DETAILS = '/weapon-details';
  static const MAP_DETAILS = '/map-details';
}
