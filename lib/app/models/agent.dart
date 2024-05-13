class AgentData {
  late final String uuid;
  late final String displayName;
  late final String description;
  late final String? bustPortrait;
  late final String? fullPortrait;
  late final bool isPlayableCharacter;
  late final Role? role;
  late final List<Abilities> abilities;

  AgentData({
    required this.uuid,
    required this.displayName,
    required this.description,
    this.bustPortrait,
    this.fullPortrait,
    required this.isPlayableCharacter,
    required this.role,
    required this.abilities,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      bustPortrait: json['bustPortrait'] ?? '',
      fullPortrait: json['fullPortrait'] ?? '',
      isPlayableCharacter: json['isPlayableCharacter'] ?? false,
      role: (json['role'] != null ? Role.fromJson(json['role']) : null),
      abilities: List.from(json['abilities']).map((e) => Abilities.fromJson(e)).toList(),
    );
  }

//  factory AgentData.fromJson(String json) => AgentData.fromMap(jsonDecode(json));
}

class Role {
  late final String uuid;
  late final String displayName;
  late final String description;
  late final String displayIcon;

  Role({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}

class Abilities {
  late final String slot;
  late final String displayName;
  late final String description;
  late final String? displayIcon;

  Abilities({
    required this.slot,
    required this.displayName,
    required this.description,
    this.displayIcon,
  });

  factory Abilities.fromJson(Map<String, dynamic> json) {
    return Abilities(
      slot: json['slot'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}
