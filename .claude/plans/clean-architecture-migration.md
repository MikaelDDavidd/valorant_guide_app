# Clean Architecture + GetX Migration Plan

## Overview

Migrate the current codebase from simple GetX structure to Clean Architecture + GetX.

## Current State

```
lib/
├── main.dart
└── app/
    ├── constants/
    ├── data/
    │   ├── http/
    │   ├── repositories/
    │   └── stores/
    ├── models/
    ├── modules/
    │   ├── home/
    │   └── details/
    └── routes/
```

## Target State

```
lib/
├── main.dart
└── app/
    ├── core/
    │   ├── constants/
    │   │   └── constants.dart
    │   ├── errors/
    │   │   ├── exceptions.dart
    │   │   └── failures.dart
    │   ├── usecases/
    │   │   └── usecase.dart
    │   └── utils/
    │       └── validators.dart
    ├── data/
    │   ├── http/
    │   │   └── http_client_service.dart
    │   └── storage/
    │       └── app_storage_keys.dart
    ├── modules/
    │   ├── agents/
    │   │   ├── data/
    │   │   │   ├── datasources/
    │   │   │   │   ├── agent_local_datasource.dart
    │   │   │   │   └── agent_remote_datasource.dart
    │   │   │   ├── models/
    │   │   │   │   └── agent_model.dart
    │   │   │   └── repositories/
    │   │   │       └── agent_repository_impl.dart
    │   │   ├── domain/
    │   │   │   ├── entities/
    │   │   │   │   └── agent_entity.dart
    │   │   │   ├── repositories/
    │   │   │   │   └── i_agent_repository.dart
    │   │   │   └── usecases/
    │   │   │       └── get_agents_usecase.dart
    │   │   └── presentation/
    │   │       ├── bindings/
    │   │       │   └── agents_binding.dart
    │   │       ├── controllers/
    │   │       │   └── agents_controller.dart
    │   │       ├── views/
    │   │       │   ├── agents_view.dart
    │   │       │   └── agent_details_view.dart
    │   │       └── widgets/
    │   ├── weapons/
    │   │   └── ... (same structure)
    │   ├── maps/
    │   │   └── ... (same structure)
    │   └── home/
    │       └── presentation/
    │           ├── bindings/
    │           ├── controllers/
    │           └── views/
    ├── routes/
    │   ├── app_pages.dart
    │   └── app_routes.dart
    ├── services/
    │   └── connectivity_service.dart
    ├── utils/
    │   ├── theme/
    │   │   ├── app_colors.dart
    │   │   ├── app_text_styles.dart
    │   │   └── app_theme.dart
    │   ├── app_assets.dart
    │   └── app_strings.dart
    └── widgets/
        └── ... (shared widgets)
```

## Migration Steps

### Phase 1: Core Setup

1. Create `lib/app/core/` directory structure
2. Create base classes:
   - `lib/app/core/errors/exceptions.dart`
   - `lib/app/core/errors/failures.dart`
   - `lib/app/core/usecases/usecase.dart`
3. Add `dartz` package for Either type:
   ```yaml
   dependencies:
     dartz: ^0.10.1
   ```

### Phase 2: Agents Module Migration

1. Create `lib/app/modules/agents/` structure
2. Move `lib/app/models/agent.dart` → entities + models:
   - Create `domain/entities/agent_entity.dart`
   - Create `data/models/agent_model.dart` with `toEntity()` method
3. Create repository interface:
   - `domain/repositories/i_agent_repository.dart`
4. Create datasources:
   - `data/datasources/agent_remote_datasource.dart`
   - `data/datasources/agent_local_datasource.dart`
5. Create repository implementation:
   - `data/repositories/agent_repository_impl.dart`
6. Create use cases:
   - `domain/usecases/get_agents_usecase.dart`
7. Update controller to use use cases
8. Update binding with new dependencies

### Phase 3: Weapons Module Migration

Same steps as Phase 2 for weapons.

### Phase 4: Maps Module Migration

Same steps as Phase 2 for maps.

### Phase 5: Home Module Refactor

1. Create simple home module structure
2. Home only manages navigation and theme
3. Each tab loads from respective module

### Phase 6: Cleanup

1. Delete old `lib/app/data/repositories/`
2. Delete old `lib/app/data/stores/`
3. Delete old `lib/app/models/`
4. Delete old `lib/app/constants/` (moved to core and utils)
5. Update imports throughout the project
6. Run `flutter analyze` and fix issues
7. Test all features

## Files to Create

### Core

```
lib/app/core/errors/exceptions.dart
lib/app/core/errors/failures.dart
lib/app/core/usecases/usecase.dart
lib/app/core/constants/api_constants.dart
```

### Per Module (agents, weapons, maps)

```
# Domain
domain/entities/{feature}_entity.dart
domain/repositories/i_{feature}_repository.dart
domain/usecases/get_{feature}s_usecase.dart
domain/usecases/get_{feature}_by_id_usecase.dart

# Data
data/models/{feature}_model.dart
data/datasources/{feature}_remote_datasource.dart
data/datasources/{feature}_local_datasource.dart
data/repositories/{feature}_repository_impl.dart

# Presentation
presentation/bindings/{feature}s_binding.dart
presentation/controllers/{feature}s_controller.dart
presentation/views/{feature}s_view.dart
presentation/views/{feature}_details_view.dart
presentation/widgets/{feature}_card.dart
```

## Dependencies to Add

```yaml
dependencies:
  dartz: ^0.10.1        # Either type for error handling
  equatable: ^2.0.5     # Value equality for entities
```

## Estimated Effort

- Phase 1 (Core Setup): Small
- Phase 2 (Agents): Medium
- Phase 3 (Weapons): Medium
- Phase 4 (Maps): Medium
- Phase 5 (Home): Small
- Phase 6 (Cleanup): Small

## Testing Strategy

After each phase:
1. Run `flutter analyze`
2. Run `flutter test`
3. Manual testing of affected features
4. Verify no regressions
