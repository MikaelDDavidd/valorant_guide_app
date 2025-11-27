# Modules

## Overview

The app is organized into feature modules following Clean Architecture:

```
modules/
├── agents/        # Agent browsing and details
├── weapons/       # Weapon browsing and details
├── maps/          # Map browsing and details
├── home/          # Main tab navigation
└── settings/      # App settings (theme, language)
```

## Agents Module

Displays all playable Valorant agents with details.

### Structure

```
agents/
├── data/
│   ├── datasources/
│   │   ├── agent_local_datasource.dart
│   │   └── agent_remote_datasource.dart
│   ├── models/
│   │   └── agent_model.dart
│   └── repositories/
│       └── agent_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── agent_entity.dart
│   ├── repositories/
│   │   └── i_agent_repository.dart
│   └── usecases/
│       ├── get_agents_usecase.dart
│       └── get_agent_by_id_usecase.dart
└── presentation/
    ├── bindings/
    │   └── agents_binding.dart
    ├── controllers/
    │   └── agents_controller.dart
    ├── views/
    │   ├── agents_view.dart
    │   └── agent_details_view.dart
    └── widgets/
        ├── agent_card.dart
        └── ability_tile.dart
```

### Use Cases

- `GetAgentsUseCase` - Fetch all playable agents
- `GetAgentByIdUseCase` - Fetch single agent details

## Weapons Module

Displays all weapons with stats and damage information.

### Use Cases

- `GetWeaponsUseCase` - Fetch all weapons
- `GetWeaponByIdUseCase` - Fetch single weapon details
- `GetWeaponsByCategoryUseCase` - Filter by category (Rifle, SMG, etc.)

### Key Views

- `WeaponsView` - Grid of weapon cards
- `WeaponDetailsView` - Detailed stats with damage range visualization

## Maps Module

Displays all game maps with tactical information.

### Use Cases

- `GetMapsUseCase` - Fetch all maps
- `GetMapByIdUseCase` - Fetch single map details

### Key Views

- `MapsView` - List of map cards with splash images
- `MapDetailsView` - Full map info with coordinates

## Home Module

Main navigation scaffold with tab bar.

### Structure

```
home/
└── presentation/
    ├── bindings/
    │   └── home_binding.dart
    ├── controllers/
    │   └── home_controller.dart
    └── views/
        └── home_view.dart
```

### Responsibilities

- Tab navigation between Agents, Weapons, Maps
- Theme toggle
- App-level state

## Settings Module (Future)

Planned features:
- Theme selection (dark/light)
- Language selection
- Cache management
- About page

## Adding a New Module

1. Create module directory structure:
```bash
mkdir -p lib/app/modules/new_feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bindings,controllers,views,widgets}}
```

2. Define entity in `domain/entities/`
3. Create repository interface in `domain/repositories/`
4. Implement use cases in `domain/usecases/`
5. Create model (DTO) in `data/models/`
6. Implement datasources in `data/datasources/`
7. Implement repository in `data/repositories/`
8. Create controller in `presentation/controllers/`
9. Create binding in `presentation/bindings/`
10. Create views in `presentation/views/`
11. Register route in `app_pages.dart`
