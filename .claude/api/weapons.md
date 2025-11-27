# Weapons Endpoint

**Status:** Implemented

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/weapons` | List all weapons |
| GET | `/weapons/{uuid}` | Get single weapon |
| GET | `/weapons/skins` | List all skins |
| GET | `/weapons/skins/{uuid}` | Get single skin |
| GET | `/weapons/skinlevels` | List all skin levels |
| GET | `/weapons/skinlevels/{uuid}` | Get single skin level |
| GET | `/weapons/skinchromas` | List all chromas |
| GET | `/weapons/skinchromas/{uuid}` | Get single chroma |

## Query Parameters

- `?language=pt-BR` - Portuguese localization

## Response Structure

```json
{
  "status": 200,
  "data": [Weapon]
}
```

## Weapon Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "category": "string",
  "defaultSkinUuid": "string",
  "displayIcon": "URL",
  "killStreamIcon": "URL",
  "assetPath": "string",
  "weaponStats": WeaponStats | null,
  "shopData": ShopData | null,
  "skins": [Skin]
}
```

## WeaponStats Object

```json
{
  "fireRate": number,
  "magazineSize": number,
  "runSpeedMultiplier": number,
  "equipTimeSeconds": number,
  "reloadTimeSeconds": number,
  "firstBulletAccuracy": number,
  "shotgunPelletCount": number,
  "wallPenetration": "string",
  "feature": "string" | null,
  "fireMode": "string" | null,
  "altFireType": "string" | null,
  "adsStats": ADSStats | null,
  "altShotgunStats": AltShotgunStats | null,
  "airBurstStats": AirBurstStats | null,
  "damageRanges": [DamageRange]
}
```

## DamageRange Object

```json
{
  "rangeStartMeters": number,
  "rangeEndMeters": number,
  "headDamage": number,
  "bodyDamage": number,
  "legDamage": number
}
```

## ShopData Object

```json
{
  "cost": number,
  "category": "string",
  "shopOrderPriority": number,
  "categoryText": "string",
  "gridPosition": { "row": number, "column": number } | null,
  "canBeTrashed": boolean,
  "image": "URL" | null,
  "newImage": "URL",
  "newImage2": "URL" | null,
  "assetPath": "string"
}
```

## Skin Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "themeUuid": "string" | null,
  "contentTierUuid": "string" | null,
  "displayIcon": "URL" | null,
  "wallpaper": "URL" | null,
  "assetPath": "string",
  "chromas": [Chroma],
  "levels": [SkinLevel]
}
```

## Chroma Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayIcon": "URL" | null,
  "fullRender": "URL",
  "swatch": "URL" | null,
  "streamedVideo": "URL" | null,
  "assetPath": "string"
}
```

## SkinLevel Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "levelItem": "string" | null,
  "displayIcon": "URL" | null,
  "streamedVideo": "URL" | null,
  "assetPath": "string"
}
```

## Weapon Categories

| Category | Weapons |
|----------|---------|
| Sidearm | Classic, Shorty, Frenzy, Ghost, Sheriff |
| SMG | Stinger, Spectre |
| Shotgun | Bucky, Judge |
| Rifle | Bulldog, Guardian, Phantom, Vandal |
| Sniper | Marshal, Outlaw, Operator |
| Heavy | Ares, Odin |
| Melee | Knife |

## Content Tiers (Skin Rarity)

| UUID | Name | Color |
|------|------|-------|
| 12683d76-... | Select | #5a9fe2 |
| 0cebb8be-... | Deluxe | #009587 |
| 60bca009-... | Premium | #d1548d |
| 411e4a55-... | Ultra | #fad663 |
| e046854e-... | Exclusive | #f5955b |

## Level Items

- `EEquippableSkinLevelItem::VFX` - Visual effects
- `EEquippableSkinLevelItem::Animation` - Custom animations
- `EEquippableSkinLevelItem::Finisher` - Kill finisher
- `EEquippableSkinLevelItem::SoundEffects` - Custom sounds

## Example Request

```bash
curl "https://valorant-api.com/v1/weapons?language=pt-BR"
```
