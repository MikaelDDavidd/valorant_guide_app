# Miscellaneous Endpoints

**Status:** Not Implemented (Low Priority)

## Content Tiers (Skin Rarity)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/contenttiers` | List all tiers |
| GET | `/contenttiers/{uuid}` | Get single tier |

### ContentTier Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "devName": "string",
  "rank": number,
  "juiceValue": number,
  "juiceCost": number,
  "highlightColor": "hex with alpha",
  "displayIcon": "URL",
  "assetPath": "string"
}
```

### Tier Ranks

| Rank | Name | Color |
|------|------|-------|
| 0 | Select | #5a9fe2 |
| 1 | Deluxe | #009587 |
| 2 | Premium | #d1548d |
| 3 | Ultra | #fad663 |
| 4 | Exclusive | #f5955b |

---

## Themes

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/themes` | List all themes |
| GET | `/themes/{uuid}` | Get single theme |

### Theme Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayIcon": "URL" | null,
  "storeFeaturedImage": "URL" | null,
  "assetPath": "string"
}
```

---

## Level Borders

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/levelborders` | List all borders |
| GET | `/levelborders/{uuid}` | Get single border |

### LevelBorder Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "startingLevel": number,
  "levelNumberAppearance": "URL",
  "smallPlayerCardAppearance": "URL",
  "assetPath": "string"
}
```

### Border Levels

Borders unlock at: 1, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 420, 440, 460, 480

---

## Ceremonies

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/ceremonies` | List all ceremonies |
| GET | `/ceremonies/{uuid}` | Get single ceremony |

### Ceremony Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "assetPath": "string"
}
```

### Available Ceremonies

- ACE - Kill all 5 enemies
- CLUTCH - Win round as last alive
- FLAWLESS - Win round without deaths
- TEAM ACE - Each player gets a kill
- THRIFTY - Win with economic disadvantage
- COMBAT SCORE MVP - Highest combat score

---

## Events

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/events` | List all events |
| GET | `/events/{uuid}` | Get single event |

### Event Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "shortDisplayName": "string",
  "startTime": "ISO 8601",
  "endTime": "ISO 8601",
  "assetPath": "string"
}
```

---

## Flex (Totems)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/flex` | List all totems |
| GET | `/flex/{uuid}` | Get single totem |

### Flex Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayNameAllCaps": "string",
  "displayIcon": "URL",
  "assetPath": "string"
}
```

---

## Version

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/version` | Get current version |

### Version Object

```json
{
  "manifestId": "string",
  "branch": "string",
  "version": "string",
  "buildVersion": "string",
  "engineVersion": "string",
  "riotClientVersion": "string",
  "riotClientBuild": "string",
  "buildDate": "ISO 8601"
}
```

---

## Implementation Notes

These endpoints are lower priority but can enhance the app:

1. **Content Tiers** - Use for skin rarity badges/colors
2. **Themes** - Group skins by collection
3. **Level Borders** - Show account level progression
4. **Ceremonies** - Explain in-game achievements
5. **Version** - Show current game version in settings/about
