part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const AGENT_DETAILS = _Paths.AGENT_DETAILS;
  static const WEAPON_DETAILS = _Paths.WEAPON_DETAILS;
  static const MAP_DETAILS = _Paths.MAP_DETAILS;
  static const PLAYERS = _Paths.PLAYERS;
  static const PLAYER_DETAILS = _Paths.PLAYER_DETAILS;
  static const MATCH_DETAILS = _Paths.MATCH_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const AGENT_DETAILS = '/agent-details';
  static const WEAPON_DETAILS = '/weapon-details';
  static const MAP_DETAILS = '/map-details';
  static const PLAYERS = '/players';
  static const PLAYER_DETAILS = '/player-details';
  static const MATCH_DETAILS = '/match-details/:matchId';
}
