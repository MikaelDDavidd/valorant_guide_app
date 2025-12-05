import 'package:equatable/equatable.dart';

class MapEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String narrativeDescription;
  final String tacticalDescription;
  final String? displayIcon;
  final String? listViewIcon;
  final String splash;
  final String? stylizedBackgroundImage;
  final String? coordinates;
  final List<CalloutEntity> callouts;

  const MapEntity({
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

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        narrativeDescription,
        tacticalDescription,
        displayIcon,
        listViewIcon,
        splash,
        stylizedBackgroundImage,
        coordinates,
        callouts,
      ];
}

class CalloutEntity extends Equatable {
  final String regionName;
  final String superRegionName;

  const CalloutEntity({
    required this.regionName,
    required this.superRegionName,
  });

  @override
  List<Object?> get props => [
        regionName,
        superRegionName
      ];
}
