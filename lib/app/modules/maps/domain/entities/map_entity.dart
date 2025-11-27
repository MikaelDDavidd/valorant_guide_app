import 'package:equatable/equatable.dart';

class MapEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String narrativeDescription;
  final String tacticalDescription;
  final String? displayIcon;
  final String splash;

  const MapEntity({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    this.displayIcon,
    required this.splash,
  });

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        narrativeDescription,
        tacticalDescription,
        displayIcon,
        splash,
      ];
}
