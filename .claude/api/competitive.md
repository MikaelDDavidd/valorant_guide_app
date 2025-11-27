# Competitive Endpoints

**Status:** Not Implemented (High Priority)

## Competitive Tiers (Ranks)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/competitivetiers` | List all rank tables |
| GET | `/competitivetiers/{uuid}` | Get single rank table |

### CompetitiveTier Object

```json
{
  "uuid": "string",
  "assetObjectName": "string",
  "assetPath": "string",
  "tiers": [Tier]
}
```

### Tier Object

```json
{
  "tier": number,
  "tierName": "string",
  "division": "string",
  "divisionName": "string",
  "color": "hex",
  "backgroundColor": "hex",
  "smallIcon": "URL" | null,
  "largeIcon": "URL" | null,
  "rankTriangleDownIcon": "URL" | null,
  "rankTriangleUpIcon": "URL" | null
}
```

### Rank Tiers (Episode 5+)

| Tier | Name | Division |
|------|------|----------|
| 0-2 | Unranked | - |
| 3-5 | Iron | 1-3 |
| 6-8 | Bronze | 1-3 |
| 9-11 | Silver | 1-3 |
| 12-14 | Gold | 1-3 |
| 15-17 | Platinum | 1-3 |
| 18-20 | Diamond | 1-3 |
| 21-23 | Ascendant | 1-3 |
| 24-26 | Immortal | 1-3 |
| 27 | Radiant | - |

---

## Game Modes

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/gamemodes` | List all game modes |
| GET | `/gamemodes/{uuid}` | Get single game mode |
| GET | `/gamemodes/equippables` | List equippables |
| GET | `/gamemodes/equippables/{uuid}` | Get single equippable |

### GameMode Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "description": "string" | null,
  "duration": "string" | null,
  "economyType": "string" | null,
  "allowsMatchTimeouts": boolean,
  "isTeamVoiceAllowed": boolean,
  "isMinimapHidden": boolean,
  "orbCount": number,
  "roundsPerHalf": number,
  "teamRoles": ["string"] | null,
  "gameFeatureOverrides": [FeatureOverride] | null,
  "gameRuleBoolOverrides": [RuleOverride] | null,
  "displayIcon": "URL" | null,
  "listViewIconTall": "URL" | null,
  "assetPath": "string"
}
```

### Available Game Modes

| Name | Description |
|------|-------------|
| Standard | Competitive/Unrated 5v5 |
| Spike Rush | Fast rounds, random weapons |
| Deathmatch | Free-for-all practice |
| Escalation | Team deathmatch, weapon rotation |
| Replication | All same agent |
| Swiftplay | Shorter standard games |
| Premier | Tournament-style competitive |
| Team Deathmatch | 5v5 respawn mode |

---

## Seasons

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/seasons` | List all seasons |
| GET | `/seasons/{uuid}` | Get single season |
| GET | `/seasons/competitive` | List competitive seasons |
| GET | `/seasons/competitive/{uuid}` | Get competitive season |

### Season Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "title": "string" | null,
  "type": "EAresSeasonType::Act" | null,
  "startTime": "ISO 8601",
  "endTime": "ISO 8601",
  "parentUuid": "string" | null,
  "assetPath": "string"
}
```

### Season Hierarchy

```
Episode 1 (parentUuid: null)
├── Act I (parentUuid: Episode1UUID)
├── Act II
└── Act III
Episode 2
├── Act I
...
```

---

## Implementation Notes

### Ranks Module Structure

```
lib/app/modules/ranks/
├── data/
│   ├── datasources/
│   │   └── ranks_remote_datasource.dart
│   ├── models/
│   │   └── rank_tier_model.dart
│   └── repositories/
│       └── ranks_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── rank_tier.dart
│   ├── repositories/
│   │   └── i_ranks_repository.dart
│   └── usecases/
│       └── get_ranks_usecase.dart
└── presentation/
    ├── bindings/
    │   └── ranks_binding.dart
    ├── controllers/
    │   └── ranks_controller.dart
    └── views/
        └── ranks_view.dart
```

### Features to Implement

1. **Ranks View**
   - Visual rank ladder
   - Rank icons with colors
   - Tier descriptions

2. **Game Modes View**
   - List of all modes
   - Mode descriptions
   - Rules and settings

3. **Seasons View**
   - Timeline of episodes/acts
   - Current season highlight
   - Historical data
