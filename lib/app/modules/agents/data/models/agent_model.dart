import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';

class AgentModel {
  final String uuid;
  final String displayName;
  final String description;
  final String? bustPortrait;
  final String? fullPortrait;
  final String? fullPortraitV2;
  final String? background;
  final List<String> backgroundGradientColors;
  final bool isPlayableCharacter;
  final RoleModel? role;
  final List<AbilityModel> abilities;

  AgentModel({
    required this.uuid,
    required this.displayName,
    required this.description,
    this.bustPortrait,
    this.fullPortrait,
    this.fullPortraitV2,
    this.background,
    this.backgroundGradientColors = const [],
    required this.isPlayableCharacter,
    this.role,
    required this.abilities,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      bustPortrait: json['bustPortrait'],
      fullPortrait: json['fullPortrait'],
      fullPortraitV2: json['fullPortraitV2'],
      background: json['background'],
      backgroundGradientColors: (json['backgroundGradientColors'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isPlayableCharacter: json['isPlayableCharacter'] ?? false,
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      abilities: (json['abilities'] as List?)
              ?.map((e) => AbilityModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  AgentEntity toEntity() {
    return AgentEntity(
      uuid: uuid,
      displayName: displayName,
      description: description,
      bustPortrait: bustPortrait,
      fullPortrait: fullPortrait,
      fullPortraitV2: fullPortraitV2,
      background: background,
      backgroundGradientColors: backgroundGradientColors,
      isPlayableCharacter: isPlayableCharacter,
      role: role?.toEntity(),
      abilities: abilities.map((e) => e.toEntity()).toList(),
    );
  }
}

class RoleModel {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;

  RoleModel({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }

  RoleEntity toEntity() {
    return RoleEntity(
      uuid: uuid,
      displayName: displayName,
      description: description,
      displayIcon: displayIcon,
    );
  }
}

class AbilityModel {
  final String slot;
  final String displayName;
  final String description;
  final String? displayIcon;

  AbilityModel({
    required this.slot,
    required this.displayName,
    required this.description,
    this.displayIcon,
  });

  factory AbilityModel.fromJson(Map<String, dynamic> json) {
    return AbilityModel(
      slot: json['slot'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'],
    );
  }

  AbilityEntity toEntity() {
    return AbilityEntity(
      slot: slot,
      displayName: displayName,
      description: description,
      displayIcon: displayIcon,
    );
  }
}
