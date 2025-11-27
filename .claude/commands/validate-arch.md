---
description: Validate Clean Architecture compliance
argument-hint: "[module-name]"
allowed-tools: Glob, Read, Grep
---

Analyze the Clean Architecture implementation for module "$ARGUMENTS" (or all modules if not specified).

Check:

1. **Directory Structure**
   - modules/{name}/data/ exists with datasources/, models/, repositories/
   - modules/{name}/domain/ exists with entities/, repositories/, usecases/
   - modules/{name}/presentation/ exists with bindings/, controllers/, views/

2. **Layer Dependencies**
   - Domain layer has NO imports from data or presentation
   - Data layer only imports from domain (entities, repository interfaces)
   - Presentation only imports from domain (use cases, entities)

3. **Naming Conventions**
   - Entities: {name}_entity.dart
   - Models: {name}_model.dart with toEntity() method
   - Repository interfaces: i_{name}_repository.dart
   - Repository implementations: {name}_repository_impl.dart
   - Use cases: {verb}_{name}s_usecase.dart

4. **Implementation Patterns**
   - Use cases extend UseCase<Type, Params>
   - Use cases return Future<Either<Failure, T>>
   - Repositories use Either for error handling
   - Models have fromJson/toJson and toEntity

Report:
- ✓ Compliant items
- ⚠ Warnings (minor issues)
- ✗ Violations (must fix)
- Specific file:line references
