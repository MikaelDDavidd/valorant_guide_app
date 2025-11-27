---
description: Migrate existing module to Clean Architecture
argument-hint: "<module-name>"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

Migrate the "$ARGUMENTS" module to Clean Architecture following the plan in .claude/plans/clean-architecture-migration.md.

Steps:

1. **Analyze Current State**
   - Find existing files for this feature in lib/app/
   - Identify models, repositories, controllers, views

2. **Create Domain Layer**
   - Extract entity from existing model (remove JSON serialization)
   - Create repository interface based on existing repository methods
   - Create use cases for each repository method

3. **Create Data Layer**
   - Keep model with JSON serialization, add toEntity()
   - Create remote datasource (extract HTTP calls)
   - Create local datasource (cache with GetStorage)
   - Implement repository with datasources

4. **Update Presentation Layer**
   - Refactor controller to use use cases instead of repositories
   - Update binding with new dependency chain
   - Keep views unchanged (they use controller)

5. **Cleanup**
   - Update imports throughout
   - Run flutter analyze
   - Verify no regressions

Migration rules:
- Do NOT delete old files until new ones work
- Maintain backward compatibility during transition
- Create git-friendly changes (reviewable diffs)
