# Architecture

## Overview

This project follows **Clean Architecture** principles combined with **GetX** for state management and dependency injection.

## Clean Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION                            │
│  (Views, Controllers, Widgets, Bindings)                    │
├─────────────────────────────────────────────────────────────┤
│                        DOMAIN                                │
│  (Entities, Use Cases, Repository Interfaces)               │
├─────────────────────────────────────────────────────────────┤
│                         DATA                                 │
│  (Models/DTOs, Repository Implementations, DataSources)     │
└─────────────────────────────────────────────────────────────┘
```

## Module Structure

Each feature module follows this structure:

```
modules/
└── feature_name/
    ├── data/
    │   ├── datasources/
    │   │   ├── feature_local_datasource.dart
    │   │   └── feature_remote_datasource.dart
    │   ├── models/
    │   │   └── feature_dto.dart
    │   └── repositories/
    │       └── feature_repository_impl.dart
    ├── domain/
    │   ├── entities/
    │   │   └── feature_entity.dart
    │   ├── repositories/
    │   │   └── i_feature_repository.dart
    │   └── usecases/
    │       ├── get_feature_usecase.dart
    │       └── save_feature_usecase.dart
    └── presentation/
        ├── bindings/
        │   └── feature_binding.dart
        ├── controllers/
        │   └── feature_controller.dart
        ├── views/
        │   └── feature_view.dart
        └── widgets/
            └── feature_specific_widget.dart
```

## Data Flow

```
View (Obx) ──> Controller ──> UseCase ──> Repository (Interface)
     ↑                                           │
     │                                           ▼
     └──────────────────────────────── Repository (Implementation)
                                                 │
                                                 ▼
                                            DataSource
                                                 │
                                    ┌────────────┴────────────┐
                                    ▼                         ▼
                              Remote (API)              Local (Storage)
```

## GetX Integration

### Controllers
- Extend `GetxController`
- Use `.obs` for reactive state
- Inject use cases via constructor

```dart
class FeatureController extends GetxController {
  final GetFeatureUseCase _getFeatureUseCase;

  FeatureController(this._getFeatureUseCase);

  final feature = Rxn<FeatureEntity>();
  final isLoading = false.obs;
  final error = Rxn<String>();
}
```

### Bindings
- Register dependencies with `Get.lazyPut()`
- Follow dependency order: DataSource → Repository → UseCase → Controller

```dart
class FeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeatureRemoteDataSource(Get.find()));
    Get.lazyPut<IFeatureRepository>(() => FeatureRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetFeatureUseCase(Get.find()));
    Get.lazyPut(() => FeatureController(Get.find()));
  }
}
```

### Navigation
- Routes defined in `app_pages.dart`
- Use `Get.toNamed()` for navigation
- Pass arguments with `Get.arguments`

## Core Layer

Shared utilities across all modules:

```
core/
├── constants/
│   └── constants.dart       # App-wide constants
├── errors/
│   ├── exceptions.dart      # Exception classes
│   └── failures.dart        # Failure classes for error handling
├── usecases/
│   └── usecase.dart         # Base UseCase interface
└── utils/
    └── validators.dart      # Common validators
```

### Base UseCase

```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
```

## Error Handling

Use `Either` pattern for error handling:

```dart
Future<Either<Failure, List<Agent>>> getAgents() async {
  try {
    final result = await remoteDataSource.getAgents();
    return Right(result);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  }
}
```

## Dependency Rule

Inner layers should NOT depend on outer layers:
- **Domain** knows nothing about Data or Presentation
- **Data** knows about Domain (implements interfaces)
- **Presentation** knows about Domain (uses use cases)
