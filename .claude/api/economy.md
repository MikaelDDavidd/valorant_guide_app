# Economy Endpoints

**Status:** Not Implemented (Medium Priority)

## Bundles

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/bundles` | List all bundles |
| GET | `/bundles/{uuid}` | Get single bundle |

### Bundle Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayNameSubText": "string" | null,
  "description": "string",
  "extraDescription": "string" | null,
  "promoDescription": "string" | null,
  "useAdditionalContext": boolean,
  "displayIcon": "URL",
  "displayIcon2": "URL",
  "logoIcon": "URL" | null,
  "verticalPromoImage": "URL" | null,
  "assetPath": "string"
}
```

### Notable Bundles

- Premium collections (Elderflame, Spectrum, Champions)
- Battle Pass bundles
- Event bundles
- Collaboration bundles

---

## Contracts

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/contracts` | List all contracts |
| GET | `/contracts/{uuid}` | Get single contract |

### Contract Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayIcon": "URL" | null,
  "shipIt": boolean,
  "useLevelVPCostOverride": boolean,
  "levelVPCostOverride": number,
  "freeRewardScheduleUuid": "string",
  "content": ContractContent,
  "assetPath": "string"
}
```

### ContractContent Object

```json
{
  "relationType": "Agent" | "Event" | "Season",
  "relationUuid": "string",
  "chapters": [Chapter],
  "premiumRewardScheduleUuid": "string" | null,
  "premiumVPCost": number
}
```

### Chapter Object

```json
{
  "isEpilogue": boolean,
  "levels": [Level],
  "freeRewards": [Reward] | null
}
```

### Level Object

```json
{
  "reward": Reward,
  "xp": number,
  "vpCost": number,
  "isPurchasableWithVP": boolean,
  "doughCost": number,
  "isPurchasableWithDough": boolean
}
```

### Reward Object

```json
{
  "type": "Spray" | "PlayerCard" | "Title" | "Currency" | "EquippableCharmLevel" | "EquippableSkinLevel",
  "uuid": "string",
  "amount": number,
  "isHighlighted": boolean
}
```

### Contract Types

- Agent Contracts (unlock agents + rewards)
- Battle Pass (seasonal rewards)
- Event Passes (limited time)

---

## Currencies

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/currencies` | List all currencies |
| GET | `/currencies/{uuid}` | Get single currency |

### Currency Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "displayNameSingular": "string",
  "displayIcon": "URL",
  "largeIcon": "URL",
  "rewardPreviewIcon": "URL",
  "assetPath": "string"
}
```

### Currency Types

| Name | Description |
|------|-------------|
| VALORANT Points (VP) | Premium currency (purchased) |
| Radianite Points | Skin upgrade currency |
| Kingdom Credits | Free currency (gameplay) |
| Free Agents | Agent unlock currency |

---

## Gear (Shields)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/gear` | List all gear |
| GET | `/gear/{uuid}` | Get single gear |

### Gear Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "description": "string",
  "descriptions": ["string"],
  "details": [{ "name": "string", "value": "string" }],
  "displayIcon": "URL",
  "assetPath": "string",
  "shopData": ShopData
}
```

### Available Gear

| Name | Cost | Shields |
|------|------|---------|
| Light Shields | 400 | 25 |
| Heavy Shields | 1000 | 50 |

---

## Implementation Notes

### Bundles Module Structure

```
lib/app/modules/bundles/
├── data/
│   ├── datasources/
│   │   └── bundles_remote_datasource.dart
│   ├── models/
│   │   └── bundle_model.dart
│   └── repositories/
│       └── bundles_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── bundle.dart
│   ├── repositories/
│   │   └── i_bundles_repository.dart
│   └── usecases/
│       └── get_bundles_usecase.dart
└── presentation/
    ├── bindings/
    │   └── bundles_binding.dart
    ├── controllers/
    │   └── bundles_controller.dart
    └── views/
        ├── bundles_view.dart
        └── bundle_details_view.dart
```

### Features to Implement

1. **Bundles View**
   - Showcase all skin bundles
   - Bundle art gallery
   - Items in bundle

2. **Contracts View**
   - Agent contract progress visualization
   - Battle pass rewards preview
   - XP requirements per level

3. **Economy Info**
   - Currency explanations
   - Gear/shield stats comparison
