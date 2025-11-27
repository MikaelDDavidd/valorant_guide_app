# Cosmetics Endpoints

**Status:** Not Implemented (High Priority)

## Buddies (Weapon Charms)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/buddies` | List all buddies |
| GET | `/buddies/{uuid}` | Get single buddy |
| GET | `/buddies/levels` | List all buddy levels |
| GET | `/buddies/levels/{uuid}` | Get single buddy level |

### Buddy Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "isHiddenIfNotOwned": boolean,
  "themeUuid": "string" | null,
  "displayIcon": "URL",
  "assetPath": "string",
  "levels": [BuddyLevel]
}
```

### BuddyLevel Object

```json
{
  "uuid": "string",
  "charmLevel": number,
  "hideIfNotOwned": boolean,
  "displayName": "string",
  "displayIcon": "URL",
  "assetPath": "string"
}
```

---

## Player Cards (Banners)

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/playercards` | List all cards |
| GET | `/playercards/{uuid}` | Get single card |

### PlayerCard Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "isHiddenIfNotOwned": boolean,
  "themeUuid": "string" | null,
  "displayIcon": "URL",
  "smallArt": "URL",
  "wideArt": "URL",
  "largeArt": "URL",
  "assetPath": "string"
}
```

### Card Assets

- `displayIcon` - Icon thumbnail
- `smallArt` - Small banner (128x128)
- `wideArt` - Wide format (452x128)
- `largeArt` - Large format (436x1024)

---

## Sprays

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/sprays` | List all sprays |
| GET | `/sprays/{uuid}` | Get single spray |
| GET | `/sprays/levels` | List all spray levels |
| GET | `/sprays/levels/{uuid}` | Get single spray level |

### Spray Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "category": "string" | null,
  "themeUuid": "string" | null,
  "isNullSpray": boolean,
  "hideIfNotOwned": boolean,
  "displayIcon": "URL",
  "fullIcon": "URL" | null,
  "fullTransparentIcon": "URL" | null,
  "animationPng": "URL" | null,
  "animationGif": "URL" | null,
  "assetPath": "string",
  "levels": [SprayLevel]
}
```

### SprayLevel Object

```json
{
  "uuid": "string",
  "sprayLevel": number,
  "displayName": "string",
  "displayIcon": "URL" | null,
  "assetPath": "string"
}
```

### Spray Categories

- `EAresSprayCategory::Contextual` - Context-based sprays

---

## Player Titles

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/playertitles` | List all titles |
| GET | `/playertitles/{uuid}` | Get single title |

### PlayerTitle Object

```json
{
  "uuid": "string",
  "displayName": "string",
  "titleText": "string",
  "isHiddenIfNotOwned": boolean,
  "assetPath": "string"
}
```

---

## Implementation Notes

### Buddies Module Structure

```
lib/app/modules/buddies/
├── data/
│   ├── datasources/
│   │   ├── buddies_remote_datasource.dart
│   │   └── buddies_local_datasource.dart
│   ├── models/
│   │   └── buddy_model.dart
│   └── repositories/
│       └── buddies_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── buddy.dart
│   ├── repositories/
│   │   └── i_buddies_repository.dart
│   └── usecases/
│       └── get_buddies_usecase.dart
└── presentation/
    ├── bindings/
    │   └── buddies_binding.dart
    ├── controllers/
    │   └── buddies_controller.dart
    └── views/
        ├── buddies_view.dart
        └── buddy_details_view.dart
```

### Player Cards Module Structure

```
lib/app/modules/playercards/
├── data/
│   ├── datasources/
│   ├── models/
│   │   └── playercard_model.dart
│   └── repositories/
├── domain/
│   ├── entities/
│   │   └── playercard.dart
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bindings/
    ├── controllers/
    └── views/
```

### Features to Implement

1. **Buddies View**
   - Grid view of all buddies
   - Filter by theme
   - Search by name

2. **Player Cards View**
   - Grid with card previews
   - Detail view with all art sizes
   - Filter by theme/event

3. **Sprays View**
   - Grid with spray icons
   - Animated preview for GIF sprays
   - Category filter

4. **Titles View**
   - List of all titles
   - Search functionality
