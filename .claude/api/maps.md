# Maps Endpoint

**Status:** Implemented

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/maps` | List all maps |
| GET | `/maps/{uuid}` | Get single map |

## Query Parameters

- `?language=pt-BR` - Portuguese localization

## Response Structure

```json
{
  "status": 200,
  "data": [Map]
}
```

## Map Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "narrativeDescription": "string" | null,
  "tacticalDescription": "string" | null,
  "coordinates": "string",
  "displayIcon": "URL" | null,
  "listViewIcon": "URL",
  "listViewIconTall": "URL" | null,
  "splash": "URL",
  "stylizedBackgroundImage": "URL" | null,
  "premierBackgroundImage": "URL" | null,
  "assetPath": "string",
  "mapUrl": "string",
  "xMultiplier": number,
  "yMultiplier": number,
  "xScalarToAdd": number,
  "yScalarToAdd": number,
  "callouts": [Callout] | null
}
```

## Callout Object

```json
{
  "regionName": "string",
  "superRegionName": "string",
  "location": {
    "x": number,
    "y": number
  }
}
```

## Coordinate Conversion

To convert in-game coordinates to minimap position:

```dart
double minimapX = (gameX * xMultiplier) + xScalarToAdd;
double minimapY = (gameY * yMultiplier) + yScalarToAdd;
```

## Assets

- `displayIcon` - Minimap image (radar view)
- `listViewIcon` - List thumbnail
- `listViewIconTall` - Tall thumbnail
- `splash` - Full splash art
- `stylizedBackgroundImage` - Stylized background
- `premierBackgroundImage` - Premier mode background

## Available Maps

| Name | Type | Sites |
|------|------|-------|
| Bind | Standard | A, B |
| Haven | Standard | A, B, C |
| Split | Standard | A, B |
| Ascent | Standard | A, B |
| Icebox | Standard | A, B |
| Breeze | Standard | A, B |
| Fracture | Standard | A, B |
| Pearl | Standard | A, B |
| Lotus | Standard | A, B, C |
| Sunset | Standard | A, B |
| Abyss | Standard | A, B |
| The Range | Practice | - |

## Example Request

```bash
curl "https://valorant-api.com/v1/maps?language=pt-BR"
```
