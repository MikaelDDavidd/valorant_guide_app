# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Documentation

Detailed documentation is available in `.claude/docs/`:

| Document | Description |
|----------|-------------|
| [01-quickstart.md](.claude/docs/01-quickstart.md) | Setup and running the app |
| [02-architecture.md](.claude/docs/02-architecture.md) | Clean Architecture + GetX patterns |
| [03-api.md](.claude/docs/03-api.md) | Valorant API integration |
| [04-models.md](.claude/docs/04-models.md) | Entities and DTOs |
| [05-modules.md](.claude/docs/05-modules.md) | Feature modules breakdown |
| [06-coding-standards.md](.claude/docs/06-coding-standards.md) | Code style and conventions |
| [07-features.md](.claude/docs/07-features.md) | Features and roadmap |
| [08-customization.md](.claude/docs/08-customization.md) | Commands, agents, and hooks |

**Plans:** `.claude/plans/` - Architectural decisions and migration plans

## Slash Commands

| Command | Description |
|---------|-------------|
| `/scaffold-module <name>` | Generate Clean Architecture module |
| `/validate-arch [module]` | Check architecture compliance |
| `/migrate-module <name>` | Migrate existing module |
| `/gen-usecase <module> <action> <type>` | Generate use case |
| `/gen-tests <module>` | Generate tests |

## Custom Agents

| Agent | Use For |
|-------|---------|
| `architecture-reviewer` | Code review for Clean Architecture |
| `migration-executor` | Execute migration tasks |
| `test-generator` | Generate unit/widget tests |
| `code-generator` | Generate boilerplate components |

## Quick Commands

```bash
flutter pub get                    # Install dependencies
flutter run                        # Run app
flutter pub run build_runner build # Generate code
flutter test                       # Run tests
flutter analyze                    # Analyze code
```

## Architecture

**Pattern:** Clean Architecture + GetX

**Data Flow:**
```
View (Obx) → Controller → UseCase → Repository → DataSource → API/Cache
```

**Module Structure:**
```
modules/{feature}/
├── data/           # Models, DataSources, Repository Impl
├── domain/         # Entities, Repository Interface, UseCases
└── presentation/   # Bindings, Controllers, Views, Widgets
```

## Key Directories

- `lib/app/core/` - Base classes (UseCase, Exceptions, Failures)
- `lib/app/data/` - Shared HTTP client, storage keys
- `lib/app/modules/` - Feature modules (agents, weapons, maps, home)
- `lib/app/utils/` - Theme, assets, strings
- `lib/app/widgets/` - Shared widgets
- `lib/app/routes/` - Navigation with GetX

## API

- **Base URL:** `https://valorant-api.com/v1`
- **Endpoints:** `/agents/`, `/maps/`, `/weapons/` (with `?language=pt-BR`)

## Coding Standards

- **Language:** English code, no comments
- **UI Text:** Portuguese (pt-BR)
- **Naming:** `i_repository.dart` (interface), `repository_impl.dart` (implementation)
- **UseCases:** `Get{Feature}UseCase`, `Save{Feature}UseCase`
