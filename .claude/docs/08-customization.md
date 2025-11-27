# Claude Code Customization

## Slash Commands

Available commands in `.claude/commands/`:

| Command | Description | Usage |
|---------|-------------|-------|
| `/scaffold-module` | Generate Clean Architecture module | `/scaffold-module agents` |
| `/validate-arch` | Check architecture compliance | `/validate-arch agents` |
| `/migrate-module` | Migrate existing module | `/migrate-module agents` |
| `/gen-usecase` | Generate a use case | `/gen-usecase agents get List<AgentEntity>` |
| `/gen-tests` | Generate tests for module | `/gen-tests agents` |

## Custom Agents

Available agents in `.claude/agents/`:

| Agent | Description | When to Use |
|-------|-------------|-------------|
| `architecture-reviewer` | Reviews Clean Architecture compliance | Code reviews, PR checks |
| `migration-executor` | Executes migration tasks | Migrating modules |
| `test-generator` | Generates unit/widget tests | After creating modules |
| `code-generator` | Generates boilerplate code | Quick component creation |

### Usage

```
Use the architecture-reviewer agent to check the agents module
```

```
Use the migration-executor agent to migrate weapons to Clean Architecture
```

## Recommended Hooks

Add to `~/.claude/settings.json`:

### Auto-format Dart files after edit

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart format $(echo $CLAUDE_FILE_PATH) 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

### Prevent writing outside Clean Architecture structure

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "if [[ \"$CLAUDE_FILE_PATH\" == */lib/app/models/* ]]; then echo 'Use modules/{name}/data/models/ instead'; exit 2; fi"
          }
        ]
      }
    ]
  }
}
```

### Run flutter analyze on Stop

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "flutter analyze lib/ 2>&1 | tail -10"
          }
        ]
      }
    ]
  }
}
```

## Hook Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success, continue |
| 1 | Warning, log and continue |
| 2 | Block the operation |

## Adding New Commands

1. Create `.claude/commands/command-name.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   description: What it does
   argument-hint: "<required> [optional]"
   allowed-tools: Tool1, Tool2
   ---
   ```
3. Write instructions in markdown

## Adding New Agents

1. Create `.claude/agents/agent-name.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   name: agent-name
   description: When to use this agent
   tools: Tool1, Tool2
   model: sonnet
   ---
   ```
3. Write agent system prompt
