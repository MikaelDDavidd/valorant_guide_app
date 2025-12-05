import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';

class MapModel {
  final String uuid;
  final String displayName;
  final String narrativeDescription;
  final String tacticalDescription;
  final String? displayIcon;
  final String? listViewIcon;
  final String splash;
  final String? stylizedBackgroundImage;
  final String? coordinates;
  final List<CalloutModel> callouts;

  MapModel({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    this.displayIcon,
    this.listViewIcon,
    required this.splash,
    this.stylizedBackgroundImage,
    this.coordinates,
    this.callouts = const [],
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      narrativeDescription: json['narrativeDescription'] ?? '',
      tacticalDescription: json['tacticalDescription'] ?? '',
      displayIcon: json['displayIcon'],
      listViewIcon: json['listViewIcon'],
      splash: json['splash'] ?? '',
      stylizedBackgroundImage: json['stylizedBackgroundImage'],
      coordinates: json['coordinates'],
      callouts: (json['callouts'] as List?)
              ?.map((e) => CalloutModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  MapEntity toEntity() {
    return MapEntity(
      uuid: uuid,
      displayName: displayName,
      narrativeDescription: narrativeDescription,
      tacticalDescription: tacticalDescription,
      displayIcon: displayIcon,
      listViewIcon: listViewIcon,
      splash: splash,
      stylizedBackgroundImage: stylizedBackgroundImage,
      coordinates: coordinates,
      callouts: callouts.map((e) => e.toEntity()).toList(),
    );
  }
}

class CalloutModel {
  final String regionName;
  final String superRegionName;

  CalloutModel({
    required this.regionName,
    required this.superRegionName,
  });

  factory CalloutModel.fromJson(Map<String, dynamic> json) {
    return CalloutModel(
      regionName: json['regionName'] ?? '',
      superRegionName: json['superRegionName'] ?? '',
    );
  }

  CalloutEntity toEntity() {
    return CalloutEntity(
      regionName: regionName,
      superRegionName: superRegionName,
    );
  }
}
