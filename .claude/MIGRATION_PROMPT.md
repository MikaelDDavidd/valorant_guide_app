# Clean Architecture Migration Prompt

Use this prompt to start the migration to Clean Architecture + GetX.

---

## Prompt

```
Você vai migrar este projeto Flutter para Clean Architecture + GetX.

## Contexto

1. Leia o CLAUDE.md na raiz do projeto para entender a estrutura e padrões
2. Leia .claude/plans/clean-architecture-migration.md para o plano detalhado
3. Leia .claude/docs/02-architecture.md para a arquitetura alvo

## Ferramentas Disponíveis

### Slash Commands
- `/scaffold-module <nome>` - Gera estrutura completa do módulo
- `/validate-arch [módulo]` - Valida compliance com Clean Architecture
- `/migrate-module <nome>` - Migra módulo existente
- `/gen-usecase <módulo> <ação> <tipo>` - Gera UseCase
- `/gen-tests <módulo>` - Gera testes

### Custom Agents
- `architecture-reviewer` - Revisa código para Clean Architecture
- `migration-executor` - Executa tarefas de migração
- `test-generator` - Gera testes unitários e de widget
- `code-generator` - Gera boilerplate (entity, model, repository, usecase)

## Requisitos

1. Use TodoWrite para planejar e trackear TODAS as tarefas
2. Siga a ordem de migração:
   - Phase 1: Core Setup (base classes)
   - Phase 2: Agents Module
   - Phase 3: Weapons Module
   - Phase 4: Maps Module
   - Phase 5: Home Module
   - Phase 6: Cleanup

3. Para cada módulo:
   - Use `/scaffold-module` para criar estrutura
   - Migre entity, model, repository, usecases, controller
   - Use `architecture-reviewer` agent para validar
   - Use `/gen-tests` para criar testes
   - Rode `flutter analyze` após cada fase

4. Regras:
   - NÃO delete arquivos antigos até os novos funcionarem
   - Mantenha backward compatibility durante migração
   - Commits git-friendly por fase
   - Código em inglês, sem comentários
   - UI text em português (pt-BR)

## Início

Comece criando o core/ com as classes base:
- lib/app/core/errors/exceptions.dart
- lib/app/core/errors/failures.dart
- lib/app/core/usecases/usecase.dart

Depois migre os módulos na ordem do plano.

Atualize o TodoWrite conforme progride.
```

---

## Como Usar

1. Copie o prompt acima
2. Cole no Claude Code
3. O Claude vai:
   - Criar todo list com todas as tarefas
   - Seguir o plano de migração
   - Usar os commands e agents disponíveis
   - Validar cada fase antes de prosseguir
