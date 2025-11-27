# Coding Standards

## Language

- **Code:** English only
- **Comments:** None (code should be self-documenting)
- **UI Text:** Portuguese (pt-BR) via constants

## File Naming

```
snake_case.dart           # All Dart files
feature_entity.dart       # Entities
feature_model.dart        # Models/DTOs
feature_controller.dart   # Controllers
feature_view.dart         # Views
feature_binding.dart      # Bindings
i_feature_repository.dart # Repository interfaces (prefix with i_)
feature_repository_impl.dart # Repository implementations (suffix with _impl)
```

## Class Naming

```dart
PascalCase                // Classes
AgentEntity               // Entities
AgentModel                // Models
AgentsController          // Controllers (plural feature name)
AgentsView                // Views
AgentsBinding             // Bindings
IAgentRepository          // Interfaces (prefix with I)
AgentRepositoryImpl       // Implementations (suffix with Impl)
GetAgentsUseCase          // Use cases (verb + noun + UseCase)
```

## Directory Structure

```
feature/
├── data/
│   ├── datasources/      # Data sources (remote, local)
│   ├── models/           # DTOs with JSON serialization
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Business objects
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business logic
└── presentation/
    ├── bindings/         # DI configuration
    ├── controllers/      # GetX controllers
    ├── views/            # Screens/pages
    └── widgets/          # Feature-specific widgets
```

## GetX Conventions

### Controllers

```dart
class FeatureController extends GetxController {
  // Observables
  final items = <ItemEntity>[].obs;
  final isLoading = false.obs;
  final error = Rxn<String>();

  // Lifecycle
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // Methods
  Future<void> loadData() async {
    isLoading.value = true;
    // ...
    isLoading.value = false;
  }
}
```

### Bindings

```dart
class FeatureBinding extends Bindings {
  @override
  void dependencies() {
    // Order: DataSource → Repository → UseCase → Controller
    Get.lazyPut(() => FeatureDataSource());
    Get.lazyPut<IFeatureRepository>(() => FeatureRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetFeatureUseCase(Get.find()));
    Get.lazyPut(() => FeatureController(Get.find()));
  }
}
```

### Views

```dart
class FeatureView extends GetView<FeatureController> {
  const FeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) => ItemCard(
            item: controller.items[index],
          ),
        );
      }),
    );
  }
}
```

## Use Cases

```dart
class GetFeatureUseCase implements UseCase<List<FeatureEntity>, NoParams> {
  final IFeatureRepository _repository;

  GetFeatureUseCase(this._repository);

  @override
  Future<Either<Failure, List<FeatureEntity>>> call(NoParams params) {
    return _repository.getAll();
  }
}
```

## Error Handling

- Use `Either<Failure, T>` for error handling in domain/data
- Convert to UI state in controllers
- Show user-friendly messages via Flushbar

## Imports

```dart
// Dart/Flutter
import 'dart:async';
import 'package:flutter/material.dart';

// Packages
import 'package:get/get.dart';

// Project (relative)
import '../domain/entities/feature_entity.dart';
```

## Constants

All constants in `lib/app/utils/`:

```dart
// app_colors.dart
class AppColors {
  static const primary = Color(0xFF0F1923);
  static const accent = Color(0xFFFD4959);
}

// app_strings.dart
class AppStrings {
  static const appName = 'Valorant Guide';
}

// app_assets.dart
class AppAssets {
  static const valorantIcon = 'assets/icons/valorant_icon.svg';
}
```
