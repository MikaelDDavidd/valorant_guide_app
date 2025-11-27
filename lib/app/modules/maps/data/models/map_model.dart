import 'package:valorant_guide_app/app/modules/maps/domain/entities/map_entity.dart';

class MapModel {
  final String uuid;
  final String displayName;
  final String narrativeDescription;
  final String tacticalDescription;
  final String? displayIcon;
  final String splash;

  MapModel({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    this.displayIcon,
    required this.splash,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      narrativeDescription: json['narrativeDescription'] ?? '',
      tacticalDescription: json['tacticalDescription'] ?? '',
      displayIcon: json['displayIcon'],
      splash: json['splash'] ?? '',
    );
  }

  MapEntity toEntity() {
    return MapEntity(
      uuid: uuid,
      displayName: displayName,
      narrativeDescription: narrativeDescription,
      tacticalDescription: tacticalDescription,
      displayIcon: displayIcon,
      splash: splash,
    );
  }
}
