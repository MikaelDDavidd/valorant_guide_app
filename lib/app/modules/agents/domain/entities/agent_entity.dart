import 'package:equatable/equatable.dart';

class AgentEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String description;
  final String? bustPortrait;
  final String? fullPortrait;
  final String? background;
  final List<String> backgroundGradientColors;
  final bool isPlayableCharacter;
  final RoleEntity? role;
  final List<AbilityEntity> abilities;

  const AgentEntity({
    required this.uuid,
    required this.displayName,
    required this.description,
    this.bustPortrait,
    this.fullPortrait,
    this.background,
    this.backgroundGradientColors = const [],
    required this.isPlayableCharacter,
    this.role,
    required this.abilities,
  });

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        description,
        bustPortrait,
        fullPortrait,
        background,
        backgroundGradientColors,
        isPlayableCharacter,
        role,
        abilities,
      ];
}

class RoleEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;

  const RoleEntity({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  @override
  List<Object?> get props => [uuid, displayName, description, displayIcon];
}

class AbilityEntity extends Equatable {
  final String slot;
  final String displayName;
  final String description;
  final String? displayIcon;

  const AbilityEntity({
    required this.slot,
    required this.displayName,
    required this.description,
    this.displayIcon,
  });

  @override
  List<Object?> get props => [slot, displayName, description, displayIcon];
}
