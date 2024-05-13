class MapData {
  late final String uuid;
  late final String displayName;
  late final String narrativeDescription;
  late final String tacticalDescription;
  late final String? displayIcon;
  late final String splash;
  // late final List<Callouts> callouts;

  MapData({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    required this.displayIcon,
    required this.splash,
    //  required this.callouts,
  });

  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      narrativeDescription: json['narrativeDescription'] ?? '',
      tacticalDescription: json['tacticalDescription'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      splash: json['splash'] ?? '',
      // callouts: List.from(json['callouts']).map((e) => Callouts.fromJson(e)).toList(),
    );
  }
}

class Callouts {
  late final String regioName;
  late final String superRegionName;

  Callouts({
    required this.regioName,
    required this.superRegionName,
  });

  factory Callouts.fromJson(Map<String, dynamic> json) {
    return Callouts(
      regioName: json['regioName'],
      superRegionName: json['superRegionName'],
    );
  }
}
