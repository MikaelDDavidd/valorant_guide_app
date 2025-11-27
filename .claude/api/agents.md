# Agents Endpoint

**Status:** Implemented

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/agents` | List all agents |
| GET | `/agents/{uuid}` | Get single agent |

## Query Parameters

- `?language=pt-BR` - Portuguese localization
- `?isPlayableCharacter=true` - Exclude NPCs (Sova's drone, etc)

## Response Structure

```json
{
  "status": 200,
  "data": [Agent]
}
```

## Agent Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "description": "string",
  "developerName": "string",
  "releaseDate": "ISO 8601",
  "characterTags": ["string"] | null,
  "displayIcon": "URL",
  "displayIconSmall": "URL",
  "bustPortrait": "URL",
  "fullPortrait": "URL",
  "fullPortraitV2": "URL",
  "killfeedPortrait": "URL",
  "minimapPortrait": "URL",
  "homeScreenPromoTileImage": "URL" | null,
  "background": "URL",
  "backgroundGradientColors": ["hex"],
  "assetPath": "string",
  "isFullPortraitRightFacing": boolean,
  "isPlayableCharacter": boolean,
  "isAvailableForTest": boolean,
  "isBaseContent": boolean,
  "role": Role,
  "recruitmentData": RecruitmentData | null,
  "abilities": [Ability],
  "voiceLine": null
}
```

## Role Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "description": "string",
  "displayIcon": "URL",
  "assetPath": "string"
}
```

## Ability Object

```json
{
  "slot": "Ability1" | "Ability2" | "Grenade" | "Ultimate" | "Passive",
  "displayName": "string",
  "description": "string",
  "displayIcon": "URL"
}
```

## Role Types

| UUID | Name | Description |
|------|------|-------------|
| dbe8757e-... | Duelist | Self-sufficient fraggers |
| 1b47567f-... | Initiator | Challenge angles, set up team |
| 5fc02f99-... | Sentinel | Defensive experts, lockdown |
| 4ee40330-... | Controller | Slice territory, block vision |

## Assets

- `displayIcon` - Agent icon (512x512)
- `displayIconSmall` - Small icon (128x128)
- `bustPortrait` - Half body portrait
- `fullPortrait` - Full body (right side)
- `fullPortraitV2` - Full body (centered)
- `background` - Agent background art
- `killfeedPortrait` - Kill feed icon
- `minimapPortrait` - Minimap icon

## Example Request

```bash
curl "https://valorant-api.com/v1/agents?language=pt-BR&isPlayableCharacter=true"
```
