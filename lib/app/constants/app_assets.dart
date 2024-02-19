class AppAssets {
  static const String baseEndPoint = 'https://valorant-api.com/v1';
  static const String agentsEndPoint = '$baseEndPoint/agents/?isPlayableCharacter=true&language=pt-BR';
  static const String mapsEndPoint = '$baseEndPoint/maps$langaugeParameter';
  static const String weaponsEndPont = '$baseEndPoint/weapons$langaugeParameter';
  static const String langaugeParameter = '/?language=pt-BR';
}
