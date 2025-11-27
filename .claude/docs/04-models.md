# Models & Entities

## Architecture Pattern

- **Entities** (Domain): Pure business objects, no serialization
- **Models/DTOs** (Data): JSON serialization, maps to/from entities

## Agents

### Entity

```dart
class AgentEntity {
  final String uuid;
  final String displayName;
  final String description;
  final String fullPortrait;
  final String bustPortrait;
  final String background;
  final RoleEntity role;
  final List<AbilityEntity> abilities;
}

class RoleEntity {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;
}

class AbilityEntity {
  final String slot;
  final String displayName;
  final String description;
  final String displayIcon;
}
```

### Model (DTO)

```dart
@JsonSerializable()
class AgentModel {
  final String uuid;
  final String displayName;
  final String description;
  final String? fullPortrait;
  final String? bustPortrait;
  final String? background;
  final RoleModel? role;
  final List<AbilityModel>? abilities;

  factory AgentModel.fromJson(Map<String, dynamic> json) =>
      _$AgentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentModelToJson(this);

  AgentEntity toEntity() => AgentEntity(
    uuid: uuid,
    displayName: displayName,
    // ... mapping
  );
}
```

## Weapons

### Entity

```dart
class WeaponEntity {
  final String uuid;
  final String displayName;
  final String category;
  final String displayIcon;
  final WeaponStatsEntity? weaponStats;
}

class WeaponStatsEntity {
  final double fireRate;
  final int magazineSize;
  final double reloadTimeSeconds;
  final List<DamageRangeEntity> damageRanges;
}

class DamageRangeEntity {
  final int rangeStartMeters;
  final int rangeEndMeters;
  final double headDamage;
  final double bodyDamage;
  final double legDamage;
}
```

## Maps

### Entity

```dart
class MapEntity {
  final String uuid;
  final String displayName;
  final String? tacticalDescription;
  final String? coordinates;
  final String splash;
  final String? displayIcon;
}
```

## Naming Conventions

| Layer | Suffix | Example |
|-------|--------|---------|
| Entity | Entity | `AgentEntity` |
| Model/DTO | Model or Dto | `AgentModel`, `AgentDto` |
| Generated | .g.dart | `agent_model.g.dart` |

## JSON Serialization

Using `json_serializable` package:

```yaml
dependencies:
  json_annotation: ^4.8.1

dev_dependencies:
  json_serializable: ^6.7.1
  build_runner: ^2.4.0
```

Generate with:
```bash
flutter pub run build_runner build
```

## Null Safety

- Use nullable types for optional API fields
- Provide defaults in entity constructors
- Handle null in `toEntity()` conversions
