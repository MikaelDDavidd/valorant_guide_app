---
description: Generate tests for a module
argument-hint: "<module-name>"
allowed-tools: Read, Write, Glob
---

Generate comprehensive tests for the "$ARGUMENTS" module.

Create test files mirroring the lib structure:

```
test/app/modules/$ARGUMENTS/
├── data/
│   ├── datasources/
│   │   └── ${ARGUMENTS}_remote_datasource_test.dart
│   └── repositories/
│       └── ${ARGUMENTS}_repository_impl_test.dart
├── domain/
│   └── usecases/
│       └── get_${ARGUMENTS}s_usecase_test.dart
└── presentation/
    └── controllers/
        └── ${ARGUMENTS}s_controller_test.dart
```

Test patterns:

1. **UseCase Tests**
   - Mock repository
   - Test success case (Right)
   - Test failure case (Left)
   - Verify repository called correctly

2. **Repository Tests**
   - Mock datasources
   - Test remote success
   - Test remote failure with local fallback
   - Test model to entity conversion

3. **Controller Tests**
   - Mock use cases
   - Test loading state
   - Test success state
   - Test error state

Use:
- mockito for mocking
- flutter_test
- Group tests logically
