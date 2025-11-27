---
description: Generate Clean Architecture module scaffold
argument-hint: "<module-name>"
allowed-tools: Bash, Write, Read
---

Generate a complete Clean Architecture module scaffold for the "$ARGUMENTS" feature.

Create the following structure in lib/app/modules/$ARGUMENTS/:

```
$ARGUMENTS/
├── data/
│   ├── datasources/
│   │   ├── ${ARGUMENTS}_remote_datasource.dart
│   │   └── ${ARGUMENTS}_local_datasource.dart
│   ├── models/
│   │   └── ${ARGUMENTS}_model.dart
│   └── repositories/
│       └── ${ARGUMENTS}_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── ${ARGUMENTS}_entity.dart
│   ├── repositories/
│   │   └── i_${ARGUMENTS}_repository.dart
│   └── usecases/
│       ├── get_${ARGUMENTS}s_usecase.dart
│       └── get_${ARGUMENTS}_by_id_usecase.dart
└── presentation/
    ├── bindings/
    │   └── ${ARGUMENTS}s_binding.dart
    ├── controllers/
    │   └── ${ARGUMENTS}s_controller.dart
    ├── views/
    │   ├── ${ARGUMENTS}s_view.dart
    │   └── ${ARGUMENTS}_details_view.dart
    └── widgets/
```

Include:
- Proper imports
- Base class implementations (UseCase, Either from dartz)
- GetX patterns (GetxController, Bindings)
- toEntity() in models
- Repository interface with proper method signatures
