# Player Search Module

## Objetivo
Implementar um módulo de busca de jogadores usando a Henrik API (unofficial Valorant API) para exibir perfil, rank, estatísticas e histórico de partidas.

## API

**Base URL:** `https://api.henrikdev.xyz/valorant`

**Documentação:** https://docs.henrikdev.xyz/valorant.html

**Rate Limits:**
- Basic Key: 30 req/min (instantânea via Discord)
- Advanced Key: 90 req/min (24-48h aprovação)
- Sem key: 10 req/min (para testes)

## Endpoints Necessários

### 1. Account (Buscar jogador)
```
GET /v1/account/{name}/{tag}
```
**Response:**
```json
{
  "status": 200,
  "data": {
    "puuid": "string",
    "region": "br",
    "account_level": 150,
    "name": "PlayerName",
    "tag": "BR1",
    "card": {
      "small": "url",
      "large": "url",
      "wide": "url"
    },
    "last_update": "string",
    "last_update_raw": 1234567890
  }
}
```

### 2. MMR (Rank atual)
```
GET /v2/mmr/{region}/{name}/{tag}
```
**Response:**
```json
{
  "status": 200,
  "data": {
    "name": "string",
    "tag": "string",
    "current_data": {
      "currenttier": 21,
      "currenttierpatched": "Diamond 3",
      "ranking_in_tier": 45,
      "mmr_change_to_last_game": 22,
      "elo": 1845,
      "images": {
        "small": "url",
        "large": "url",
        "triangle_down": "url",
        "triangle_up": "url"
      }
    },
    "highest_rank": {
      "patched_tier": "Immortal 1",
      "tier": 24,
      "season": "e5a3"
    }
  }
}
```

### 3. Match History
```
GET /v3/matches/{region}/{name}/{tag}?size=5
```
**Response:**
```json
{
  "status": 200,
  "data": [
    {
      "metadata": {
        "map": "Ascent",
        "game_start_patched": "2024-01-15",
        "mode": "Competitive",
        "rounds_played": 24,
        "cluster": "Brazil"
      },
      "players": {
        "all_players": [
          {
            "puuid": "string",
            "name": "string",
            "tag": "string",
            "team": "Red",
            "character": "Jett",
            "stats": {
              "score": 5200,
              "kills": 22,
              "deaths": 15,
              "assists": 4
            },
            "assets": {
              "agent": {
                "small": "url",
                "full": "url"
              }
            }
          }
        ]
      },
      "teams": {
        "red": { "rounds_won": 13, "rounds_lost": 11 },
        "blue": { "rounds_won": 11, "rounds_lost": 13 }
      }
    }
  ]
}
```

### 4. MMR History (Histórico de rank)
```
GET /v1/mmr-history/{region}/{name}/{tag}
```

## Estrutura do Módulo

```
lib/app/modules/players/
├── data/
│   ├── datasources/
│   │   └── player_remote_datasource.dart
│   ├── models/
│   │   ├── player_account_model.dart
│   │   ├── player_mmr_model.dart
│   │   └── player_match_model.dart
│   └── repositories/
│       └── player_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── player_account_entity.dart
│   │   ├── player_mmr_entity.dart
│   │   └── player_match_entity.dart
│   ├── repositories/
│   │   └── i_player_repository.dart
│   └── usecases/
│       ├── search_player_usecase.dart
│       ├── get_player_mmr_usecase.dart
│       └── get_player_matches_usecase.dart
└── presentation/
    ├── bindings/
    │   └── players_binding.dart
    ├── controllers/
    │   └── players_controller.dart
    ├── views/
    │   ├── players_view.dart (busca)
    │   └── player_details_view.dart (perfil)
    └── widgets/
        ├── player_search_field.dart
        ├── player_card.dart
        ├── rank_badge.dart
        ├── match_history_card.dart
        └── stats_overview.dart
```

## Entities

### PlayerAccountEntity
```dart
class PlayerAccountEntity {
  final String puuid;
  final String name;
  final String tag;
  final String region;
  final int accountLevel;
  final String? cardSmall;
  final String? cardLarge;
  final String? cardWide;
}
```

### PlayerMmrEntity
```dart
class PlayerMmrEntity {
  final String name;
  final String tag;
  final int currentTier;
  final String currentTierName;
  final int rankingInTier;
  final int mmrChange;
  final int elo;
  final String? rankImageSmall;
  final String? rankImageLarge;
  final String? highestRank;
  final int? highestTier;
}
```

### PlayerMatchEntity
```dart
class PlayerMatchEntity {
  final String matchId;
  final String map;
  final String mode;
  final String gameDate;
  final int roundsPlayed;
  final String playerTeam;
  final String agent;
  final String agentIcon;
  final int kills;
  final int deaths;
  final int assists;
  final int score;
  final int teamRoundsWon;
  final int teamRoundsLost;
  final bool won;
}
```

## UI/UX

### Tela de Busca (players_view.dart)
- Campo de busca com placeholder "Nome#Tag"
- Validação do formato (deve conter #)
- Loading state animado
- Histórico de buscas recentes (GetStorage)
- Mensagem de erro amigável

### Tela de Perfil (player_details_view.dart)
1. **Header**
   - Player card como background
   - Nome e tag
   - Nível da conta
   - Região

2. **Rank Section**
   - Ícone do rank atual
   - Nome do rank + RR
   - Variação do último jogo (+/- RR)
   - Maior rank alcançado

3. **Stats Overview**
   - K/D médio
   - Win rate
   - Headshot %
   - Agente mais jogado

4. **Match History**
   - Lista de últimas partidas
   - Card com: Mapa, Agente, K/D/A, Resultado
   - Cor verde/vermelho para vitória/derrota

## Cores dos Ranks

```dart
Color getRankColor(int tier) {
  if (tier <= 3) return Colors.grey;        // Iron
  if (tier <= 6) return Colors.amber;       // Bronze
  if (tier <= 9) return Colors.blueGrey;    // Silver
  if (tier <= 12) return Colors.yellow;     // Gold
  if (tier <= 15) return Colors.teal;       // Platinum
  if (tier <= 18) return Colors.purple;     // Diamond
  if (tier <= 21) return Colors.red;        // Ascendant
  if (tier <= 24) return Colors.pink;       // Immortal
  return Colors.amber;                       // Radiant
}
```

## Rotas

```dart
// app_pages.dart
static const PLAYERS = '/players';
static const PLAYER_DETAILS = '/player-details';

GetPage(
  name: Routes.PLAYERS,
  page: () => const PlayersView(),
  binding: PlayersBinding(),
),
GetPage(
  name: Routes.PLAYER_DETAILS,
  page: () => const PlayerDetailsView(),
  binding: PlayersBinding(),
),
```

## Navegação

Adicionar item no menu lateral (home) ou bottom navigation:
- Ícone: `Icons.person_search` ou `Icons.search`
- Label: "Jogadores" ou "Buscar"

## Considerações

### API Key
- Para produção, obter API key no Discord do Henrik
- Armazenar key de forma segura (não no código)
- Implementar retry com backoff para rate limit

### Cache
- Cachear resultado de busca por 5 minutos
- Cachear MMR por 2 minutos
- Usar GetStorage para histórico de buscas

### Erros
- 404: Jogador não encontrado
- 429: Rate limit (mostrar "Tente novamente em X segundos")
- 500: Erro do servidor
- Timeout: Conexão lenta

### Offline
- Mostrar último resultado cacheado
- Indicar que dados podem estar desatualizados

## Tasks de Implementação

1. [ ] Criar estrutura de pastas do módulo
2. [ ] Implementar entities
3. [ ] Implementar models com fromJson
4. [ ] Criar datasource com Dio
5. [ ] Implementar repository
6. [ ] Criar use cases
7. [ ] Implementar controller
8. [ ] Criar widgets (search field, rank badge, match card)
9. [ ] Implementar players_view (busca)
10. [ ] Implementar player_details_view (perfil)
11. [ ] Adicionar rotas
12. [ ] Adicionar navegação no menu
13. [ ] Implementar cache e histórico
14. [ ] Testes e ajustes

## Referências

- Henrik API Docs: https://docs.henrikdev.xyz/valorant.html
- Henrik API Status: https://status.henrikdev.xyz/
- GitHub: https://github.com/Henrik-3/unofficial-valorant-api
